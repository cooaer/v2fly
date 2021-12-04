class Json {
  static int getInt(Map<String, dynamic> json, String key,
      {int defaultValue = 0}) {
    dynamic value = json[key];
    if (value is int) {
      return value;
    }
    if (value is String) {
      try {
        return int.parse(value);
      } on TypeError catch (e) {
        print(e);
      }
    }
    return defaultValue;
  }

  static double getDouble(Map<String, dynamic> json, String key,
      {double defaultValue = 0}) {
    dynamic value = json[key];
    if (value is double) {
      return value;
    }
    if (value is String) {
      try {
        return double.parse(value);
      } on TypeError catch (e) {
        print(e);
      }
    }
    return defaultValue;
  }

  static String getString(Map<String, dynamic> json, String key,
      {String defaultValue = ''}) {
    var value = json[key];
    if (value != null) {
      return value.toString();
    }
    return defaultValue;
  }

  static bool getBool(Map<String, dynamic> json, String key,
      {bool defaultValue = false}) {
    var value = json[key];
    if (value is bool) {
      return value;
    }
    if (value is String) {
      return bool.fromEnvironment(value);
    }
    return defaultValue;
  }

  static Map getMap(Map<String, dynamic> json, String key,
      {Map defaultValue = const {}}) {
    var value = json[key];
    return value is Map ? value : defaultValue;
  }

  static List getList(Map<String, dynamic> json, String key,
      {List defaultValue = const []}) {
    var value = json[key];
    return value is List ? value : defaultValue;
  }

  static T getObject<T>(Map<String, dynamic> json, String key, T defaultValue) {
    var value = json[key];
    return value is T ? value : defaultValue;
  }
}
