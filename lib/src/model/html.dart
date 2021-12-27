import 'package:html/dom.dart';

typedef ModelCreator<T> = T Function(Element);

abstract class HtmlParsable {
  HtmlParsable.fromHtml(Element html);
}

class BaseModel extends HtmlParsable {
  BaseModel.fromHtml(Element html) : super.fromHtml(html);

  bool isValid() => true;
}
