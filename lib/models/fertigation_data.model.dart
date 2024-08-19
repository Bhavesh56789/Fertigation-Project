import 'package:json_annotation/json_annotation.dart';

part 'fertigation_data.model.g.dart';

@JsonSerializable()
class FertigationDataModel {
  FertigationDataModel({
    this.device,
    this.fertigation,
    this.mode,
    this.post_mix,
    this.pre_mix,
    this.volume,
  });

  factory FertigationDataModel.fromJson(Map<String, dynamic> json) =>
      _$FertigationDataModelFromJson(json);

  String? device;
  int? volume;
  String? mode;
  int? pre_mix;
  int? post_mix;
  int? fertigation;

  FertigationDataModel copyWith({
    String? device,
    int? volume,
    String? mode,
    int? pre_mix,
    int? post_mix,
    int? fertigation,
  }) {
    return FertigationDataModel(
      device: device ?? this.device,
      volume: volume ?? this.volume,
      mode: mode ?? this.mode,
      pre_mix: pre_mix ?? this.pre_mix,
      post_mix: post_mix ?? this.post_mix,
      fertigation: fertigation ?? this.fertigation,
    );
  }
}
