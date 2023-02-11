import 'package:permission_handler/permission_handler.dart';

abstract class PermService {

  static Future<bool> checkAndGetPermission(List<Permission> permissions) async {
    var res = true;
    for (var element in permissions) {
      var granted = await element.isGranted;
      if (!granted) {
        var x = await element.request();
        granted =     x.isGranted;
      }
      res = res && granted;
    }
    return res;
  }
}
