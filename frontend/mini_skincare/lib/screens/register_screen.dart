import 'package:flutter/material.dart';
import 'package:mini_skincare/core/theme/app_theme.dart';
import 'package:mini_skincare/widgets/app_button.dart';
import 'package:mini_skincare/widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your name';
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your email';
    if (!value.contains('@')) return 'Please enter a valid email';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value != _passwordController.text) return 'Passwords do not match';
    return null;
  }

  void _handleRegister() {
    if (!_formKey.currentState!.validate()) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Creating account...')),
    );
  }

  void _goBack() => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
          onPressed: _goBack,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _Header(),
                const SizedBox(height: 32),
                CustomTextField(
                  label: 'Full Name',
                  hint: 'enter your name',
                  controller: _nameController,
                  prefixIcon: Icons.person_outline,
                  validator: _validateName,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Email',
                  hint: 'enter your email',
                  controller: _emailController,
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Password',
                  hint: 'create password',
                  controller: _passwordController,
                  prefixIcon: Icons.lock_outline,
                  isPassword: true,
                  validator: _validatePassword,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Confirm Password',
                  hint: 're-enter password',
                  controller: _confirmPasswordController,
                  prefixIcon: Icons.lock_outline,
                  isPassword: true,
                  validator: _validateConfirmPassword,
                ),
                const SizedBox(height: 32),
                AppButton(text: 'Sign Up', onPressed: _handleRegister),
                const SizedBox(height: 24),
                _SignInPrompt(onSignInTap: _goBack),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Create Account ✨',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Join GlowCare to start personalized skin health analysis.',
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
      ],
    );
  }
}

class _SignInPrompt extends StatelessWidget {
  const _SignInPrompt({required this.onSignInTap});

  final VoidCallback onSignInTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Already have an account? '),
        GestureDetector(
          onTap: onSignInTap,
          child: const Text(
            'Sign In',
            style: TextStyle(
              color: AppTheme.primaryPurple,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}