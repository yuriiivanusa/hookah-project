import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hookah_mix_master/features/auth/data/dtos/user_dto.dart';

part 'auth_response_dto.freezed.dart';

@freezed
abstract class AuthResponseDto with _$AuthResponseDto {
  const factory AuthResponseDto({required UserDto user, String? accessToken}) = _AuthResponseDto;
}
