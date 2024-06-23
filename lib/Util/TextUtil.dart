import 'dart:ui';
import 'package:wowondertimelineflutterapp/main.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:keyboard_actions/keyboard_actions.dart';


//Urbanist //Fonts.font3//SF Pro Display
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

TextStyle SafeGoogleFont(
  String fontFamily, {
  TextStyle? textStyle,
  Color? color,
  Color? backgroundColor,
  double? fontSize,
  FontWeight? fontWeight,
  FontStyle? fontStyle,
  double? letterSpacing,
  double? wordSpacing,
  TextBaseline? textBaseline,
  double? height,
  Locale? locale,
  Paint? foreground,
  Paint? background,
  List<Shadow>? shadows,
  List<FontFeature>? fontFeatures,
  TextDecoration? decoration,
  Color? decorationColor,
  TextDecorationStyle? decorationStyle,
  double? decorationThickness,
}) {
  try {
    return GoogleFonts.getFont(
      fontFamily,
      textStyle: textStyle,
      color: color,
      backgroundColor: backgroundColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      height: height,
      locale: locale,
      foreground: foreground,
      background: background,
      shadows: shadows,
      fontFeatures: fontFeatures,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
    );
  } catch (ex) {
    return GoogleFonts.getFont(
      'Urbanist',
      textStyle: textStyle,
      color: color,
      backgroundColor: backgroundColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      height: height,
      locale: locale,
      foreground: foreground,
      background: background,
      shadows: shadows,
      fontFeatures: fontFeatures,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
    );
  }
}

String validationEmail =
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
String imageasst = 'assets/images/';
String validationName = r'^[a-z A-Z]+$';

double sizeH(context, w) {
  var size = MediaQuery.of(context).size.height * w;
  return size;
}

double sizeW(context, h) {
  var size = MediaQuery.of(context).size.width * h;
  return size;
}

/// Creates the [KeyboardActionsConfig] to hook up the fields
/// and their focus nodes to our [FormKeyboardActions].
KeyboardActionsConfig buildConfigDone(BuildContext context, nodetext) {
  return KeyboardActionsConfig(
    nextFocus: true,
    actions: [
      KeyboardActionsItem(
        focusNode: nodetext,
      ),
    ],
  );
}

UrlGo(url) async {
  if (!await launchUrl(
    Uri.parse(url),
    mode: LaunchMode.externalApplication,
    webViewConfiguration: const WebViewConfiguration(
        enableDomStorage: true, enableJavaScript: true),
  )) {
    throw Exception('Could not launch $url');
  }
}

Stringlength({required String text, required int length}) {
  return text.length > length
      ? text.substring(0, length).replaceAll('<br>', '') + '...'
      : text.toString();
}

String CurrencyConverter(String text) {
  final currencySymbolArray =
      GetSetList[0]['currency_symbol_array']; // Initialize an empty map

  if (currencySymbolArray.containsKey(text)) {
    return ReplaceCurrency(currencySymbolArray[text]!);
  } else {
    return "Currency not found";
  }
}

ReplaceCurrency(String postText) {
  return postText
      .replaceAll('&#36;', '\$')
      .replaceAll('&#8364;', '€')
      .replaceAll('&#36;', '\$')
      .replaceAll('&#8364;', '€')
      .replaceAll('&#165;', '¥')
      .replaceAll('&#8378;', '₺')
      .replaceAll('&#163;', '£')
      .replaceAll('&#8381;', '₽')
      .replaceAll('&#122;&#322;', 'zł')
      .replaceAll('&#8362;', '₪')
      .replaceAll('&#82;&#36;', 'R\$')
      .replaceAll('&#8377;', '₹');
}

ReplaceCharacter(String postText) {
  return postText
      .replaceAll('<br>', '\n')
      .replaceAll('<br/>', '\n')
      .replaceAll('&#039;', '\'')
      .replaceAll('&quot;', '\"')
      .replaceAll('&amp;', '&')
      .replaceAll('&lt;', '<')
      .replaceAll('&gt;', '>')
      .replaceAll('&#039;', '\'')
      .replaceAll('&euro;', '€')
      .replaceAll('&lsquo;', '‘')
      .replaceAll('&rsquo;', '’')
      .replaceAll('&ldquo;', '“')
      .replaceAll('&rdquo;', '”')
      .replaceAll('&lsaquo;', '‹')
      .replaceAll('&rsaquo;', '›')
      .replaceAll('&ndash;', '–')
      .replaceAll('&mdash;', '—')
      .replaceAll('&permil;', '‰')
      .replaceAll('&nbsp;', ' ')
      .replaceAll('&copy;', '©')
      .replaceAll('&reg;', '®')
      .replaceAll('&trade;', '™')
      .replaceAll('&cent;', '¢')
      .replaceAll('&pound;', '£')
      .replaceAll('&yen;', '¥')
      .replaceAll('&sect;', '§')
      .replaceAll('&brvbar;', '¦')
      .replaceAll('&uml;', '¨')
      .replaceAll('&iexcl;', '¡')
      .replaceAll('&curren;', '¤')
      .replaceAll('&ordf;', 'ª')
      .replaceAll('&laquo;', '«')
      .replaceAll('&not;', '¬')
      .replaceAll('&shy;', '­')
      .replaceAll('&macr;', '¯')
      .replaceAll('&deg;', '°')
      .replaceAll('&plusmn;', '±')
      .replaceAll('&sup2;', '²')
      .replaceAll('&sup3;', '³')
      .replaceAll('&acute;', '´')
      .replaceAll('&micro;', 'µ')
      .replaceAll('&para;', '¶')
      .replaceAll('&middot;', '·')
      .replaceAll('&cedil;', '¸')
      .replaceAll('&sup1;', '¹')
      .replaceAll('&ordm;', 'º')
      .replaceAll('&raquo;', '»')
      .replaceAll('&frac14;', '¼')
      .replaceAll('&frac12;', '½')
      .replaceAll('&frac34;', '¾')
      .replaceAll('&iquest;', '¿')
      .replaceAll('&Agrave;', 'À')
      .replaceAll('&Aacute;', 'Á')
      .replaceAll('&Acirc;', 'Â')
      .replaceAll('&Atilde;', 'Ã')
      .replaceAll('&Auml;', 'Ä')
      .replaceAll('&Aring;', 'Å')
      .replaceAll('&AElig;', 'Æ')
      .replaceAll('&Ccedil;', 'Ç')
      .replaceAll('&Egrave;', 'È')
      .replaceAll('&Eacute;', 'É')
      .replaceAll('&Ecirc;', 'Ê')
      .replaceAll('&Euml;', 'Ë')
      .replaceAll('&Igrave;', 'Ì')
      .replaceAll('&Iacute;', 'Í')
      .replaceAll('&Icirc;', 'Î')
      .replaceAll('&Iuml;', 'Ï')
      .replaceAll('&ETH;', 'Ð')
      .replaceAll('&Ntilde;', 'Ñ')
      .replaceAll('&Ograve;', 'Ò')
      .replaceAll('&Oacute;', 'Ó')
      .replaceAll('&Ocirc;', 'Ô')
      .replaceAll('&Otilde;', 'Õ')
      .replaceAll('&Ouml;', 'Ö')
      .replaceAll('&times;', '×')
      .replaceAll('&Oslash;', 'Ø')
      .replaceAll('&Ugrave;', 'Ù')
      .replaceAll('&Uacute;', 'Ú')
      .replaceAll('&Ucirc;', 'Û')
      .replaceAll('&Uuml;', 'Ü')
      .replaceAll('&Yacute;', 'Ý')
      .replaceAll('&THORN;', 'Þ')
      .replaceAll('&szlig;', 'ß')
      .replaceAll('&agrave;', 'à')
      .replaceAll('&aacute;', 'á')
      .replaceAll('&acirc;', 'â')
      .replaceAll('&atilde;', 'ã')
      .replaceAll('&auml;', 'ä')
      .replaceAll('&aring;', 'å')
      .replaceAll('&aelig;', 'æ')
      .replaceAll('&ccedil;', 'ç')
      .replaceAll('&egrave;', 'è')
      .replaceAll('&eacute;', 'é')
      .replaceAll('&ecirc;', 'ê')
      .replaceAll('&euml;', 'ë')
      .replaceAll('&igrave;', 'ì')
      .replaceAll('&iacute;', 'í')
      .replaceAll('&icirc;', 'î')
      .replaceAll('&iuml;', 'ï')
      .replaceAll('&eth;', 'ð')
      .replaceAll('&ntilde;', 'ñ')
      .replaceAll('&ograve;', 'ò')
      .replaceAll('&oacute;', 'ó')
      .replaceAll('&ocirc;', 'ô')
      .replaceAll('&otilde;', 'õ')
      .replaceAll('&ouml;', 'ö')
      .replaceAll('&divide;', '÷')
      .replaceAll('&oslash;', 'ø')
      .replaceAll('&ugrave;', 'ù')
      .replaceAll('&uacute;', 'ú')
      .replaceAll('&ucirc;', 'û')
      .replaceAll('&uuml;', 'ü')
      .replaceAll('&yacute;', 'ý')
      .replaceAll('&thorn;', 'þ')
      .replaceAll('&yuml;', '')
      .replaceAll('&#8482;', '™')
      .replaceAll('&#169;', '©')
      .replaceAll('&#174;', '®')
      .replaceAll('&#162;', '¢')
      .replaceAll('&#163;', '£')
      .replaceAll('&#165;', '¥')
      .replaceAll('&#167;', '§')
      .replaceAll('&#191;', '¿')
      .replaceAll('&#8480;', '℠');
}

Widget LoadingProgressBarr() {
  return Center(
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
          valueColor: AlwaysStoppedAnimation(ColorTheme),
        ),
        height: 20.0,
        width: 20.0,
      ),
      SizedBox(
        height: 6,
      ),
      Text(
        "Loading...",
        style: TextStyle(fontSize: 12),
      )
    ],
  ));
}

FixEmptyValue(String SiteValue, AppValue) {
  return SiteValue == '' ? AppValue : SiteValue;
}
