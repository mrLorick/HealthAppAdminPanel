import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';



class AdminLoginPage extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  AdminLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo
                  Image.asset('assets/images/app_logo.png', height: 100),
                  const SizedBox(height: 10),
                  const Text(
                    "Admin Login",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  // Email Field
                  TextField(
                    controller: controller.emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Password Field
                  TextField(
                    controller: controller.passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Login Button
                  Obx(() => ElevatedButton(
                    onPressed: controller.isLoading.value ? null : controller.login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0XFF811f1a),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Sign In", style: TextStyle(fontSize: 16,color: Colors.white)),
                  )
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
