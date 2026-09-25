import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import 'content_tile.dart';
import 'state_views.dart';

/// One tab of a [TabbedContent] page, e.g. "الفيديوهات" with its list.
class ContentTab {
  const ContentTab({
    required this.label,
    required this.items,
    required this.emptyMessage,
    this.emptyIcon = Icons.inbox_outlined,
    this.hint,
  });

  final String label;
  final List<Widget> items;
  final String emptyMessage;
  final IconData emptyIcon;

  /// What to do in this list (e.g. "اختر الدرس"), shown above the items.
  final String? hint;

  /// The rows to show: the hint first, then the items.
  List<Widget> get rows => [if (hint != null && items.isNotEmpty) HintLine(hint!), ...items];
}

/// A page header followed by segmented tabs (e.g. Videos | Files); each tab is its own list with
/// pull-to-refresh. With a single tab the bar is hidden and the list shows directly.
class TabbedContent extends StatelessWidget {
  const TabbedContent({super.key, required this.header, required this.tabs, required this.onRefresh});

  final Widget header;
  final List<ContentTab> tabs;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    final headerBlock = Padding(padding: const EdgeInsets.fromLTRB(16, 8, 16, 12), child: header);
    if (tabs.length == 1) {
      return RefreshIndicator(
        onRefresh: onRefresh,
        child: ListView(
          padding: const EdgeInsets.only(bottom: 24),
          children: [
            headerBlock,
            if (tabs.single.items.isEmpty)
              EmptyView(message: tabs.single.emptyMessage, icon: tabs.single.emptyIcon)
            else
              for (final item in tabs.single.rows)
                Padding(padding: const EdgeInsets.fromLTRB(16, 0, 16, 10), child: item),
          ],
        ),
      );
    }
    return DefaultTabController(
      length: tabs.length,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          headerBlock,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _SegmentedTabBar(tabs: tabs),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: TabBarView(
              children: [
                for (final tab in tabs)
                  RefreshIndicator(
                    onRefresh: onRefresh,
                    child: tab.items.isEmpty
                        ? ListView(
                            children: [EmptyView(message: tab.emptyMessage, icon: tab.emptyIcon)],
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                            itemCount: tab.rows.length,
                            separatorBuilder: (_, _) => const SizedBox(height: 10),
                            itemBuilder: (_, index) => tab.rows[index],
                          ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SegmentedTabBar extends StatelessWidget {
  const _SegmentedTabBar({required this.tabs});

  final List<ContentTab> tabs;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: AppColors.muted, borderRadius: BorderRadius.circular(14)),
      child: TabBar(
        dividerColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [BoxShadow(color: Color(0x140F172A), blurRadius: 4, offset: Offset(0, 1))],
        ),
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.secondary,
        labelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        splashBorderRadius: BorderRadius.circular(10),
        tabs: [
          for (final tab in tabs)
            Tab(
              height: 42,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(tab.label),
                  const SizedBox(width: 6),
                  _CountBadge(count: tab.items.length),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _CountBadge extends StatelessWidget {
  const _CountBadge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 1),
      decoration: BoxDecoration(color: AppColors.primarySoft, borderRadius: BorderRadius.circular(20)),
      child: Text(
        '$count',
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.primary),
      ),
    );
  }
}
