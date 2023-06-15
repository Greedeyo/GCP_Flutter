import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CameraController extends GetxController {
  RxString imagePath = ''.obs;

  Future getImage(ImageSource imageSource) async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: imageSource);
    if (image != null) {
      imagePath.value = image.path.toString();
    } else {

    }
  }
}