import 'package:flutter/material.dart';
import '../models/app_user.dart';
import '../services/auth_service.dart';
import 'role_select_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final AuthService _authService = AuthService();
  final GlobalKey<FormState> _signInKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _signUpKey = GlobalKey<FormState>();

  String _signInEmail = '';
  String _signInPassword = '';
  String _signUpName = '';
  String _signUpEmail = '';
  String _signUpPassword = '';
  bool _isLoading = false;

  void _goToRoleSelect(AppUser user) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => RoleSelectScreen(user: user)),
    );
  }

  Future<void> _handleSignIn() async {
    if (!_signInKey.currentState!.validate()) {
      return;
    }
    _signInKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    final user = await _authService.signInWithEmail(
      email: _signInEmail,
      password: _signInPassword,
    );
    if (!mounted) return;
    setState(() {
      _isLoading = false;
    });
    _goToRoleSelect(user);
  }

  Future<void> _handleSignUp() async {
    if (!_signUpKey.currentState!.validate()) {
      return;
    }
    _signUpKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    final user = await _authService.signUpWithEmail(
      name: _signUpName,
      email: _signUpEmail,
      password: _signUpPassword,
    );
    if (!mounted) return;
    setState(() {
      _isLoading = false;
    });
    _goToRoleSelect(user);
  }

  Future<void> _handleGoogleSignIn() async {
    setState(() {
      _isLoading = true;
    });
    final user = await _authService.signInWithGoogle();
    if (!mounted) return;
    setState(() {
      _isLoading = false;
    });
    _goToRoleSelect(user);
  }

  Future<void> _handleFacebookSignIn() async {
    setState(() {
      _isLoading = true;
    });
    final user = await _authService.signInWithFacebook();
    if (!mounted) return;
    setState(() {
      _isLoading = false;
    });
    _goToRoleSelect(user);
  }

  String? _emailValidator(String? value) {
    if (value == null || value.trim().isEmpty || !value.contains('@')) {
      return 'Enter valid email';
    }
    return null;
  }

  String? _requiredValidator(String? value, String field) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter $field';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              const SizedBox(height: 30),
              const Text(
                'AI Lead CRM Demo',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Sign in as admin/staff demo with email or social login',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const TabBar(tabs: [Tab(text: 'Sign In'), Tab(text: 'Sign Up')]),
              const SizedBox(height: 20),
              SizedBox(
                height: 320,
                child: TabBarView(
                  children: [
                    Form(
                      key: _signInKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(labelText: 'Email'),
                            validator: _emailValidator,
                            onSaved: (value) => _signInEmail = value!.trim(),
                          ),
                          TextFormField(
                            decoration: const InputDecoration(labelText: 'Password'),
                            obscureText: true,
                            validator: (value) => _requiredValidator(value, 'password'),
                            onSaved: (value) => _signInPassword = value!.trim(),
                          ),
                          const SizedBox(height: 18),
                          ElevatedButton(
                            onPressed: _isLoading ? null : _handleSignIn,
                            child: const Text('Sign In'),
                          ),
                        ],
                      ),
                    ),
                    Form(
                      key: _signUpKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(labelText: 'Full Name'),
                            validator: (value) => _requiredValidator(value, 'name'),
                            onSaved: (value) => _signUpName = value!.trim(),
                          ),
                          TextFormField(
                            decoration: const InputDecoration(labelText: 'Email'),
                            validator: _emailValidator,
                            onSaved: (value) => _signUpEmail = value!.trim(),
                          ),
                          TextFormField(
                            decoration: const InputDecoration(labelText: 'Password'),
                            obscureText: true,
                            validator: (value) => _requiredValidator(value, 'password'),
                            onSaved: (value) => _signUpPassword = value!.trim(),
                          ),
                          const SizedBox(height: 18),
                          ElevatedButton(
                            onPressed: _isLoading ? null : _handleSignUp,
                            child: const Text('Create Account'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const Divider(),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                icon: const Icon(Icons.facebook),
                label: const Text('Continue with Facebook'),
                onPressed: _isLoading ? null : _handleFacebookSignIn,
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                icon: const Icon(Icons.g_mobiledata),
                label: const Text('Continue with Google'),
                onPressed: _isLoading ? null : _handleGoogleSignIn,
              ),
              if (_isLoading)
                const Padding(
                  padding: EdgeInsets.only(top: 14),
                  child: Center(child: CircularProgressIndicator()),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
