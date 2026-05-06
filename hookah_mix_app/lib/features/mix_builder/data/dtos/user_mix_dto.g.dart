// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_mix_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MixComponentDto _$MixComponentDtoFromJson(Map<String, dynamic> json) => MixComponentDto(
  tobaccoId: json['tobaccoId'] as String,
  tobaccoName: json['tobaccoName'] as String,
  percentage: (json['percentage'] as num).toInt(),
);

Map<String, dynamic> _$MixComponentDtoToJson(MixComponentDto instance) => <String, dynamic>{
  'tobaccoId': instance.tobaccoId,
  'tobaccoName': instance.tobaccoName,
  'percentage': instance.percentage,
};

TasteProfileDto3 _$TasteProfileDto3FromJson(Map<String, dynamic> json) => TasteProfileDto3(
  sweet: (json['sweet'] as num?)?.toInt() ?? 0,
  sour: (json['sour'] as num?)?.toInt() ?? 0,
  fresh: (json['fresh'] as num?)?.toInt() ?? 0,
  spicy: (json['spicy'] as num?)?.toInt() ?? 0,
  bitter: (json['bitter'] as num?)?.toInt() ?? 0,
  floral: (json['floral'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$TasteProfileDto3ToJson(TasteProfileDto3 instance) => <String, dynamic>{
  'sweet': instance.sweet,
  'sour': instance.sour,
  'fresh': instance.fresh,
  'spicy': instance.spicy,
  'bitter': instance.bitter,
  'floral': instance.floral,
};
