import 'dart:io';

import 'package:clerk/app/data/models/invoice_data_model.dart';
import 'package:clerk/app/data/models/user_profile_data_model.dart';
import 'package:clerk/app/utils/extensions.dart';
import 'package:clerk/app/values/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/locator.dart';

class UtilityService {
  static Future<bool> launchPhoneIntent(Invoice invoice) async {
    try {
      var intent = 'tel:${invoice.candidate!.contact}';
      late Uri uri = Uri.parse(intent);
      if (await canLaunchUrl(uri)) {
        return launchUrl(uri);
      } else {
        throw Exception("Something went wrong. Please try later");
      }
    } catch (e) {
      throw Exception("Something went wrong. Please try later");
    }
  }

  static String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  static Future<bool> launchSMSIntent(
      Invoice invoice, UserProfile userProfile) async {
    try {
      var intent = 'sms:${invoice.candidate!.contact}';
      var message = _generateWarningMessage(invoice, userProfile);
      late Uri uri;
      if (Platform.isAndroid) {
        uri = Uri.parse('$intent?body=$message');
      } else if (Platform.isIOS) {
        uri = Uri.parse('$intent&body=$message');
      }
      return launchUrl(uri);
    } catch (e) {
      throw Exception("Something went wrong. Please try later");
    }
  }

  static Future<bool> launchMailIntent(
      Invoice invoice, UserProfile userProfile) async {
    try {
      var intent = 'mailto:${invoice.candidate!.email}';
      var message = _generateWarningMessage(invoice, userProfile);
      var subject = Uri.encodeFull(
          'Payment Reminder - Service Fee Due for ${userProfile.businessName}');
      late Uri uri;
      if (Platform.isAndroid) {
        uri = Uri.parse('$intent?subject=$subject&body=$message');
      } else if (Platform.isIOS) {
        uri = Uri.parse('$intent?subject=$subject&body=$message');
      }
      if (await canLaunchUrl(uri)) {
        return launchUrl(uri);
      } else {
        throw Exception("Something went wrong. Please try later");
      }
    } catch (e) {
      throw Exception("Something went wrong. Please try later");
    }
  }

  static String _generateWarningMessage(
      Invoice invoice, UserProfile userProfile) {
    var message = '''Dear ${invoice.candidate?.name ?? ''},
    This is a reminder that your payment of ${invoice.totalAmount.toStringAsFixed(2)} INR for ${userProfile.businessName} is ${invoice.dueDate?.isBefore(DateTime.now()) ?? false ? 'overdue' : 'due'} ${invoice.dueDate != null ? 'by ${DateFormat('MMMM dd, yyyy').format(invoice.dueDate!)}' : ''}. Please settle the outstanding amount at our office to ensure timely payment.
    If you have any questions, please contact our customer support team at ${userProfile.businessContact}. Prompt payment is crucial to maintain uninterrupted services.
    Thank you for your cooperation.
    
    Yours sincerely,
    ${userProfile.firstName} ${userProfile.lastName}
    ${userProfile.occupation}
    ${userProfile.businessName}
    ${userProfile.businessAddress}
    Email: ${userProfile.businessEmail}, Phone: ${userProfile.businessContact}
    ''';
    return Uri.encodeFull(message);
  }

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
    if(message.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
        ),
        backgroundColor: Colors.red,
      ),
    );
    }
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
