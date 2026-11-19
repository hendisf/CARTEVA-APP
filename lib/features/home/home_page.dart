import 'package:flutter/material.dart';
import 'package:carteva/services/auth_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> logout(BuildContext context) async {
    try {
      await AuthService.logout();

      // AuthGate otomatis mengarahkan kembali ke LoginPage.
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal keluar: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = AuthService.supabase.auth.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F6),
      appBar: AppBar(
        title: const Text(
          'CARTEVA',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        backgroundColor: const Color(0xFF16865B),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () => logout(context),
            icon: const Icon(Icons.logout),
            tooltip: 'Keluar',
          ),
        ],
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.inventory_2_rounded,
                size: 85,
                color: Color(0xFF16865B),
              ),

              const SizedBox(height: 20),

              const Text(
                'Selamat Datang di CARTEVA!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF176B4A),
                ),
              ),

              const SizedBox(height: 12),

              Text(
                user?.userMetadata?['full_name']?.toString() ??
                    user?.email ??
                    'Pengguna CARTEVA',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                user?.email ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 25),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: const Color(0xFFE5EAE7)),
                ),
                child: const Column(
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      color: Color(0xFF16865B),
                      size: 40,
                    ),

                    SizedBox(height: 12),

                    Text(
                      'Login Berhasil!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 8),

                    Text(
                      'Akun CARTEVA berhasil terhubung. '
                      'Aplikasi siap digunakan untuk pengelolaan '
                      'stok bahan baku catering.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, height: 1.5),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () => logout(context),
                  icon: const Icon(Icons.logout),
                  label: const Text('Keluar dari Akun'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF16865B),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
