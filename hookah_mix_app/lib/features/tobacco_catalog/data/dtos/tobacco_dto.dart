import 'package:json_annotation/json_annotation.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/domain/entities/taste_profile.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/domain/entities/tobacco.dart';

part 'tobacco_dto.g.dart';

@JsonSerializable()
class TobaccoBrandRef {
  const TobaccoBrandRef({
    required this.id,
    required this.name,
    required this.country,
  });

  final String id;
  final String name;
  final String country;

  factory TobaccoBrandRef.fromJson(Map<String, dynamic> json) =>
      _$TobaccoBrandRefFromJson(json);
  Map<String, dynamic> toJson() => _$TobaccoBrandRefToJson(this);
}

@JsonSerializable()
class LocalizedString {
  const LocalizedString({required this.en, required this.uk, this.original});

  final String en;
  final String uk;
  final String? original;

  factory LocalizedString.fromJson(Map<String, dynamic> json) =>
      _$LocalizedStringFromJson(json);
  Map<String, dynamic> toJson() => _$LocalizedStringToJson(this);
}

@JsonSerializable()
class TasteProfileDto {
  const TasteProfileDto({
    this.sweet = 0,
    this.sour = 0,
    this.fresh = 0,
    this.spicy = 0,
    this.bitter = 0,
    this.floral = 0,
  });

  @JsonKey(defaultValue: 0)
  final int sweet;
  @JsonKey(defaultValue: 0)
  final int sour;
  @JsonKey(defaultValue: 0)
  final int fresh;
  @JsonKey(defaultValue: 0)
  final int spicy;
  @JsonKey(defaultValue: 0)
  final int bitter;
  @JsonKey(defaultValue: 0)
  final int floral;

  factory TasteProfileDto.fromJson(Map<String, dynamic> json) =>
      _$TasteProfileDtoFromJson(json);
  Map<String, dynamic> toJson() => _$TasteProfileDtoToJson(this);

  TasteProfile toDomain() => TasteProfile(
    sweet: sweet,
    sour: sour,
    fresh: fresh,
    spicy: spicy,
    bitter: bitter,
    floral: floral,
  );
}

@JsonSerializable()
class TobaccoDto {
  const TobaccoDto({
    required this.id,
    required this.brand,
    required this.name,
    required this.leafType,
    required this.strength,
    required this.flavorCategories,
    required this.tasteNotes,
    required this.tasteProfile,
    required this.description,
    this.imageUrl,
    required this.popularity,
  });

  final String id;
  final TobaccoBrandRef brand;
  final LocalizedString name;
  final String leafType;
  final int strength;
  final List<String> flavorCategories;
  final List<String> tasteNotes;
  final TasteProfileDto tasteProfile;
  final LocalizedString description;
  final String? imageUrl;
  final int popularity;

  factory TobaccoDto.fromJson(Map<String, dynamic> json) =>
      _$TobaccoDtoFromJson(json);
  Map<String, dynamic> toJson() => _$TobaccoDtoToJson(this);

  factory TobaccoDto.fromFirestore(String docId, Map<String, dynamic> data) =>
      TobaccoDto.fromJson({...data, 'id': docId});

  Tobacco toDomain() => Tobacco(
    id: id,
    brandId: brand.id,
    brandName: brand.name,
    brandCountry: brand.country,
    nameEn: name.en,
    nameUk: name.uk,
    leafType: leafType,
    strength: strength,
    flavorCategories: flavorCategories,
    tasteNotes: tasteNotes,
    tasteProfile: tasteProfile.toDomain(),
    descriptionEn: description.en,
    descriptionUk: description.uk,
    imageUrl: imageUrl,
    popularity: popularity,
  );
}
