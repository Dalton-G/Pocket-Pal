import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pocket_pal/src/providers/auth/user_provider.dart';
import 'package:pocket_pal/src/utils/admin/pick_image.dart';
import 'package:pocket_pal/src/widgets/admin/edit_profile/edit_dob_TF.dart';
import 'package:pocket_pal/src/widgets/admin/edit_profile/edit_email_TF.dart';
import 'package:pocket_pal/src/widgets/admin/edit_profile/edit_gender.TF.dart';
import 'package:pocket_pal/src/widgets/admin/edit_profile/edit_name_TF.dart';
import 'package:pocket_pal/src/widgets/admin/edit_profile/edit_phone_TF.dart';
import 'package:pocket_pal/src/widgets/admin/edit_profile/edit_role_TF.dart';
import 'package:pocket_pal/src/widgets/auth/alertDialog.dart';
import 'package:pocket_pal/src/widgets/auth/authButton.dart';
import 'package:pocket_pal/src/widgets/auth/authButtonOutline.dart';
import 'package:pocket_pal/src/widgets/auth/avatarAdd.dart';
import 'package:pocket_pal/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class AdminEditProfilePage extends StatefulWidget {
  const AdminEditProfilePage({super.key});

  @override
  State<AdminEditProfilePage> createState() => _AdminEditProfilePageState();
}

class _AdminEditProfilePageState extends State<AdminEditProfilePage> {
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
    _genderController.dispose();
    _roleController.dispose();
  }

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final currentUser = userProvider.userModel;
    _firstNameController.text = currentUser!.firstName;
    _lastNameController.text = currentUser.lastName;
    _emailController.text = currentUser.email;
    _phoneNumController.text = currentUser.phone;
    _dobController.text = currentUser.dateOfBirth;
    _genderController.text = currentUser.gender;
    _roleController.text = currentUser.role;
    _fetchImageData(currentUser.profilePicture);
  }

  Future<void> _fetchImageData(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      setState(() {
        _image = response.bodyBytes;
      });
    } else {
      print("Error fetching image: ${response.statusCode}");
    }
  }

  Future<void> _validateAndUpdate(String firstName, String lastName,
      String phone, String dob, Uint8List image) async {
    if (_formKey.currentState!.validate()) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final currentUser = userProvider.userModel;
      userProvider.updateUserProfile(
        userId: currentUser!.id,
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        dateOfBirth: dob,
        profilePicture: image,
      );
    }
    showAuthDialog(context, 'Profile Updated!',
        'Your profile has been updated successfully!');
  }

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
                    Text("Edit ", style: AppTheme.largeTextGreen2),
                    Text("Profile", style: AppTheme.largeTextGrey2),
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
                            EditNameTextField(
                              controller: _firstNameController,
                              hintText: "First name",
                              width: screenWidth,
                            ),
                            EditNameTextField(
                              controller: _lastNameController,
                              hintText: "Last name",
                              width: screenWidth,
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        EditEmailTextField(
                          controller: _emailController,
                          width: screenWidth,
                        ),
                        const SizedBox(height: 20),
                        EditPhoneTextField(
                          controller: _phoneNumController,
                          width: screenWidth,
                        ),
                        const SizedBox(height: 20),
                        EditDateTextField(
                          controller: _dobController,
                          width: screenWidth,
                        ),
                        const SizedBox(height: 20),
                        EditGenderTextField(
                            controller: _genderController, width: screenWidth),
                        const SizedBox(
                          height: 20,
                        ),
                        EditRoleTextField(
                            controller: _roleController, width: screenWidth),
                        const SizedBox(height: 30),
                        AuthButton(
                          buttonText: "Update Profile",
                          onTap: () => _validateAndUpdate(
                            _firstNameController.text,
                            _lastNameController.text,
                            _phoneNumController.text,
                            _dobController.text,
                            _image!,
                          ),
                        ),
                        const SizedBox(height: 20),
                        AuthButtonOutline(
                          buttonText: "Log Out",
                          onTap: () {
                            context.read<UserProvider>().logout();
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(height: 10),
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
