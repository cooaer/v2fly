import 'package:html/dom.dart';

typedef StringConverter<T> = T? Function(String);

extension MyElement on Element {
  T? query<T>(String selector,
      {String attr = HtmlAttribute.text,
        String? pattern,
        StringConverter? convert,
        T? defValue}) {
    final element = querySelector(selector);

    String? result;
    switch (attr) {
      case HtmlAttribute.text:
        result = element?.text;
        break;
      case HtmlAttribute.innerHtml:
        result = element?.innerHtml;
        break;
      default:
        result = element?.attributes[attr];
        break;
    }

    if (result != null && pattern != null) {
      final regex = RegExp(pattern);
      final match = regex.firstMatch(result);
      if (match != null) {
        result = match.group(1);
      }
    }

    if(result != null && String is T){
      return result as T;
    }

    if (result != null && convert != null) {
      return convert(result) ?? defValue;
    }

    return defValue;
  }

  List<Element> queryAll(String selector) {
    return querySelectorAll(selector);
  }
}

class HtmlAttribute {
  static const text = "text";
  static const ownText = "ownText";
  static const innerHtml = "inner_html";
  static const href = "href";
  static const src = "src";
  static const id = "id";
  static const cls = "class";
  static const alt = "alt";
}
