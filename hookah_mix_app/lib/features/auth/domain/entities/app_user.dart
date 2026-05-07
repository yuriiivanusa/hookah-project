import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';

@freezed
abstract class AppUser with _$AppUser {
  const factory AppUser({
    required String id,
    required String email,
    String? displayName,
    String? photoUrl,
    @Default(false) bool isEmailVerified,
    @Default(false) bool isGuest,
  }) = _AppUser;

  const AppUser._();

  static AppUser guest() =>
      const AppUser(id: 'guest', email: '', isGuest: true);
}
