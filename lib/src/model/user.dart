import 'package:html/dom.dart';
import 'package:v2fly/src/model/html.dart';

class User extends BaseModel {
  late String _name;
  late String _avatar;
  late int _index;
  DateTime? _addTime;
  final List<Social> _socials = [];

  User.fromHtml(Element html) : super.fromHtml(html);

  String get name => _name;

  String get avatar => _avatar;

  int get index => _index;

  DateTime? get addTime => _addTime;

  List<Social> get socials => _socials;

  @override
  String toString() {
    return 'User{name: $name, avatar: $avatar, index: $index, addTime: $addTime, socials: $socials}';
  }
}

class Social extends BaseModel {
  late String _icon;
  late String _url;

  Social.fromHtml(Element html) : super.fromHtml(html);

  String get icon => _icon;

  String get url => _url;

  @override
  String toString() {
    return 'Social{icon: $icon, url: $url}';
  }
}
