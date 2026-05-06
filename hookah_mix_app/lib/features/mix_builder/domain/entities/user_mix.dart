import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hookah_mix_master/features/mix_builder/domain/entities/mix_component.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/domain/entities/taste_profile.dart';

part 'user_mix.freezed.dart';

@freezed
abstract class UserMix with _$UserMix {
  const factory UserMix({
    required String id,
    required String userId,
    required String name,
    @Default('') String description,
    required List<MixComponent> components,
    TasteProfile? tasteProfile,
    @Default(0) int rating,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _UserMix;

  const UserMix._();

  bool get isValid =>
      components.length >= 2 &&
      components.fold(0, (sum, c) => sum + c.percentage) == 100 &&
      name.trim().isNotEmpty;
}
