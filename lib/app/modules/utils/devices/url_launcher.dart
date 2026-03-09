import 'package:url_launcher/url_launcher.dart';

class URLLauncher {
  static void launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  static void call(String number) async {
    String url = "tel:$number";
    await canLaunchUrl(Uri.parse(url))  ? await launchUrl(Uri.parse(url)) : throw 'Could not launch $url';
  }

  static void callNumber(String number) async {
    String url = "tel:$number";
    await canLaunchUrl(Uri.parse(url)) ? await launchUrl(Uri.parse(url)) : throw 'Could not launch $url';
  }

  static Future<void> sendEmail(String email) async {
    final Uri emailUri = Uri(scheme: 'mailto', path: email);

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not launch $emailUri';
    }
  }

  static Future<void> openApp(String urlToOpen) async {
    final Uri uri = Uri.parse(urlToOpen);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $urlToOpen';
    }
  }
}