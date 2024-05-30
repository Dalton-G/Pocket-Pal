import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';

import '../../../providers/therapist/application_provider.dart';

class TherapistApplicationPage extends StatefulWidget {
  final String therapistId;

  const TherapistApplicationPage({required this.therapistId, Key? key}) : super(key: key);

  @override
  _TherapistApplicationPageState createState() => _TherapistApplicationPageState();
}

class _TherapistApplicationPageState extends State<TherapistApplicationPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _specializationController = TextEditingController();
  final _stateOfLicensureController = TextEditingController(text: 'Selangor'); // Hardcoded for now
  String? _resumeFileName;
  PlatformFile? _resumeFile;
  List<PlatformFile> _licenseFiles = [];
  List<String> _licenseFileNames = [];

  @override
  void dispose() {
    _emailController.dispose();
    _specializationController.dispose();
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
        email: _emailController.text,
        specialization: _specializationController.text,
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
        title: Text('Therapist Registration'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
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
              TextFormField(
                controller: _specializationController,
                decoration: InputDecoration(labelText: 'Specialization'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your specialization';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _stateOfLicensureController,
                decoration: InputDecoration(labelText: 'State of Licensure'),
                enabled: false, // Disabled for now, hardcoded value
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _pickFile('resume'),
                child: Text(_resumeFileName == null ? 'Upload Resume' : _resumeFileName!),
              ),
              if (_resumeFileName != null)
                ListTile(
                  title: Text(_resumeFileName!),
                  trailing: IconButton(
                    icon: Icon(Icons.close, color: Colors.red),
                    onPressed: () => _removeFile('resume', 0),
                  ),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _pickFile('license'),
                child: Text(_licenseFileNames.isEmpty
                    ? 'Upload Licenses'
                    : 'Uploaded ${_licenseFileNames.length} License(s)'),
              ),
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
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitApplication,
                child: Text('Submit Application'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
