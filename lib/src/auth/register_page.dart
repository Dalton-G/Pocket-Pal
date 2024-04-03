// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({super.key, required this.showLoginPage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // 输入框
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();

  // 角色
  final List<String> _roleOptions = ['member', 'admin'];
  String _selectedRole = 'member'; // 原本 default

  // 登录按钮技术
  Future signUp() async {
    if (passwordMatch()) {
      try {
        final UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        final String userId = userCredential.user!.uid;

        // 用一样的 ID 添加用户详情
        await addUserDetails(userId);
      } catch (error) {
        print("Error registering user: $error");
      }
    }
  }

  Future addUserDetails(String userId) async {
    final Timestamp now = Timestamp.now();
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'id': userId,
      'name': _nameController.text.trim(),
      'email': _emailController.text.trim(),
      'role': _selectedRole,
      'createdAt': now,
      'updatedAt': now,
    });
  }

  bool passwordMatch() =>
      _passwordController.text == _confirmPasswordController.text
          ? true
          : false;

  // 收拾输入框
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 图案
                  const Text(
                    'Registration',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // 空位
                  const SizedBox(
                    height: 20,
                  ),

                  // 姓名
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'name',
                          ),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // 空位
                  const SizedBox(
                    height: 20,
                  ),

                  // 电子资讯
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: TextField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'email',
                          ),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // 空位
                  const SizedBox(
                    height: 20,
                  ),

                  // 密码
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'password',
                          ),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // 空位
                  const SizedBox(
                    height: 20,
                  ),

                  // 密码确认
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: TextField(
                          controller: _confirmPasswordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'confirm password',
                          ),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // 空位
                  const SizedBox(
                    height: 20,
                  ),

                  // 选择角色
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 8.0), // Adjust padding
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween, // Align items to the ends
                            children: [
                              Expanded(
                                child: DropdownButton<String>(
                                  iconSize: 0,
                                  value: _selectedRole,
                                  onChanged: (String? newValue) {
                                    setState(
                                      () {
                                        _selectedRole = newValue!;
                                      },
                                    );
                                  },
                                  underline:
                                      const SizedBox(), // Remove default underline
                                  items: _roleOptions
                                      .map<DropdownMenuItem<String>>(
                                    (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    },
                                  ).toList(),
                                ),
                              ),
                              const Icon(
                                Icons.arrow_drop_down,
                              ), // Dropdown icon
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // 登录按钮
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25.0,
                      vertical: 20.0,
                    ),
                    child: GestureDetector(
                      onTap: signUp,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            "Register",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // 注册按钮
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 18,
                        ),
                      ),
                      GestureDetector(
                        onTap: widget.showLoginPage,
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.blue[600],
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
