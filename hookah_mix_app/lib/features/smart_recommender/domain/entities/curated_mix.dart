import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hookah_mix_master/features/smart_recommender/domain/entities/mix_component.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/domain/entities/taste_profile.dart';

part 'curated_mix.freezed.dart';

@freezed
abstract class CuratedMix with _$CuratedMix {
  const factory CuratedMix({
    required String id,
    required String nameEn,
    required String nameUk,
    required List<MixComponent> components,
    required TasteProfile expectedProfile,
    required int strengthLevel,
    required String difficulty,
    required String descriptionEn,
    required String descriptionUk,
    required String targetPersona,
    required List<String> tags,
    required int popularity,
  }) = _CuratedMix;

  const CuratedMix._();

  String localName(String locale) => locale == 'uk' ? nameUk : nameEn;
  String localDescription(String locale) => locale == 'uk' ? descriptionUk : descriptionEn;
}
