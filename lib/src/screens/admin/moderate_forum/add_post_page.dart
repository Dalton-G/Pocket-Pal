import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pocket_pal/src/providers/auth/user_provider.dart';
import 'package:pocket_pal/src/providers/forum/post_provider.dart';
import 'package:pocket_pal/src/utils/admin/pick_image.dart';
import 'package:pocket_pal/src/widgets/auth/alertDialog.dart';
import 'package:pocket_pal/src/widgets/auth/authButton.dart';
import 'package:pocket_pal/src/widgets/forum/postDescTF.dart';
import 'package:pocket_pal/src/widgets/forum/postTitleTF.dart';
import 'package:pocket_pal/theme/app_theme.dart';
import 'package:provider/provider.dart';

final List<String> _categories = ["Anxiety", "Depression", "Loneliness"];

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  Uint8List? _image;
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  String _selectedCategory = _categories[0];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void selectImage() async {
    Uint8List? img = await pickImage(ImageSource.gallery);
    if (img == null) return;
    setState(() {
      _image = img;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _validateAndSubmit() {
    if (_formKey.currentState!.validate()) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final authorId = userProvider.userModel?.id;
      final title = _titleController.text;
      final desc = _descController.text;
      final category = _selectedCategory;
      if (_image == null) {
        showAuthDialog(
            context, 'Missing Thumbnail', 'Please include a thumbnail');
        return;
      }
      if (authorId != null) {
        Provider.of<PostProvider>(context, listen: false)
            .addNewpost(authorId, title, desc, _image!, category);
        Navigator.pop(context);
        showAuthDialog(context, 'Success', 'Post have been added to database!');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Post"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _image != null
                  ? GestureDetector(
                      onTap: selectImage,
                      child: Container(
                        height: 200.0,
                        width: screenWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: MemoryImage(_image!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: selectImage,
                      child: Stack(
                        children: [
                          Container(
                            height: 200.0,
                            width: screenWidth,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: AppTheme.secondaryGreen),
                          ),
                          Positioned(
                            top: 200 / 2.5,
                            left: screenWidth / 2.7,
                            child: Icon(
                              Icons.image,
                              color: AppTheme.primaryGreen,
                              size: 50,
                            ),
                          ),
                        ],
                      ),
                    ),
              const SizedBox(height: 10.0),
              Divider(
                color: AppTheme.primaryGreen,
                thickness: 3,
              ),
              const SizedBox(height: 10),
              Text("Enter your post details:", style: AppTheme.mediumTextGreen),
              const SizedBox(height: 20),
              PostTitleTF(controller: _titleController, width: screenWidth),
              const SizedBox(height: 20),
              PostDescTF(controller: _descController, width: screenWidth),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: AppTheme.categoryDropdownMenu,
                style: AppTheme.normalTextGrey,
                value: _selectedCategory,
                items: _categories
                    .map((String category) => DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue!;
                  });
                },
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => _validateAndSubmit(),
                child: AuthButton(buttonText: 'Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
