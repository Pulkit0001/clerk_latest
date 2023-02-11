import 'package:clerk/app/utils/extensions.dart';
import 'package:clerk/app/values/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../utils/locator.dart';

class UtilityService {
  // Display a message to the user.
  static void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
      ),
    );
  }

  static void showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,

        ),
        backgroundColor: primaryColor,
      ),
    );
  }

  // Print message on console
  static void cprint(
      String message, {
        dynamic error,
        String? label,
        StackTrace? stackTrace,
        bool enableLogger = true,
      }) {
    if (kDebugMode) {
      // ignore: avoid_print
      if (error != null) {
        logger.e(message, error, stackTrace);
      } else {
        if (enableLogger) {
          logger.i(
            "[${label ?? 'Log'}] ${DateTime.now().toIso8601String().toHMTime} $message",
          );
        } else {
          // ignore: avoid_print
          print("[${label ?? 'Log'}] $message");
        }
      }
    }
  }

  static String encodeStateMessage(String? message) {
    if (message != null) {
      final mess = '$message ##${DateTime.now().microsecondsSinceEpoch}';
      return mess;
    }
    return '';
  }

  static String decodeStateMessage(String? message) {
    if (message != null && message.contains('##')) {
      return message.split('##')[0];
    }
    return '';
  }
  //
  // static Future<void> launch(String? url) async {
  //   if (!url.isNotNullEmpty) {
  //     return;
  //   }
  //   var uri = Uri.tryParse(url!)!;
  //   if (uri.scheme.isEmpty) {
  //     uri = Uri.parse('https://$url');
  //   }
  //
  //   await launchUrl(uri);
  // }

  // static Future<String> getSharableLink(
  //     String id, {
  //       SocialMetaTagParameters? socialMetaTagParameters,
  //     }) async {
  //   final parameters = DynamicLinkParameters(
  //     uriPrefix: 'https://ondecapp.page.link',
  //     link: Uri.parse('https://ondecapp.page.link/$id'),
  //     androidParameters: const AndroidParameters(packageName: 'com.OnDec.io'),
  //     iosParameters: const IOSParameters(
  //       bundleId: 'com.app.ondec',
  //       appStoreId: '1608709930',
  //     ),
  //     socialMetaTagParameters: socialMetaTagParameters,
  //   );
  //
  //   Uri url;
  //
  //   final shortLink =
  //   await FirebaseDynamicLinks.instance.buildShortLink(parameters);
  //   url = shortLink.shortUrl;
  //
  //   return url.toString();
  // }
  //
  // static void share(String? text) {
  //   if (text.isNotNullEmpty) {
  //     Share.share(text!, subject: '');
  //   }
  // }
  //
  // static void shareFile(
  //     List<String> paths, {
  //       List<String>? mimeTypes,
  //       String? subject,
  //       String? text,
  //       Rect? sharePositionOrigin,
  //     }) {
  //   if (paths.isNotNullEmpty) {
  //     Share.shareFiles(
  //       paths,
  //       mimeTypes: mimeTypes,
  //       subject: subject,
  //       text: text,
  //       sharePositionOrigin: sharePositionOrigin,
  //     );
  //   }
  // }
}
