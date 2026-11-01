import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_skincare/controllers/auth_controller.dart';
import 'package:mini_skincare/core/theme/app_theme.dart';
import 'package:mini_skincare/widgets/app_button.dart';
import 'package:mini_skincare/widgets/custom_text_field.dart';
import 'home_screen.dart';
import 'register_screen.dart';
import 'main_navigation_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Please enter your email';
    if (!value.contains('@')) return 'Please enter a valid email';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your password';
    return null;
  }

  void _handleLogin() {
    if (!_formKey.currentState!.validate()) return;

    final authController = Get.find<AuthController>();
    authController.login(_emailController.text, _passwordController.text);

    Get.offAll(() => const MainNavigationScreen());
  }

  void _goToRegister() {
    Get.to(() => const RegisterScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const _Header(),
                const SizedBox(height: 40),
                CustomTextField(
                  label: 'Email',
                  hint: 'enter your email',
                  controller: _emailController,
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  label: 'Password',
                  hint: 'enter your password',
                  controller: _passwordController,
                  prefixIcon: Icons.lock_outline,
                  isPassword: true,
                  validator: _validatePassword,
                ),
                const SizedBox(height: 12),
                const _ForgotPasswordButton(),
                const SizedBox(height: 24),
                AppButton(text: 'Sign In', onPressed: _handleLogin),
                const SizedBox(height: 24),
                _SignUpPrompt(onSignUpTap: _goToRegister),
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
        const Icon(
          Icons.spa_outlined,
          size: 48,
          color: AppTheme.primaryPurple,
        ),
        const SizedBox(height: 16),
        Text(
          'Welcome Back 👋',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Sign in to continue tracking your daily skincare routine.',
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
      ],
    );
  }
}

class _ForgotPasswordButton extends StatelessWidget {
  const _ForgotPasswordButton();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {}, // TODO: implement forgot password
        child: const Text(
          'Forgot Password?',
          style: TextStyle(color: AppTheme.primaryPurple),
        ),
      ),
    );
  }
}

class _SignUpPrompt extends StatelessWidget {
  const _SignUpPrompt({required this.onSignUpTap});

  final VoidCallback onSignUpTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? "),
        GestureDetector(
          onTap: onSignUpTap,
          child: const Text(
            'Sign Up',
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