import 'package:flutter/material.dart';

import 'home_page.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. Màu nền xanh lá cây (giống trong ảnh)
      backgroundColor: const Color(0xFF4CAF50),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 2. Hình ảnh món ăn (Thay 'assets/food.png' bằng đường dẫn ảnh của bạn)
            // Nếu chưa có ảnh, tạm thời dùng một Container hình tròn để giữ chỗ
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: Image.network(
                'images/img1.png', // Link ảnh mẫu món ăn
                height: 250,
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 40),

            // 3. Tiêu đề "Food Ordering App"
            const Text(
              'Food Ordering App',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 60),

            // 4. Nút bấm "Get A Meal" màu vàng bo góc
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD4D125), // Màu vàng chanh
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Get A Meal',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
