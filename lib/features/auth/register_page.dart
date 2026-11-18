import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:carteva/services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  bool obscurePassword = true;
  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  void showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }

  Future<void> register() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirm = confirmController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty || confirm.isEmpty) {
      showMessage('Semua kolom wajib diisi.');
      return;
    }

    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(email)) {
      showMessage('Format email tidak valid.');
      return;
    }

    if (password.length < 6) {
      showMessage('Password minimal 6 karakter.');
      return;
    }

    if (password != confirm) {
      showMessage('Konfirmasi password tidak sama.');
      return;
    }

    setState(() => isLoading = true);

    try {
      final response = await AuthService.register(
        name: name,
        email: email,
        password: password,
      );

      if (!mounted) return;

      if (response.user == null) {
        showMessage('Registrasi gagal. Silakan coba kembali.');
        return;
      }

      if (response.session != null) {
        showMessage('Registrasi berhasil! Silakan masuk ke CARTEVA.');
      } else {
        showMessage(
          'Akun berhasil dibuat. Silakan periksa inbox atau folder spam untuk verifikasi email.',
        );
      }

      Navigator.pop(context);
    } on AuthException catch (e) {
      showMessage('Registrasi gagal: ${e.message}');
    } catch (e) {
      showMessage('Terjadi kesalahan: $e');
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  Widget buildField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required IconData icon,
    bool obscure = false,
    TextInputType keyboard = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscure,
          keyboardType: keyboard,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE5EAE7)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFF16865B),
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF16865B);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F8F6),
        title: const Text('Buat Akun'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 450),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(Icons.person_add_alt_1, size: 60, color: green),

                  const SizedBox(height: 20),

                  const Text(
                    'Daftar CARTEVA',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Buat akun untuk mulai menggunakan aplikasi.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 30),

                  buildField(
                    label: 'Nama Lengkap',
                    hint: 'Masukkan nama lengkap',
                    controller: nameController,
                    icon: Icons.person_outline,
                  ),

                  const SizedBox(height: 18),

                  buildField(
                    label: 'Email',
                    hint: 'Masukkan email',
                    controller: emailController,
                    icon: Icons.email_outlined,
                    keyboard: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 18),

                  buildField(
                    label: 'Password',
                    hint: 'Minimal 6 karakter',
                    controller: passwordController,
                    icon: Icons.lock_outline,
                    obscure: obscurePassword,
                  ),

                  const SizedBox(height: 18),

                  buildField(
                    label: 'Konfirmasi Password',
                    hint: 'Ulangi password',
                    controller: confirmController,
                    icon: Icons.lock_outline,
                    obscure: obscurePassword,
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                      child: Text(
                        obscurePassword
                            ? 'Tampilkan password'
                            : 'Sembunyikan password',
                        style: const TextStyle(color: green),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: isLoading ? null : register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: green,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            height: 23,
                            width: 23,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            'Daftar Sekarang',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
