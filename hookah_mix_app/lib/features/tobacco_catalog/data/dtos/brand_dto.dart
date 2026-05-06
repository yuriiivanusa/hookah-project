import 'package:json_annotation/json_annotation.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/data/dtos/tobacco_dto.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/domain/entities/brand.dart';

part 'brand_dto.g.dart';

@JsonSerializable()
class BrandDto {
  const BrandDto({
    required this.id,
    required this.name,
    required this.country,
    required this.countryName,
    required this.leafType,
    this.foundedYear,
    required this.description,
    required this.popularity,
  });

  final String id;
  final String name;
  final String country;
  final LocalizedString countryName;
  final String leafType;
  final int? foundedYear;
  final LocalizedString description;
  final int popularity;

  factory BrandDto.fromJson(Map<String, dynamic> json) => _$BrandDtoFromJson(json);
  Map<String, dynamic> toJson() => _$BrandDtoToJson(this);

  factory BrandDto.fromFirestore(String docId, Map<String, dynamic> data) =>
      BrandDto.fromJson({...data, 'id': docId});

  Brand toDomain() => Brand(
    id: id,
    name: name,
    country: country,
    countryNameEn: countryName.en,
    countryNameUk: countryName.uk,
    leafType: leafType,
    foundedYear: foundedYear,
    descriptionEn: description.en,
    descriptionUk: description.uk,
    popularity: popularity,
  );
}
