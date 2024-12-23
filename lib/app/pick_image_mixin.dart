import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

mixin PickImageMixin {
  final _imageProvider = ImagePicker();

  Future<Uint8List?> chooseFile() async {
    final image = await _imageProvider.pickImage(source: ImageSource.gallery);
    return await image?.readAsBytes();
  }
}
