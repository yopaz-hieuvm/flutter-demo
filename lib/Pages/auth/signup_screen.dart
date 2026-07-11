import 'package:flutter/material.dart';
import 'package:flutter_demo/Service/auth_service.dart';
import 'package:flutter_demo/Widgets/auth_widgets.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController? _emailController;
  TextEditingController? _passwordController;
  TextEditingController? _confirmPasswordController;
  bool? _isLoading;
  bool? _isPasswordVisible;
  bool? _isConfirmPasswordVisible;

  TextEditingController get emailController =>
      _emailController ??= TextEditingController();
  TextEditingController get passwordController =>
      _passwordController ??= TextEditingController();
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController ??= TextEditingController();

  AuthService get _authService => AuthService();

  @override
  void reassemble() {
    super.reassemble();
    _emailController ??= TextEditingController();
    _passwordController ??= TextEditingController();
    _confirmPasswordController ??= TextEditingController();
    _isLoading ??= false;
    _isPasswordVisible ??= false;
    _isConfirmPasswordVisible ??= false;
  }

  @override
  void dispose() {
    _emailController?.dispose();
    _passwordController?.dispose();
    _confirmPasswordController?.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng điền đầy đủ thông tin')),
      );
      return;
    }
    if (passwordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mật khẩu phải có ít nhất 6 ký tự')),
      );
      return;
    }
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mật khẩu xác nhận không khớp')),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      await _authService.signUp(emailController.text, passwordController.text);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đăng ký thành công! Vui lòng đăng nhập')),
      );
      Navigator.pop(context);
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
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back, color: Color(0xFF374151)),
                padding: EdgeInsets.zero,
                alignment: Alignment.centerLeft,
              ),
              const SizedBox(height: 8),
              const SignupIllustration(),
              const SizedBox(height: 24),
              const Text(
                'Tạo tài khoản',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Đăng ký để trải nghiệm nhiều tiện ích hơn',
                style: TextStyle(fontSize: 14, color: Color(0xFF6B7280), height: 1.4),
              ),
              const SizedBox(height: 28),
              AuthInputField(
                label: 'Email',
                hint: 'Nhập email của bạn',
                prefixIcon: Icons.email_outlined,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              AuthInputField(
                label: 'Mật khẩu',
                hint: 'Tạo mật khẩu',
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
              const SizedBox(height: 8),
              Row(
                children: const [
                  Icon(Icons.check_circle, color: kAuthGreen, size: 16),
                  SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Mật khẩu phải có ít nhất 6 ký tự',
                      style: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              AuthInputField(
                label: 'Xác nhận mật khẩu',
                hint: 'Nhập lại mật khẩu',
                prefixIcon: Icons.lock_outline,
                controller: confirmPasswordController,
                obscureText: !(_isConfirmPasswordVisible ?? false),
                suffix: IconButton(
                  onPressed: () => setState(
                    () => _isConfirmPasswordVisible =
                        !(_isConfirmPasswordVisible ?? false),
                  ),
                  icon: Icon(
                    (_isConfirmPasswordVisible ?? false)
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: const Color(0xFF9CA3AF),
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(height: 28),
              AuthPrimaryButton(
                text: 'Đăng ký',
                isLoading: _isLoading ?? false,
                onTap: _signUp,
              ),
              const SizedBox(height: 24),
              AuthFooterLink(
                prefix: 'Đã có tài khoản? ',
                action: 'Đăng nhập ngay',
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
