import 'dart:io';
import 'package:image_picker/image_picker.dart';

//open camera and gallery
Future<File> getImage() async {
  var image = await ImagePicker.pickImage(source: ImageSource.gallery);
  return image;
}
