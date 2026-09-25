import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/video_entities.dart';

part 'video_models.freezed.dart';
part 'video_models.g.dart';

@freezed
abstract class VideoItemModel with _$VideoItemModel {
  const factory VideoItemModel({required String id, required String title, String? description, int? durationSeconds}) =
      _VideoItemModel;

  const VideoItemModel._();

  factory VideoItemModel.fromJson(Map<String, Object?> json) => _$VideoItemModelFromJson(json);

  VideoItem toEntity() => VideoItem(id: id, title: title, description: description, durationSeconds: durationSeconds);
}

List<VideoItem> parseVideoItems(Object? data) =>
    (data as List? ?? const []).map((json) => VideoItemModel.fromJson((json as Map).cast()).toEntity()).toList();

/// `/student/videos/:id/playback`
PlaybackGrant parsePlaybackGrant(Map<String, Object?> json) {
  final watermark = json['watermark'] as Map?;
  return PlaybackGrant(
    videoId: json['videoId']! as String,
    title: json['title']! as String,
    manifestUrl: Uri.parse(json['manifestUrl']! as String),
    expiresAt: DateTime.parse(json['expiresAt']! as String),
    durationSeconds: (json['durationSeconds'] as num?)?.toInt(),
    watermarkText: watermark?['text'] as String?,
  );
}

/// One HLS rendition offered for offline download.
class RenditionModel {
  const RenditionModel({required this.name, required this.height, required this.bandwidth, required this.playlistUrl});

  factory RenditionModel.fromJson(Map<String, Object?> json) => RenditionModel(
    name: json['name']! as String,
    height: (json['height']! as num).toInt(),
    bandwidth: (json['bandwidth']! as num).toInt(),
    playlistUrl: Uri.parse(json['playlistUrl']! as String),
  );

  final String name;
  final int height;
  final int bandwidth;
  final Uri playlistUrl;
}

/// `/student/videos/:id/offline-license`
class OfflineLicenseModel {
  const OfflineLicenseModel({
    required this.licenseId,
    required this.videoId,
    required this.title,
    required this.expiresAt,
    required this.renditions,
    this.durationSeconds,
  });

  factory OfflineLicenseModel.fromJson(Map<String, Object?> json) => OfflineLicenseModel(
    licenseId: json['licenseId']! as String,
    videoId: json['videoId']! as String,
    title: json['title']! as String,
    expiresAt: DateTime.parse(json['expiresAt']! as String),
    durationSeconds: (json['durationSeconds'] as num?)?.toInt(),
    renditions: (json['renditions']! as List).map((item) => RenditionModel.fromJson((item as Map).cast())).toList(),
  );

  final String licenseId;
  final String videoId;
  final String title;
  final DateTime expiresAt;
  final int? durationSeconds;
  final List<RenditionModel> renditions;
}
