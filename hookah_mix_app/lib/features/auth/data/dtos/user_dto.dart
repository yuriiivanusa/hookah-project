import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hookah_mix_master/features/auth/domain/entities/app_user.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
abstract class UserDto with _$UserDto {
  const factory UserDto({
    required String id,
    required String email,
    String? displayName,
    String? photoUrl,
    @Default(false) bool isEmailVerified,
  }) = _UserDto;

  const UserDto._();

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);

  factory UserDto.fromFirebaseUser(
    String id,
    String email, {
    String? displayName,
    String? photoUrl,
    bool isEmailVerified = false,
  }) => UserDto(
    id: id,
    email: email,
    displayName: displayName,
    photoUrl: photoUrl,
    isEmailVerified: isEmailVerified,
  );

  AppUser toDomain() => AppUser(
    id: id,
    email: email,
    displayName: displayName,
    photoUrl: photoUrl,
    isEmailVerified: isEmailVerified,
  );
}
