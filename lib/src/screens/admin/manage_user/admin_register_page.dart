// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pocket_pal/src/providers/auth/user_provider.dart';
import 'package:pocket_pal/src/utils/admin/pick_image.dart';
import 'package:pocket_pal/src/widgets/auth/alertDialog.dart';
import 'package:pocket_pal/src/widgets/auth/authButton.dart';
import 'package:pocket_pal/src/widgets/auth/avatarAdd.dart';
import 'package:pocket_pal/src/widgets/auth/dateTextFields.dart';
import 'package:pocket_pal/src/widgets/auth/emailTextFields.dart';
import 'package:pocket_pal/src/widgets/auth/radioSelector.dart';
import 'package:pocket_pal/src/widgets/auth/nameTextFields.dart';
import 'package:pocket_pal/src/widgets/auth/phoneTextFields.dart';
import 'package:pocket_pal/src/widgets/auth/pwTextFields.dart';
import 'package:pocket_pal/theme/app_theme.dart';
import 'package:provider/provider.dart';

class AdminRegisterPage extends StatefulWidget {
  const AdminRegisterPage({super.key});

  @override
  State<AdminRegisterPage> createState() => AdminRegisterPageState();
}

List<String> genderOptions = ['Male', 'Female'];

class AdminRegisterPageState extends State<AdminRegisterPage> {
  Uint8List? _image;
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneNumController = TextEditingController();
  final _dobController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void selectImage() async {
    Uint8List? img = await pickImage(ImageSource.gallery);
    if (img == null) return;
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
  }

  void _validateAndSignUp(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        await context.read<UserProvider>().createAdminAcc(
              _emailController.text.trim(),
              _passwordController.text.trim(),
              _firstNameController.text.trim(),
              _lastNameController.text.trim(),
              _phoneNumController.text.trim(),
              currentGender,
              currentRole,
              _dobController.text.trim(),
              _image,
            );
        showAuthDialog(context, "Registration Success!",
            "You may now login to this new admin account.");
        clearForm();
      } catch (error) {
        showAuthDialog(
          context,
          'Registration Failed',
          'Error: $error',
        );
      }
    }
  }

  void clearForm() {
    _firstNameController.clear();
    _lastNameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _phoneNumController.clear();
    _dobController.clear();
    setState(() {
      _image = null;
    });
  }

  String currentGender = genderOptions[0];
  String currentRole = "Admin";

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
                    Text("Admin", style: AppTheme.largeTextGrey2),
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
                                  option1: genderOptions[0],
                                  option2: genderOptions[1],
                                  groupValue: currentGender,
                                  onChanged: (value) {
                                    setState(() {
                                      currentGender = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        AuthButton(
                          buttonText: "Create Admin Account",
                          onTap: () => _validateAndSignUp(context),
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
