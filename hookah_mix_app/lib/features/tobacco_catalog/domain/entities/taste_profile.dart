import 'package:freezed_annotation/freezed_annotation.dart';

part 'taste_profile.freezed.dart';

@freezed
abstract class TasteProfile with _$TasteProfile {
  const factory TasteProfile({
    @Default(0) int sweet,
    @Default(0) int sour,
    @Default(0) int fresh,
    @Default(0) int spicy,
    @Default(0) int bitter,
    @Default(0) int floral,
  }) = _TasteProfile;

  const TasteProfile._();

  List<int> get values => [sweet, sour, fresh, spicy, bitter, floral];
  int get maxValue => values.fold(0, (a, b) => a > b ? a : b);
}
