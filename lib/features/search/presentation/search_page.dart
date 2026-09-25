import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/router/routes.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/widgets/content_tile.dart';
import '../../../shared/widgets/state_views.dart';
import '../../learning_providers.dart';
import '../../subjects/presentation/subject_page.dart';
import '../domain/search_entities.dart';

/// The query being searched, set after the user stops typing (debounced).
class SearchQuery extends Notifier<String> {
  @override
  String build() => '';

  void set(String value) => state = value.trim();
}

final searchQueryProvider = NotifierProvider.autoDispose<SearchQuery, String>(SearchQuery.new);

/// Search across what the student can see (spec §79). Results only include content the
/// server allows; locked teachers are listed with their lock.
class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final _input = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _input.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () => ref.read(searchQueryProvider.notifier).set(value));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final query = ref.watch(searchQueryProvider);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: TextField(
          controller: _input,
          autofocus: true,
          textInputAction: TextInputAction.search,
          onChanged: _onChanged,
          onSubmitted: (value) => ref.read(searchQueryProvider.notifier).set(value),
          decoration: InputDecoration(
            hintText: l10n.searchHint,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            filled: false,
          ),
        ),
      ),
      body: query.length < 2
          ? EmptyView(message: l10n.searchMinChars, icon: Icons.search_rounded)
          : _Results(query: query),
    );
  }
}

class _Results extends ConsumerWidget {
  const _Results({required this.query});

  final String query;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final results = ref.watch(searchResultsProvider(query));
    return AsyncValueView<SearchResults>(
      value: results,
      onRetry: () => ref.invalidate(searchResultsProvider(query)),
      data: (data) {
        if (data.isEmpty) return EmptyView(message: l10n.searchNoResults, icon: Icons.search_off_rounded);
        return ListView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          children: [
            if (data.subjects.isNotEmpty) ...[
              SectionTitle(l10n.searchSubjects),
              for (final subject in data.subjects) ...[
                ContentTile(
                  title: subject.name,
                  subtitle: subject.gradeName,
                  locked: subject.locked,
                  onTap: () => context.push(Routes.subject(subject.id)),
                ),
                const SizedBox(height: 10),
              ],
            ],
            if (data.teachers.isNotEmpty) ...[
              SectionTitle(l10n.searchTeachers),
              for (final teacher in data.teachers) ...[TeacherTile(teacher: teacher), const SizedBox(height: 10)],
            ],
            if (data.topics.isNotEmpty) ...[
              SectionTitle(l10n.searchLessons),
              for (final hit in data.topics) ...[
                _HitTile(hit: hit, icon: Icons.bookmark_outline_rounded, route: Routes.topic(hit.id)),
                const SizedBox(height: 10),
              ],
            ],
            if (data.sessions.isNotEmpty) ...[
              SectionTitle(l10n.searchSessions),
              for (final hit in data.sessions) ...[
                _HitTile(hit: hit, icon: Icons.play_lesson_outlined, route: Routes.session(hit.id)),
                const SizedBox(height: 10),
              ],
            ],
            if (data.videos.isNotEmpty) ...[
              SectionTitle(l10n.searchVideos),
              for (final hit in data.videos) ...[
                _HitTile(hit: hit, icon: Icons.play_circle_outline_rounded, route: Routes.player(hit.id)),
                const SizedBox(height: 10),
              ],
            ],
          ],
        );
      },
    );
  }
}

class _HitTile extends StatelessWidget {
  const _HitTile({required this.hit, required this.icon, required this.route});

  final SearchHit hit;
  final IconData icon;
  final String route;

  @override
  Widget build(BuildContext context) {
    final duration = hit.durationSeconds;
    return ContentTile(
      title: hit.title,
      subtitle: duration != null ? formatDuration(Duration(seconds: duration)) : null,
      icon: icon,
      onTap: () => context.push(route),
    );
  }
}
