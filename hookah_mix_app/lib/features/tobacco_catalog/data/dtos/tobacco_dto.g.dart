// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tobacco_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TobaccoBrandRef _$TobaccoBrandRefFromJson(Map<String, dynamic> json) =>
    TobaccoBrandRef(
      id: json['id'] as String,
      name: json['name'] as String,
      country: json['country'] as String,
    );

Map<String, dynamic> _$TobaccoBrandRefToJson(TobaccoBrandRef instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'country': instance.country,
    };

LocalizedString _$LocalizedStringFromJson(Map<String, dynamic> json) =>
    LocalizedString(
      en: json['en'] as String,
      uk: json['uk'] as String,
      original: json['original'] as String?,
    );

Map<String, dynamic> _$LocalizedStringToJson(LocalizedString instance) =>
    <String, dynamic>{
      'en': instance.en,
      'uk': instance.uk,
      'original': instance.original,
    };

TasteProfileDto _$TasteProfileDtoFromJson(Map<String, dynamic> json) =>
    TasteProfileDto(
      sweet: (json['sweet'] as num?)?.toInt() ?? 0,
      sour: (json['sour'] as num?)?.toInt() ?? 0,
      fresh: (json['fresh'] as num?)?.toInt() ?? 0,
      spicy: (json['spicy'] as num?)?.toInt() ?? 0,
      bitter: (json['bitter'] as num?)?.toInt() ?? 0,
      floral: (json['floral'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$TasteProfileDtoToJson(TasteProfileDto instance) =>
    <String, dynamic>{
      'sweet': instance.sweet,
      'sour': instance.sour,
      'fresh': instance.fresh,
      'spicy': instance.spicy,
      'bitter': instance.bitter,
      'floral': instance.floral,
    };

TobaccoDto _$TobaccoDtoFromJson(Map<String, dynamic> json) => TobaccoDto(
  id: json['id'] as String,
  brand: TobaccoBrandRef.fromJson(json['brand'] as Map<String, dynamic>),
  name: LocalizedString.fromJson(json['name'] as Map<String, dynamic>),
  leafType: json['leafType'] as String,
  strength: (json['strength'] as num).toInt(),
  flavorCategories: (json['flavorCategories'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  tasteNotes: (json['tasteNotes'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  tasteProfile: TasteProfileDto.fromJson(
    json['tasteProfile'] as Map<String, dynamic>,
  ),
  description: LocalizedString.fromJson(
    json['description'] as Map<String, dynamic>,
  ),
  imageUrl: json['imageUrl'] as String?,
  popularity: (json['popularity'] as num).toInt(),
);

Map<String, dynamic> _$TobaccoDtoToJson(TobaccoDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'brand': instance.brand,
      'name': instance.name,
      'leafType': instance.leafType,
      'strength': instance.strength,
      'flavorCategories': instance.flavorCategories,
      'tasteNotes': instance.tasteNotes,
      'tasteProfile': instance.tasteProfile,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'popularity': instance.popularity,
    };
