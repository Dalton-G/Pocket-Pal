import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pocket_pal/src/providers/user_provider.dart';
import 'package:pocket_pal/src/providers/therapist/application_provider.dart';
import 'package:pocket_pal/theme/app_theme.dart';
import 'package:pocket_pal/src/enums/specialization.dart';

class TherapistApplicationPage extends StatefulWidget {
  final String therapistId;

  const TherapistApplicationPage({required this.therapistId, Key? key}) : super(key: key);

  @override
  _TherapistApplicationPageState createState() => _TherapistApplicationPageState();
}

class _TherapistApplicationPageState extends State<TherapistApplicationPage> {
  final _formKey = GlobalKey<FormState>();
  final _stateOfLicensureController = TextEditingController(text: 'Selangor'); // Hardcoded for now
  Specialization? _specialization;
  String? _resumeFileName;
  PlatformFile? _resumeFile;
  List<PlatformFile> _licenseFiles = [];
  List<String> _licenseFileNames = [];

  @override
  void dispose() {
    _stateOfLicensureController.dispose();
    super.dispose();
  }

  Future<void> _pickFile(String fileType) async {
    FilePickerResult? result;
    if (fileType == 'resume') {
      result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );
      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _resumeFileName = result?.files.single.name;
          _resumeFile = result?.files.single;
        });
      }
    } else if (fileType == 'license') {
      result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'png', 'jpeg', 'jpg'],
        allowMultiple: true,
      );
      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _licenseFiles.addAll(result?.files as Iterable<PlatformFile>);
          _licenseFileNames.addAll(result!.files.map((file) => file.name));
        });
      }
    }
  }

  Future<void> _submitApplication() async {
    if (_formKey.currentState!.validate()) {
      await context.read<ApplicationProvider>().submitApplication(
        therapistId: widget.therapistId,
        specialization: _specialization!.displayName,
        stateOfLicensure: _stateOfLicensureController.text,
        resumeFile: _resumeFile!,
        licenseFiles: _licenseFiles,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Application Submitted')),
      );
      // TODO: navigate elsewhere
    }
  }

  void _removeFile(String fileType, int index) {
    setState(() {
      if (fileType == 'resume') {
        _resumeFile = null;
        _resumeFileName = null;
      } else if (fileType == 'license') {
        _licenseFiles.removeAt(index);
        _licenseFileNames.removeAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Therapist Application'),
        backgroundColor: AppTheme.primaryGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 20),
              _buildDropdownField(
                label: 'Specialization',
                value: _specialization,
                items: Specialization.values.map((specialization) => specialization.displayName).toList(),
                onChanged: (value) {
                  setState(() {
                    _specialization = Specialization.values.firstWhere((specialization) => specialization.displayName == value);
                  });
                },
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: _stateOfLicensureController,
                label: 'State of Licensure',
                hintText: 'Selangor',
                enabled: false,
              ),
              const SizedBox(height: 20),
              _buildFilePickerButton('Upload Resume', 'resume', AppTheme.primaryGreen),
              if (_resumeFileName != null)
                ListTile(
                  title: Text(_resumeFileName!),
                  trailing: IconButton(
                    icon: Icon(Icons.close, color: Colors.red),
                    onPressed: () => _removeFile('resume', 0),
                  ),
                ),
              const SizedBox(height: 20),
              _buildFilePickerButton('Upload Licenses', 'license', AppTheme.primaryGreen),
              ..._licenseFileNames.asMap().entries.map((entry) {
                int index = entry.key;
                String fileName = entry.value;
                return ListTile(
                  title: Text(fileName),
                  trailing: IconButton(
                    icon: Icon(Icons.close, color: Colors.red),
                    onPressed: () => _removeFile('license', index),
                  ),
                );
              }).toList(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitApplication,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryOrange,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  'Submit',
                  style: AppTheme.onboardingButtonText,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<UserProvider>().logout(),
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.logout),
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required Specialization? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.mediumTextGreen,
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value?.displayName,
          items: items.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppTheme.primaryGreen),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppTheme.primaryGreen),
              borderRadius: BorderRadius.circular(10),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          validator: (value) => value == null ? 'Please select a specialization' : null,
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    bool enabled = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.mediumTextGreen,
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTheme.textFieldHint1,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppTheme.primaryGreen),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppTheme.primaryGreen),
              borderRadius: BorderRadius.circular(10),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppTheme.primaryGreen),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          enabled: enabled,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $label';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildFilePickerButton(String text, String fileType, Color backgroundColor) {
    return ElevatedButton(
      onPressed: () => _pickFile(fileType),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Text(
        text,
        style: AppTheme.onboardingButtonText,
      ),
    );
  }
}
