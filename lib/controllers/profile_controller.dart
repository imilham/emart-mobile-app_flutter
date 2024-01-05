import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  var profileImagePath = ''.obs;

  changeImage() {
    final img =
        ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70);
  }
}
