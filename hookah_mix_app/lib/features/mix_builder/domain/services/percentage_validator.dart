import 'package:hookah_mix_master/features/mix_builder/domain/entities/mix_component.dart';

abstract final class PercentageValidator {
  static const maxComponents = 5;

  static bool isValid(List<MixComponent> components) {
    if (components.isEmpty) return false;
    return components.fold(0, (sum, c) => sum + c.percentage) == 100;
  }

  static List<MixComponent> autoScale(
    List<MixComponent> components,
    int changedIndex,
    int newValue,
  ) {
    if (components.length == 1) {
      return [components[0].copyWith(percentage: 100)];
    }

    final others = components.asMap().entries.where((e) => e.key != changedIndex).toList();

    final remaining = 100 - newValue;
    final othersTotal = others.fold(0, (sum, e) => sum + e.value.percentage);

    List<MixComponent> result = List.from(components);
    result[changedIndex] = components[changedIndex].copyWith(percentage: newValue);

    if (othersTotal == 0) {
      final perItem = remaining ~/ others.length;
      final leftover = remaining - perItem * others.length;
      for (int i = 0; i < others.length; i++) {
        final idx = others[i].key;
        result[idx] = components[idx].copyWith(percentage: perItem + (i == 0 ? leftover : 0));
      }
    } else {
      int assigned = 0;
      for (int i = 0; i < others.length; i++) {
        final e = others[i];
        final scaled = i == others.length - 1
            ? remaining - assigned
            : (e.value.percentage * remaining / othersTotal).round();
        result[e.key] = components[e.key].copyWith(percentage: scaled);
        assigned += scaled;
      }
    }

    return result;
  }
}
