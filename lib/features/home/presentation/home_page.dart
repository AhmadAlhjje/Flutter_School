import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/search.dart';
import '../../../shared/widgets/content_tile.dart';
import '../../../shared/widgets/search_field.dart';
import '../../../shared/widgets/state_views.dart';
import '../../auth/auth_providers.dart';
import '../../auth/presentation/auth_controller.dart';
import '../../learning_providers.dart';
import '../../subjects/presentation/subject_card_tile.dart';
import '../../videos/presentation/downloads_controller.dart';
import '../../videos/presentation/offline_library.dart';
import '../domain/home_entities.dart';

/// Home tab: a greeting, the student's open subjects, then the other (locked) subjects.
/// Without network it shows the last saved copy exactly as it was (plus the downloaded videos),
/// or only the downloaded videos if nothing was saved yet.
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final home = ref.watch(homeProvider);
    final auth = ref.watch(authControllerProvider);
    final offline = auth is AuthSignedIn && auth.offline;
    void reconnect() => ref.read(authControllerProvider.notifier).reconnect();

    return Scaffold(
      appBar: AppBar(title: Text(home.value?.instituteName ?? l10n.appTitle)),
      body: RefreshIndicator(
        onRefresh: offline
            ? () => ref.read(authControllerProvider.notifier).reconnect()
            : () => ref.refresh(homeProvider.future),
        child: offline && home.hasError && !home.hasValue
            ? _OfflineHome(onRetry: reconnect)
            : AsyncValueView<HomeSummary>(
                value: home,
                onRetry: () => ref.invalidate(homeProvider),
                data: (summary) => _HomeContent(summary: summary, offline: offline),
              ),
      ),
    );
  }
}

class _HomeContent extends StatefulWidget {
  const _HomeContent({required this.summary, this.offline = false});

  final HomeSummary summary;

  /// The content is the saved copy (no network).
  final bool offline;

  @override
  State<_HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<_HomeContent> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final summary = widget.summary;
    final shown = summary.subjects.where((subject) => matchesSearch(subject.name, _query));
    final open = shown.where((subject) => !subject.locked).toList();
    final locked = shown.where((subject) => subject.locked).toList();
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      children: [
        _Greeting(name: summary.studentName.split(' ').first),
        if (summary.subjects.isEmpty) const _NoSubjects(),
        if (summary.subjects.length >= minItemsForSearch) ...[
          const SizedBox(height: 16),
          SearchField(hint: l10n.findSubject, onChanged: (value) => setState(() => _query = value)),
          if (open.isEmpty && locked.isEmpty) EmptyView(message: l10n.searchNoResults, icon: Icons.search_off_rounded),
        ],
        if (open.isNotEmpty) ...[SectionTitle(l10n.mySubjects), SubjectList(subjects: open)],
        if (locked.isNotEmpty) ...[
          SectionTitle(l10n.otherSubjects),
          Padding(padding: const EdgeInsets.only(bottom: 12), child: HintLine(l10n.otherSubjectsHint)),
          SubjectList(subjects: locked),
        ],
        if (widget.offline) const _DownloadsOnPhone(),
      ],
    );
  }
}

/// Offline: the downloaded videos as well, under the subjects (only when there are some).
class _DownloadsOnPhone extends ConsumerWidget {
  const _DownloadsOnPhone();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final any = ref.watch(offlineVideosProvider).value?.isNotEmpty ?? false;
    if (!any) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [SectionTitle(AppLocalizations.of(context).offlineDownloads), const OfflineLibrary()],
    );
  }
}

class _Greeting extends StatelessWidget {
  const _Greeting({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.helloName(name),
            style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          Text(l10n.homeSubtitle, style: const TextStyle(color: Color(0xDDFFFFFF), fontSize: 14)),
        ],
      ),
    );
  }
}

/// A new account (e.g. just registered): nothing is open yet — say what happens next.
class _NoSubjects extends ConsumerWidget {
  const _NoSubjects();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final phone = ref.watch(publicConfigProvider).value?.institutePhone;
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 34,
                backgroundColor: AppColors.primarySoft,
                child: Icon(Icons.hourglass_top_rounded, color: AppColors.primary, size: 32),
              ),
              const SizedBox(height: 16),
              Text(
                l10n.noSubjectsTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.noSubjectsBody,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.secondary, height: 1.6),
              ),
              if (phone != null && phone.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  l10n.contactInstitute(phone),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.primary),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Offline with nothing saved yet (e.g. first start without network): the videos downloaded on
/// this device, organized by subject.
class _OfflineHome extends StatelessWidget {
  const _OfflineHome({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: AppColors.muted, borderRadius: BorderRadius.circular(14)),
          child: Row(
            children: [
              const Icon(Icons.wifi_off_rounded, color: AppColors.secondary),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.offlineTitle, style: const TextStyle(fontWeight: FontWeight.w700)),
                    Text(l10n.offlineBody, style: const TextStyle(color: AppColors.secondary, fontSize: 13)),
                  ],
                ),
              ),
              TextButton(onPressed: onRetry, child: Text(l10n.retry)),
            ],
          ),
        ),
        const OfflineLibrary(),
      ],
    );
  }
}
