import '../models/app_user.dart';

class AuthService {
  Future<AppUser> signInWithEmail({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return AppUser(
      id: 'U-EMP-100',
      name: 'Demo Employee',
      email: email,
      role: 'employee',
      authProvider: 'email',
    );
  }

  Future<AppUser> signUpWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return AppUser(
      id: 'U-NEW-101',
      name: name,
      email: email,
      role: 'employee',
      authProvider: 'email',
    );
  }

  Future<AppUser> signInWithGoogle() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return const AppUser(
      id: 'U-GGL-102',
      name: 'Google Demo User',
      email: 'google.user@demo.com',
      role: 'employee',
      authProvider: 'google',
    );
  }

  Future<AppUser> signInWithFacebook() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return const AppUser(
      id: 'U-FB-103',
      name: 'Facebook Demo User',
      email: 'facebook.user@demo.com',
      role: 'employee',
      authProvider: 'facebook',
    );
  }
}