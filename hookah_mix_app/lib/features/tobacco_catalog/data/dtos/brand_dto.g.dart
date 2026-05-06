// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrandDto _$BrandDtoFromJson(Map<String, dynamic> json) => BrandDto(
  id: json['id'] as String,
  name: json['name'] as String,
  country: json['country'] as String,
  countryName: LocalizedString.fromJson(
    json['countryName'] as Map<String, dynamic>,
  ),
  leafType: json['leafType'] as String,
  foundedYear: (json['foundedYear'] as num?)?.toInt(),
  description: LocalizedString.fromJson(
    json['description'] as Map<String, dynamic>,
  ),
  popularity: (json['popularity'] as num).toInt(),
);

Map<String, dynamic> _$BrandDtoToJson(BrandDto instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'country': instance.country,
  'countryName': instance.countryName,
  'leafType': instance.leafType,
  'foundedYear': instance.foundedYear,
  'description': instance.description,
  'popularity': instance.popularity,
};
