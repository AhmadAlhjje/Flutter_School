import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../learning_providers.dart';
import '../../notifications/presentation/notifications_page.dart';

/// The app's main frame: the current tab and a labeled bottom bar
/// (Home · Search · Notifications · My account).
class MainShell extends ConsumerWidget {
  const MainShell({super.key, required this.shell});

  final StatefulNavigationShell shell;

  static const _notificationsTab = 2;

  void _select(WidgetRef ref, int index) {
    // Opening a tab shows fresh data; tapping the current tab again returns to its start.
    if (index == 0) ref.invalidate(homeProvider);
    if (index == _notificationsTab) ref.invalidate(notificationsControllerProvider);
    ref.invalidate(unreadCountProvider);
    shell.goBranch(index, initialLocation: index == shell.currentIndex);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final unread = ref.watch(unreadCountProvider).value ?? 0;
    return Scaffold(
      body: shell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: shell.currentIndex,
        onDestinationSelected: (index) => _select(ref, index),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home_rounded),
            label: l10n.navHome,
          ),
          NavigationDestination(
            icon: const Icon(Icons.search_rounded),
            selectedIcon: const Icon(Icons.saved_search_rounded),
            label: l10n.search,
          ),
          NavigationDestination(
            icon: Badge(
              isLabelVisible: unread > 0,
              label: Text('$unread'),
              child: const Icon(Icons.notifications_none_rounded),
            ),
            selectedIcon: Badge(
              isLabelVisible: unread > 0,
              label: Text('$unread'),
              child: const Icon(Icons.notifications_rounded),
            ),
            label: l10n.notifications,
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outline_rounded),
            selectedIcon: const Icon(Icons.person_rounded),
            label: l10n.navAccount,
          ),
        ],
      ),
    );
  }
}
