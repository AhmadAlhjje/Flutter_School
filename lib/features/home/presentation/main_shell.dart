import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../learning_providers.dart';
import '../../notifications/presentation/notifications_page.dart';

/// The app's main frame: the current tab and the bottom bar
/// (My videos · Search · [Home, raised in the middle] · Notifications · My account).
class MainShell extends ConsumerWidget {
  const MainShell({super.key, required this.shell});

  final StatefulNavigationShell shell;

  static const homeTab = 2;
  static const notificationsTab = 3;

  void _select(WidgetRef ref, int index) {
    // Opening a tab shows fresh data; tapping the current tab again returns to its start.
    if (index == homeTab) ref.invalidate(homeProvider);
    if (index == notificationsTab) ref.invalidate(notificationsControllerProvider);
    ref.invalidate(unreadCountProvider);
    shell.goBranch(index, initialLocation: index == shell.currentIndex);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unread = ref.watch(unreadCountProvider).value ?? 0;
    return Scaffold(
      body: shell,
      bottomNavigationBar: MainBottomBar(
        currentIndex: shell.currentIndex,
        unreadNotifications: unread,
        onSelect: (index) => _select(ref, index),
      ),
    );
  }
}

/// Five tabs; Home sits in the middle as a raised round button that stands above the bar.
class MainBottomBar extends StatelessWidget {
  const MainBottomBar({super.key, required this.currentIndex, required this.onSelect, this.unreadNotifications = 0});

  final int currentIndex;
  final int unreadNotifications;
  final ValueChanged<int> onSelect;

  static const _raise = 26.0;
  static const _barHeight = 68.0;
  static const _homeSize = 66.0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    Widget item(int index, IconData icon, IconData selectedIcon, String label, {int badge = 0}) => Expanded(
      child: _BarItem(
        icon: icon,
        selectedIcon: selectedIcon,
        label: label,
        selected: currentIndex == index,
        badge: badge,
        onTap: () => onSelect(index),
      ),
    );

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          margin: const EdgeInsets.only(top: _raise),
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            boxShadow: [BoxShadow(color: Color(0x0F0F172A), blurRadius: 12, offset: Offset(0, -2))],
          ),
          child: SafeArea(
            top: false,
            child: SizedBox(
              height: _barHeight,
              child: Row(
                children: [
                  item(0, Icons.smart_display_outlined, Icons.smart_display_rounded, l10n.navHistory),
                  item(1, Icons.search_rounded, Icons.saved_search_rounded, l10n.search),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: _Label(text: l10n.navHome, selected: currentIndex == 2),
                      ),
                    ),
                  ),
                  item(
                    3,
                    Icons.notifications_none_rounded,
                    Icons.notifications_rounded,
                    l10n.notifications,
                    badge: unreadNotifications,
                  ),
                  item(4, Icons.person_outline_rounded, Icons.person_rounded, l10n.navAccount),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          child: _HomeButton(
            size: _homeSize,
            selected: currentIndex == 2,
            label: l10n.navHome,
            onTap: () => onSelect(2),
          ),
        ),
      ],
    );
  }
}

class _HomeButton extends StatelessWidget {
  const _HomeButton({required this.size, required this.selected, required this.label, required this.onTap});

  final double size;
  final bool selected;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      excludeSemantics: true,
      child: AnimatedScale(
        scale: selected ? 1 : 0.92,
        duration: const Duration(milliseconds: 200),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Color(0xFF3B82F6), AppColors.primaryDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(color: AppColors.surface, width: 5),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: selected ? 0.28 : 0.18),
                blurRadius: 12,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Material(
            type: MaterialType.transparency,
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onTap,
              child: Icon(selected ? Icons.home_rounded : Icons.home_outlined, color: Colors.white, size: 30),
            ),
          ),
        ),
      ),
    );
  }
}

class _BarItem extends StatelessWidget {
  const _BarItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.selected,
    required this.onTap,
    this.badge = 0,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final bool selected;
  final int badge;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.primary : AppColors.secondary;
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      excludeSemantics: true,
      child: InkResponse(
        onTap: onTap,
        radius: 36,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 52,
              height: 30,
              decoration: BoxDecoration(
                color: selected ? AppColors.primarySoft : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Badge(
                isLabelVisible: badge > 0,
                label: Text('$badge'),
                child: Icon(selected ? selectedIcon : icon, color: color, size: 24),
              ),
            ),
            const SizedBox(height: 4),
            _Label(text: label, selected: selected),
          ],
        ),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label({required this.text, required this.selected});

  final String text;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.fade,
      softWrap: false,
      style: TextStyle(
        fontSize: 11.5,
        fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
        color: selected ? AppColors.primary : AppColors.secondary,
      ),
    );
  }
}
