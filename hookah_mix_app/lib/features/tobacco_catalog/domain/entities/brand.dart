import 'package:freezed_annotation/freezed_annotation.dart';

part 'brand.freezed.dart';

@freezed
abstract class Brand with _$Brand {
  const factory Brand({
    required String id,
    required String name,
    required String country,
    required String countryNameEn,
    required String countryNameUk,
    required String leafType,
    int? foundedYear,
    required String descriptionEn,
    required String descriptionUk,
    required int popularity,
  }) = _Brand;

  const Brand._();

  String localCountryName(String locale) =>
      locale == 'uk' ? countryNameUk : countryNameEn;
}
