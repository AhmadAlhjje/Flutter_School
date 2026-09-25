import 'package:freezed_annotation/freezed_annotation.dart';

import '../../grades/domain/grade_entities.dart';
import '../../subjects/domain/subject_entities.dart';

part 'home_entities.freezed.dart';

@freezed
abstract class HomeSummary with _$HomeSummary {
  const factory HomeSummary({
    required String studentName,
    required String instituteName,
    required int unreadNotifications,
    required List<SubjectCard> subjects,
    required List<GradeSummary> grades,
  }) = _HomeSummary;
}

abstract interface class HomeRepository {
  Future<HomeSummary> home();
}
