// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pocket_pal/src/providers/role_provider.dart';
import 'package:pocket_pal/src/providers/user_provider.dart';
import 'package:pocket_pal/src/utils/pickImage.dart';
import 'package:pocket_pal/src/widgets/auth/authButton.dart';
import 'package:pocket_pal/src/widgets/auth/avatarAdd.dart';
import 'package:pocket_pal/src/widgets/auth/dateTextFields.dart';
import 'package:pocket_pal/src/widgets/auth/emailTextFields.dart';
import 'package:pocket_pal/src/widgets/auth/genderSelector.dart';
import 'package:pocket_pal/src/widgets/auth/nameTextFields.dart';
import 'package:pocket_pal/src/widgets/auth/phoneTextFields.dart';
import 'package:pocket_pal/src/widgets/auth/authTextFields.dart';
import 'package:pocket_pal/src/widgets/auth/pwTextFields.dart';
import 'package:pocket_pal/theme/app_theme.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({super.key, required this.showLoginPage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

List<String> genderOptions = ['male', 'female'];
List<String> roleOptions = ['member', 'therapist'];

class _RegisterPageState extends State<RegisterPage> {
  Uint8List? _image;
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneNumController = TextEditingController();
  final _dobController = TextEditingController();
  final _genderController = TextEditingController();
  final _roleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneNumController.dispose();
    _dobController.dispose();
    _genderController.dispose();
    _roleController.dispose();
  }

  String currentGender = genderOptions[0];
  String currentRole = roleOptions[0];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    return Scaffold(
      backgroundColor: AppTheme.backgroundWhite,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/src/assets/images/dottedlinebg.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 35.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: AppTheme.authBackButton,
                      child: const Icon(
                        Icons.arrow_back,
                        color: AppTheme.primaryGreen,
                        size: 24,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(children: [
                    Text("Register ", style: AppTheme.largeTextGreen2),
                    Text("Account", style: AppTheme.largeTextGrey2),
                  ]),
                  SizedBox(height: screenHeight * 0.04),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomAvatar(
                              onPressed: selectImage,
                              imageSrc: _image,
                            ),
                            NameTextField(
                              controller: _firstNameController,
                              hintText: "First name",
                              width: screenWidth,
                            ),
                            NameTextField(
                              controller: _lastNameController,
                              hintText: "Last name",
                              width: screenWidth,
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        EmailTextField(
                          controller: _emailController,
                          width: screenWidth,
                        ),
                        const SizedBox(height: 20),
                        PasswordTextField(
                          controller: _passwordController,
                          width: screenWidth,
                        ),
                        const SizedBox(height: 20),
                        PhoneTextField(
                          controller: _phoneNumController,
                          width: screenWidth,
                        ),
                        const SizedBox(height: 20),
                        DateTextField(
                          controller: _dobController,
                          width: screenWidth,
                        ),
                        const SizedBox(height: 20),
                        Stack(
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                width: screenWidth / 2,
                                height: 50,
                                decoration: AppTheme.lightGreenBorder,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("Gender: ", style: AppTheme.smallTextGrey),
                                SizedBox(width: 1),
                                RadioSelection(
                                  option1: "Male",
                                  option2: "Female",
                                  currentGender: currentGender,
                                  onChanged: (value) {
                                    setState(() => currentGender = value);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Stack(
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                width: screenWidth / 1.65,
                                height: 50,
                                decoration: AppTheme.lightGreenBorder,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("Role: ", style: AppTheme.smallTextGrey),
                                RadioSelection(
                                  option1: "Member",
                                  option2: "Therapist",
                                  currentGender: currentRole,
                                  onChanged: (value) {
                                    setState(() => currentRole = value);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        AuthButton(
                          buttonText: "Sign Up",
                          onTap: () {},
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: AppTheme.smallTextGrey,
                            ),
                            GestureDetector(
                              onTap: widget.showLoginPage,
                              child: Text(
                                " Login now.",
                                style: AppTheme.smallTextGreen,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
