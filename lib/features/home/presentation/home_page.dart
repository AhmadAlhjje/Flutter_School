import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/router/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/content_tile.dart';
import '../../../shared/widgets/state_views.dart';
import '../../auth/presentation/auth_controller.dart';
import '../../learning_providers.dart';
import '../../subjects/presentation/subject_card_tile.dart';
import '../domain/home_entities.dart';

/// Home (spec §70): greeting, the student's subjects with lock state, grades to browse.
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final home = ref.watch(homeProvider);
    final auth = ref.watch(authControllerProvider);
    final offline = auth is AuthSignedIn && auth.offline;

    return Scaffold(
      appBar: AppBar(
        title: Text(home.value?.instituteName ?? l10n.appTitle),
        actions: [
          IconButton(
            tooltip: l10n.search,
            icon: const Icon(Icons.search_rounded),
            onPressed: () => context.push(Routes.search),
          ),
          _NotificationsButton(count: home.value?.unreadNotifications ?? 0),
          IconButton(
            tooltip: l10n.profile,
            icon: const Icon(Icons.person_outline_rounded),
            onPressed: () => context.push(Routes.profile),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: offline
            ? () => ref.read(authControllerProvider.notifier).reconnect()
            : () => ref.refresh(homeProvider.future),
        child: offline
            ? _OfflineHome(onRetry: () => ref.read(authControllerProvider.notifier).reconnect())
            : AsyncValueView<HomeSummary>(
                value: home,
                onRetry: () => ref.invalidate(homeProvider),
                data: (summary) => _HomeContent(summary: summary),
              ),
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({required this.summary});

  final HomeSummary summary;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final firstName = summary.studentName.split(' ').first;
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      children: [
        Text(l10n.helloName(firstName), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
        SectionTitle(l10n.yourSubjects),
        if (summary.subjects.isEmpty)
          EmptyView(message: l10n.noSubjects, icon: Icons.menu_book_outlined)
        else
          SubjectGrid(subjects: summary.subjects),
        SectionTitle(l10n.browseGrades),
        for (final grade in summary.grades) ...[
          ContentTile(
            title: grade.name,
            subtitle: l10n.subjectsCount(grade.subjectsCount),
            icon: Icons.layers_outlined,
            onTap: () => context.push(Routes.grade(grade.id)),
          ),
          const SizedBox(height: 10),
        ],
        const SizedBox(height: 8),
        ContentTile(
          title: l10n.downloads,
          icon: Icons.download_done_rounded,
          onTap: () => context.push(Routes.downloads),
        ),
      ],
    );
  }
}

class _NotificationsButton extends StatelessWidget {
  const _NotificationsButton({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: AppLocalizations.of(context).notifications,
      onPressed: () => context.push(Routes.notifications),
      icon: Badge(
        isLabelVisible: count > 0,
        label: Text('$count'),
        child: const Icon(Icons.notifications_none_rounded),
      ),
    );
  }
}

/// Started without network: only downloaded videos are available.
class _OfflineHome extends StatelessWidget {
  const _OfflineHome({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const SizedBox(height: 40),
        const Icon(Icons.wifi_off_rounded, size: 48, color: AppColors.secondary),
        const SizedBox(height: 12),
        Text(
          l10n.errorNetwork,
          textAlign: TextAlign.center,
          style: const TextStyle(color: AppColors.secondary),
        ),
        const SizedBox(height: 24),
        FilledButton.icon(
          onPressed: () => context.push(Routes.downloads),
          icon: const Icon(Icons.download_done_rounded),
          label: Text(l10n.downloads),
        ),
        const SizedBox(height: 12),
        OutlinedButton(onPressed: onRetry, child: Text(l10n.retry)),
      ],
    );
  }
}
