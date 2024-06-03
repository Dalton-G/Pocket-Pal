import 'package:image_picker/image_picker.dart';

pickImage(ImageSource src) async {
  final ImagePicker _picker = ImagePicker();
  XFile? _file = await _picker.pickImage(source: src);
  if (_file != null) {
    return await _file.readAsBytes();
  }
  return;
}
