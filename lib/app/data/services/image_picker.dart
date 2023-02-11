import 'package:clerk/app/data/services/perm_service.dart';
import 'package:clerk/app/utils/custom_exception_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class CustomImagePicker {
  static Future<XFile?> pickFromCamera() async {
    try {
      var isPermGranted = await PermService.checkAndGetPermission([Permission.camera]);
      if(!isPermGranted){
        throw Exception("Please allow access to Camera");
      }
      var res = await ImagePicker().pickImage(source: ImageSource.camera);
      if (res != null) {
        return res;
      } else {
        throw Exception("Image not fetched properly");
      }
    } on Exception catch (e) {
      CustomExceptionHandler.handle(e);
    }
    return null;
  }
  static Future<XFile?> pickFromGallery() async {
    try {
      var isPermGranted = await PermService.checkAndGetPermission([Permission.mediaLibrary]);
      if(!isPermGranted){
        throw Exception("Please allow access to Gallery");
      }
      var res = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (res != null) {
        return res;
      } else {
        throw Exception("Image not fetched properly");
      }
    } on Exception catch (e) {
      CustomExceptionHandler.handle(e);
    }
    return null;
  }
}
