import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:hookah_mix_master/features/mix_builder/domain/entities/mix_component.dart';
import 'package:hookah_mix_master/features/mix_builder/domain/entities/user_mix.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/domain/entities/taste_profile.dart';

part 'user_mix_dto.g.dart';

@JsonSerializable()
class MixComponentDto {
  const MixComponentDto({
    required this.tobaccoId,
    required this.tobaccoName,
    required this.percentage,
  });

  final String tobaccoId;
  final String tobaccoName;
  final int percentage;

  factory MixComponentDto.fromJson(Map<String, dynamic> json) => _$MixComponentDtoFromJson(json);
  Map<String, dynamic> toJson() => _$MixComponentDtoToJson(this);

  factory MixComponentDto.fromDomain(MixComponent c) =>
      MixComponentDto(tobaccoId: c.tobaccoId, tobaccoName: c.tobaccoName, percentage: c.percentage);

  MixComponent toDomain() =>
      MixComponent(tobaccoId: tobaccoId, tobaccoName: tobaccoName, percentage: percentage);
}

@JsonSerializable()
class TasteProfileDto3 {
  const TasteProfileDto3({
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

  factory TasteProfileDto3.fromJson(Map<String, dynamic> json) => _$TasteProfileDto3FromJson(json);
  Map<String, dynamic> toJson() => _$TasteProfileDto3ToJson(this);

  factory TasteProfileDto3.fromDomain(TasteProfile p) => TasteProfileDto3(
    sweet: p.sweet,
    sour: p.sour,
    fresh: p.fresh,
    spicy: p.spicy,
    bitter: p.bitter,
    floral: p.floral,
  );

  TasteProfile toDomain() => TasteProfile(
    sweet: sweet,
    sour: sour,
    fresh: fresh,
    spicy: spicy,
    bitter: bitter,
    floral: floral,
  );
}

class UserMixDto {
  const UserMixDto({
    required this.id,
    required this.userId,
    required this.name,
    required this.description,
    required this.components,
    this.tasteProfile,
    required this.rating,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String userId;
  final String name;
  final String description;
  final List<MixComponentDto> components;
  final TasteProfileDto3? tasteProfile;
  final int rating;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory UserMixDto.fromFirestore(String docId, Map<String, dynamic> data) {
    final comps = (data['components'] as List<dynamic>? ?? [])
        .map((e) => MixComponentDto.fromJson(e as Map<String, dynamic>))
        .toList();
    final tp = data['tasteProfile'] != null
        ? TasteProfileDto3.fromJson(data['tasteProfile'] as Map<String, dynamic>)
        : null;
    return UserMixDto(
      id: docId,
      userId: data['userId'] as String,
      name: data['name'] as String,
      description: data['description'] as String? ?? '',
      components: comps,
      tasteProfile: tp,
      rating: data['rating'] as int? ?? 0,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() => {
    'userId': userId,
    'name': name,
    'description': description,
    'components': components.map((c) => c.toJson()).toList(),
    'tasteProfile': tasteProfile?.toJson(),
    'rating': rating,
    'createdAt': Timestamp.fromDate(createdAt),
    'updatedAt': Timestamp.fromDate(updatedAt),
  };

  factory UserMixDto.fromDomain(UserMix mix) => UserMixDto(
    id: mix.id,
    userId: mix.userId,
    name: mix.name,
    description: mix.description,
    components: mix.components.map(MixComponentDto.fromDomain).toList(),
    tasteProfile: mix.tasteProfile != null ? TasteProfileDto3.fromDomain(mix.tasteProfile!) : null,
    rating: mix.rating,
    createdAt: mix.createdAt,
    updatedAt: mix.updatedAt,
  );

  UserMix toDomain() => UserMix(
    id: id,
    userId: userId,
    name: name,
    description: description,
    components: components.map((c) => c.toDomain()).toList(),
    tasteProfile: tasteProfile?.toDomain(),
    rating: rating,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}
