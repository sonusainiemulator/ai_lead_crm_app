class AppUser {
  final String id;
  final String name;
  final String email;
  final String role;
  final String authProvider;

  const AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.authProvider,
  });
}
