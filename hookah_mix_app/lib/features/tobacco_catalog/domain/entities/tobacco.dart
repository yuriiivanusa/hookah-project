import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/domain/entities/taste_profile.dart';

part 'tobacco.freezed.dart';

@freezed
abstract class Tobacco with _$Tobacco {
  const factory Tobacco({
    required String id,
    required String brandId,
    required String brandName,
    required String brandCountry,
    required String nameEn,
    required String nameUk,
    required String leafType,
    required int strength,
    required List<String> flavorCategories,
    required List<String> tasteNotes,
    required TasteProfile tasteProfile,
    required String descriptionEn,
    required String descriptionUk,
    String? imageUrl,
    required int popularity,
  }) = _Tobacco;

  const Tobacco._();

  String localName(String locale) => locale == 'uk' ? nameUk : nameEn;
  String localDescription(String locale) => locale == 'uk' ? descriptionUk : descriptionEn;
}
