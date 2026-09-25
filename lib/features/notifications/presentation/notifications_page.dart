import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/router/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/widgets/state_views.dart';
import '../../catalog_repositories.dart';
import '../../learning_providers.dart';
import '../domain/notification_entities.dart';

/// The student's inbox (spec §78), newest first, paged.
class NotificationsController extends AsyncNotifier<InboxPage> {
  @override
  Future<InboxPage> build() => ref.watch(notificationsRepositoryProvider).inbox();

  bool get hasMore {
    final page = state.value;
    return page != null && page.page < page.totalPages;
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || !hasMore) return;
    final next = await ref.read(notificationsRepositoryProvider).inbox(page: current.page + 1);
    state = AsyncData(next.copyWith(items: [...current.items, ...next.items]));
  }

  Future<void> markRead(InboxNotification notification) async {
    if (!notification.unread) return;
    await ref.read(notificationsRepositoryProvider).markRead(notification.id);
    _replaceAll((item) => item.id == notification.id ? item.copyWith(readAt: DateTime.now()) : item);
  }

  Future<void> markAllRead() async {
    await ref.read(notificationsRepositoryProvider).markAllRead();
    final now = DateTime.now();
    _replaceAll((item) => item.unread ? item.copyWith(readAt: now) : item);
  }

  void _replaceAll(InboxNotification Function(InboxNotification) update) {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(current.copyWith(items: current.items.map(update).toList()));
    ref.invalidate(homeProvider);
    ref.invalidate(unreadCountProvider);
  }
}

final notificationsControllerProvider = AsyncNotifierProvider.autoDispose<NotificationsController, InboxPage>(
  NotificationsController.new,
);

class NotificationsPage extends ConsumerWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final inbox = ref.watch(notificationsControllerProvider);
    final controller = ref.read(notificationsControllerProvider.notifier);
    final hasUnread = inbox.value?.items.any((item) => item.unread) ?? false;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.notifications),
        actions: [
          if (hasUnread)
            IconButton(
              tooltip: l10n.markAllRead,
              icon: const Icon(Icons.done_all_rounded),
              onPressed: controller.markAllRead,
            ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(notificationsControllerProvider.future),
        child: AsyncValueView<InboxPage>(
          value: inbox,
          onRetry: () => ref.invalidate(notificationsControllerProvider),
          data: (page) => page.items.isEmpty
              ? ListView(
                  children: [EmptyView(message: l10n.noNotifications, icon: Icons.notifications_none_rounded)],
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: page.items.length + (controller.hasMore ? 1 : 0),
                  separatorBuilder: (_, _) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    if (index == page.items.length) {
                      return Center(
                        child: TextButton(onPressed: controller.loadMore, child: Text(l10n.loadMore)),
                      );
                    }
                    final item = page.items[index];
                    return _NotificationTile(
                      notification: item,
                      onTap: () {
                        unawaited(controller.markRead(item));
                        final sessionId = item.sessionId;
                        final subjectId = item.subjectId;
                        if (sessionId != null) {
                          unawaited(context.push(Routes.session(sessionId)));
                        } else if (subjectId != null) {
                          unawaited(context.push(Routes.subject(subjectId)));
                        }
                      },
                    );
                  },
                ),
        ),
      ),
    );
  }
}

IconData _kindIcon(NotificationKind kind) => switch (kind) {
  NotificationKind.newLesson => Icons.menu_book_rounded,
  NotificationKind.newVideo => Icons.play_circle_outline_rounded,
  NotificationKind.newFile => Icons.description_outlined,
  NotificationKind.account => Icons.person_outline_rounded,
  NotificationKind.system => Icons.campaign_outlined,
};

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({required this.notification, required this.onTap});

  final InboxNotification notification;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final unread = notification.unread;
    return Card(
      color: unread ? AppColors.primarySoft : null,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: unread ? AppColors.surface : AppColors.muted,
                child: Icon(_kindIcon(notification.kind), color: unread ? AppColors.primary : AppColors.secondary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(notification.title, style: TextStyle(fontWeight: unread ? FontWeight.w700 : FontWeight.w600)),
                    const SizedBox(height: 2),
                    Text(notification.body, style: const TextStyle(color: AppColors.secondary, height: 1.5)),
                    const SizedBox(height: 4),
                    Text(
                      formatDateTime(notification.createdAt, locale),
                      style: const TextStyle(color: AppColors.secondary, fontSize: 12),
                    ),
                  ],
                ),
              ),
              if (unread)
                const Padding(
                  padding: EdgeInsets.only(top: 6),
                  child: CircleAvatar(radius: 4, backgroundColor: AppColors.primary),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
