import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pocket_pal/src/providers/user_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class TherapistEditProfilePage extends StatefulWidget {
  const TherapistEditProfilePage({super.key});

  @override
  State<TherapistEditProfilePage> createState() => _TherapistEditProfilePageState();
}

class _TherapistEditProfilePageState extends State<TherapistEditProfilePage> {
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
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() async {
        _image = Uint8List.fromList(await pickedFile.readAsBytes());
      });
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneNumController.dispose();
    _dobController.dispose();
    _genderController.dispose();
    _roleController.dispose();
    super.dispose();
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
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Profile Updated!'),
        content: Text('Your profile has been updated successfully!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 35.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Row(
              children: [
                Text("Edit ", style: TextStyle(fontSize: 24, color: Colors.green)),
                Text("Profile", style: TextStyle(fontSize: 24, color: Colors.grey)),
              ],
            ),
            SizedBox(height: screenHeight * 0.04),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: selectImage,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: _image != null
                            ? MemoryImage(_image!)
                            : AssetImage('lib/src/assets/images/avatar.png')
                        as ImageProvider,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    controller: _firstNameController,
                    decoration: InputDecoration(labelText: 'First Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: InputDecoration(labelText: 'Last Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _phoneNumController,
                    decoration: InputDecoration(labelText: 'Phone Number'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _dobController,
                    decoration: InputDecoration(labelText: 'Date of Birth'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your date of birth';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _genderController,
                    decoration: InputDecoration(labelText: 'Gender'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your gender';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _roleController,
                    decoration: InputDecoration(labelText: 'Role'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your role';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => _validateAndUpdate(
                        _firstNameController.text,
                        _lastNameController.text,
                        _phoneNumController.text,
                        _dobController.text,
                        _image!,
                      ),
                      child: Text('Save Changes'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        textStyle: TextStyle(fontSize: 16),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
