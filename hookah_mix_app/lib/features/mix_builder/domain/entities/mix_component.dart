import 'package:freezed_annotation/freezed_annotation.dart';

part 'mix_component.freezed.dart';

@freezed
abstract class MixComponent with _$MixComponent {
  const factory MixComponent({
    required String tobaccoId,
    required String tobaccoName,
    required int percentage,
  }) = _MixComponent;
}
