import 'package:cookie_jar/cookie_jar.dart';
import 'package:v2fly/src/common/path.dart';

var cookieJar = PersistCookieJar(storage: FileStorage(AppPath.instance.tempCookieDirPath));