import 'package:json_annotation/json_annotation.dart';
import 'package:hookah_mix_master/features/smart_recommender/domain/entities/curated_mix.dart';
import 'package:hookah_mix_master/features/smart_recommender/domain/entities/mix_component.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/data/dtos/tobacco_dto.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/domain/entities/taste_profile.dart';

part 'curated_mix_dto.g.dart';

@JsonSerializable()
class MixComponentDto {
  const MixComponentDto({required this.tobaccoId, required this.percentage});

  final String tobaccoId;
  final int percentage;

  factory MixComponentDto.fromJson(Map<String, dynamic> json) =>
      _$MixComponentDtoFromJson(json);
  Map<String, dynamic> toJson() => _$MixComponentDtoToJson(this);

  MixComponent toDomain() =>
      MixComponent(tobaccoId: tobaccoId, percentage: percentage);
}

@JsonSerializable()
class TasteProfileDto2 {
  const TasteProfileDto2({
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

  factory TasteProfileDto2.fromJson(Map<String, dynamic> json) =>
      _$TasteProfileDto2FromJson(json);
  Map<String, dynamic> toJson() => _$TasteProfileDto2ToJson(this);

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
class CuratedMixDto {
  const CuratedMixDto({
    required this.id,
    required this.name,
    required this.components,
    required this.expectedProfile,
    required this.strengthLevel,
    required this.difficulty,
    required this.description,
    required this.targetPersona,
    required this.tags,
    required this.popularity,
  });

  final String id;
  final LocalizedString name;
  final List<MixComponentDto> components;
  @JsonKey(name: 'expectedProfile')
  final TasteProfileDto2 expectedProfile;
  final int strengthLevel;
  final String difficulty;
  final LocalizedString description;
  final String targetPersona;
  final List<String> tags;
  final int popularity;

  factory CuratedMixDto.fromJson(Map<String, dynamic> json) =>
      _$CuratedMixDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CuratedMixDtoToJson(this);

  factory CuratedMixDto.fromFirestore(
    String docId,
    Map<String, dynamic> data,
  ) => CuratedMixDto.fromJson({...data, 'id': docId});

  CuratedMix toDomain() => CuratedMix(
    id: id,
    nameEn: name.en,
    nameUk: name.uk,
    components: components.map((c) => c.toDomain()).toList(),
    expectedProfile: expectedProfile.toDomain(),
    strengthLevel: strengthLevel,
    difficulty: difficulty,
    descriptionEn: description.en,
    descriptionUk: description.uk,
    targetPersona: targetPersona,
    tags: tags,
    popularity: popularity,
  );
}
