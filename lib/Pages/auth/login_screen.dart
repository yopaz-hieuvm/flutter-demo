import 'package:flutter/material.dart';
import 'package:flutter_demo/Pages/auth/signup_screen.dart';
import 'package:flutter_demo/Service/auth_service.dart';
import 'package:flutter_demo/Widgets/auth_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController? _emailController;
  TextEditingController? _passwordController;
  bool? _isLoading;
  bool? _isPasswordVisible;

  TextEditingController get emailController =>
      _emailController ??= TextEditingController();
  TextEditingController get passwordController =>
      _passwordController ??= TextEditingController();

  AuthService get _authService => AuthService();

  @override
  void reassemble() {
    super.reassemble();
    _emailController ??= TextEditingController();
    _passwordController ??= TextEditingController();
    _isLoading ??= false;
    _isPasswordVisible ??= false;
  }

  @override
  void dispose() {
    _emailController?.dispose();
    _passwordController?.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập email và mật khẩu')),
      );
      return;
    }
    if (passwordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mật khẩu phải có ít nhất 6 ký tự')),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      await _authService.signIn(emailController.text, passwordController.text);
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const LoginIllustration(),
              const SizedBox(height: 28),
              const Text(
                'Chào mừng trở lại! 👋',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Đăng nhập để tiếp tục tìm phòng trọ phù hợp với bạn',
                style: TextStyle(fontSize: 14, color: Color(0xFF6B7280), height: 1.4),
              ),
              const SizedBox(height: 28),
              AuthInputField(
                label: 'Email hoặc số điện thoại',
                hint: 'Nhập email hoặc số điện thoại',
                prefixIcon: Icons.email_outlined,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              AuthInputField(
                label: 'Mật khẩu',
                hint: 'Nhập mật khẩu',
                prefixIcon: Icons.lock_outline,
                controller: passwordController,
                obscureText: !(_isPasswordVisible ?? false),
                suffix: IconButton(
                  onPressed: () => setState(
                    () => _isPasswordVisible = !(_isPasswordVisible ?? false),
                  ),
                  icon: Icon(
                    (_isPasswordVisible ?? false)
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: const Color(0xFF9CA3AF),
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Quên mật khẩu?',
                    style: TextStyle(color: kAuthGreen, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              AuthPrimaryButton(
                text: 'Đăng nhập',
                isLoading: _isLoading ?? false,
                onTap: _login,
              ),
              const SizedBox(height: 24),
              const SocialLoginSection(),
              const SizedBox(height: 24),
              AuthFooterLink(
                prefix: 'Chưa có tài khoản? ',
                action: 'Đăng ký ngay',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignupScreen()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
