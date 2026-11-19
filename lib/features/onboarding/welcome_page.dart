import 'package:flutter/material.dart';
import '../auth/login_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  static const Color darkGreen = Color(0xFF315D18);
  static const Color lightGreen = Color(0xFFE9EFDC);
  static const Color cream = Color(0xFFFAF9F5);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: cream,
      body: SafeArea(
        child: Stack(
          children: [
            // Background decoration
            Positioned(
              top: 35,
              right: -65,
              child: Container(
                width: 170,
                height: 170,
                decoration: const BoxDecoration(
                  color: Color(0xFFF0F1E6),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            Positioned(
              top: 230,
              right: -100,
              child: Container(
                width: 210,
                height: 210,
                decoration: const BoxDecoration(
                  color: Color(0xFFF0F2E9),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            Positioned(
              bottom: 65,
              left: -100,
              child: Container(
                width: 250,
                height: 180,
                decoration: const BoxDecoration(
                  color: Color(0xFFE8EDDC),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(150),
                    bottomRight: Radius.circular(150),
                  ),
                ),
              ),
            ),

            Column(
              children: [
                SizedBox(height: screenHeight * 0.12),

                // Logo
                const Icon(
                  Icons.soup_kitchen_outlined,
                  size: 72,
                  color: darkGreen,
                ),

                const SizedBox(height: 8),

                const Text(
                  'DAPOSTOK',
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 12),

                const Text(
                  'Manajemen Stok Barang\nuntuk Bisnis Catering',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.6,
                    color: Color(0xFF555555),
                  ),
                ),

                const Spacer(),

                // Food image
                SizedBox(
                  width: double.infinity,
                  height: screenHeight * 0.39,
                  child: Image.asset(
                    'assets/images/food.png',
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(
                          Icons.restaurant,
                          size: 90,
                          color: Color(0xFF9BAA83),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 24),

                // Button Mulai Sekarang
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: darkGreen,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Mulai Sekarang',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.arrow_forward_rounded, size: 20),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
