// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fertigation_data.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FertigationDataModel _$FertigationDataModelFromJson(
        Map<String, dynamic> json) =>
    FertigationDataModel(
      device: json['device'] as String?,
      fertigation: json['fertigation'] as int?,
      mode: json['mode'] as String?,
      post_mix: json['post_mix'] as int?,
      pre_mix: json['pre_mix'] as int?,
      volume: json['volume'] as int?,
    );

Map<String, dynamic> _$FertigationDataModelToJson(
        FertigationDataModel instance) =>
    <String, dynamic>{
      'device': instance.device,
      'volume': instance.volume,
      'mode': instance.mode,
      'pre_mix': instance.pre_mix,
      'post_mix': instance.post_mix,
      'fertigation': instance.fertigation,
    };
