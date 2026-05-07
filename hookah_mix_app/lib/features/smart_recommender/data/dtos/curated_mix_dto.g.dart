// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'curated_mix_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MixComponentDto _$MixComponentDtoFromJson(Map<String, dynamic> json) =>
    MixComponentDto(
      tobaccoId: json['tobaccoId'] as String,
      percentage: (json['percentage'] as num).toInt(),
    );

Map<String, dynamic> _$MixComponentDtoToJson(MixComponentDto instance) =>
    <String, dynamic>{
      'tobaccoId': instance.tobaccoId,
      'percentage': instance.percentage,
    };

TasteProfileDto2 _$TasteProfileDto2FromJson(Map<String, dynamic> json) =>
    TasteProfileDto2(
      sweet: (json['sweet'] as num?)?.toInt() ?? 0,
      sour: (json['sour'] as num?)?.toInt() ?? 0,
      fresh: (json['fresh'] as num?)?.toInt() ?? 0,
      spicy: (json['spicy'] as num?)?.toInt() ?? 0,
      bitter: (json['bitter'] as num?)?.toInt() ?? 0,
      floral: (json['floral'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$TasteProfileDto2ToJson(TasteProfileDto2 instance) =>
    <String, dynamic>{
      'sweet': instance.sweet,
      'sour': instance.sour,
      'fresh': instance.fresh,
      'spicy': instance.spicy,
      'bitter': instance.bitter,
      'floral': instance.floral,
    };

CuratedMixDto _$CuratedMixDtoFromJson(Map<String, dynamic> json) =>
    CuratedMixDto(
      id: json['id'] as String,
      name: LocalizedString.fromJson(json['name'] as Map<String, dynamic>),
      components: (json['components'] as List<dynamic>)
          .map((e) => MixComponentDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      expectedProfile: TasteProfileDto2.fromJson(
        json['expectedProfile'] as Map<String, dynamic>,
      ),
      strengthLevel: (json['strengthLevel'] as num).toInt(),
      difficulty: json['difficulty'] as String,
      description: LocalizedString.fromJson(
        json['description'] as Map<String, dynamic>,
      ),
      targetPersona: json['targetPersona'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      popularity: (json['popularity'] as num).toInt(),
    );

Map<String, dynamic> _$CuratedMixDtoToJson(CuratedMixDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'components': instance.components,
      'expectedProfile': instance.expectedProfile,
      'strengthLevel': instance.strengthLevel,
      'difficulty': instance.difficulty,
      'description': instance.description,
      'targetPersona': instance.targetPersona,
      'tags': instance.tags,
      'popularity': instance.popularity,
    };
