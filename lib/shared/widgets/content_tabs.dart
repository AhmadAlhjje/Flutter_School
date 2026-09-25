import 'package:flutter/material.dart';

import '../../core/l10n/app_localizations.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/search.dart';
import 'content_tile.dart';
import 'search_field.dart';
import 'state_views.dart';

/// One tab of a [TabbedContent] page, e.g. "الفيديوهات" with its list.
class ContentTab {
  ContentTab({
    required this.label,
    required this.items,
    required this.emptyMessage,
    this.emptyIcon = Icons.inbox_outlined,
    this.hint,
    this.searchHint,
    this.searchKeys,
  }) : assert(searchKeys == null || searchKeys.length == items.length, 'one search key per item');

  final String label;
  final List<Widget> items;
  final String emptyMessage;
  final IconData emptyIcon;

  /// What to do in this list (e.g. "اختر الدرس"), shown above the items.
  final String? hint;

  /// Search by name: the box's hint, and the text each item is matched on. The box appears
  /// once the list is long enough to need it ([minItemsForSearch]).
  final String? searchHint;
  final List<String>? searchKeys;

  bool get searchable => searchHint != null && searchKeys != null && items.length >= minItemsForSearch;
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
    if (tabs.length == 1) {
      return _TabList(tab: tabs.single, onRefresh: onRefresh, header: header);
    }
    return DefaultTabController(
      length: tabs.length,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(padding: const EdgeInsets.fromLTRB(16, 8, 16, 12), child: header),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _SegmentedTabBar(tabs: tabs),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: TabBarView(
              children: [for (final tab in tabs) _TabList(tab: tab, onRefresh: onRefresh)],
            ),
          ),
        ],
      ),
    );
  }
}

/// A tab's list: optional search box, the "what to do" hint, then the items.
class _TabList extends StatefulWidget {
  const _TabList({required this.tab, required this.onRefresh, this.header});

  final ContentTab tab;
  final Future<void> Function() onRefresh;

  /// Single-tab pages: the page header scrolls with the list.
  final Widget? header;

  @override
  State<_TabList> createState() => _TabListState();
}

class _TabListState extends State<_TabList> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final tab = widget.tab;
    final keys = tab.searchKeys;
    final items = tab.searchable && _query.isNotEmpty
        ? [
            for (var i = 0; i < tab.items.length; i++)
              if (matchesSearch(keys![i], _query)) tab.items[i],
          ]
        : tab.items;
    final rows = <Widget>[
      if (tab.searchable) SearchField(hint: tab.searchHint!, onChanged: (value) => setState(() => _query = value)),
      if (tab.hint != null && items.isNotEmpty) HintLine(tab.hint!),
      ...items,
    ];
    final header = widget.header;
    return RefreshIndicator(
      onRefresh: widget.onRefresh,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          if (header != null) ...[header, const SizedBox(height: 12)],
          if (tab.items.isEmpty)
            EmptyView(message: tab.emptyMessage, icon: tab.emptyIcon)
          else ...[
            for (final (index, row) in rows.indexed) ...[if (index > 0) const SizedBox(height: 10), row],
            if (items.isEmpty)
              EmptyView(message: AppLocalizations.of(context).searchNoResults, icon: Icons.search_off_rounded),
          ],
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
