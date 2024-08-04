class Data {
  /// Singleton
  static final Data _instance = Data._internal();
  factory Data() => _instance;
  Data._internal();

  static const Duration duration = Duration(milliseconds: 480);

  static bool isList(data) {
    return data != null && data is Iterable && data.isNotEmpty;
  }

  static bool toBool(data, {bool preset = false}) {
    if (data == null) {
      return preset;
    } else {
      if (data is bool) return data;
      if (data is int) {
        if (data == 0) return false;
        if (data == 1) return true;
      }
      if (data is String) {
        int? integer = int.tryParse(data);
        if (integer == null) return preset;
        if (integer == 0) return false;
        if (integer == 1) return true;
      }
      return preset;
    }
  }

  static String toStr(data, {String preset = ""}) {
    if (data == null) {
      return preset;
    } else {
      if (data is String) {
        if (data.isEmpty) {
          return preset;
        } else {
          return data;
        }
      } else {
        return data.toString();
      }
    }
  }

  static String? nullStr(data, {String? preset}) {
    String value = toStr(data);
    if (value.isEmpty) {
      return preset;
    } else {
      return value;
    }
  }

  static List<String> toStrList(data, {List<String>? preset}) {
    List<String> list = preset ?? <String>[];
    if (isList(data)) {
      for (var v in data) {
        list.add(toStr(v));
      }
    }
    return list;
  }

  static int toInt(data, {int preset = 0}) {
    if (data == null) {
      return preset;
    } else {
      if (data is int) return data;
      if (data is double) return data.round();
      if (data is bool) return data ? 1 : 0;
      if (data is String) {
        int? integer = int.tryParse(data);
        if (integer == null) {
          double? float = double.tryParse(data);
          return float == null ? preset : float.round();
        } else {
          return integer;
        }
      }
      return preset;
    }
  }

  static int? absInt(data, {int? preset}) {
    int value = toInt(data);
    return value > 0 ? value : preset;
  }

  static List<int> toIntList(data, {List<int>? preset}) {
    List<int> list = preset ?? <int>[];
    if (isList(data)) {
      for (var v in data) {
        list.add(toInt(v));
      }
    }
    return list;
  }

  static double toDouble(data, {double preset = 0.0}) {
    if (data == null) {
      return preset;
    } else {
      if (data is double) return data;
      if (data is int) return data.toDouble();
      if (data is String) {
        double? float = double.tryParse(data);
        return float ?? preset;
      }
      return preset;
    }
  }

  static double? absDouble(data, {double? preset}) {
    double value = toDouble(data);
    return value > 0.0 ? value : preset;
  }

  static List<double> toDoubleList(data, {List<double>? preset}) {
    List<double> list = preset ?? <double>[];
    if (isList(data)) {
      for (var v in data) {
        list.add(toDouble(v));
      }
    }
    return list;
  }

  static Map<String, dynamic> toMap(data, {Map<String, dynamic>? preset}) {
    return data != null && data is Map<String, dynamic>
        ? data
        : preset ?? <String, dynamic>{};
  }

  static List<Map<String, dynamic>> toMapList(data,
      {List<Map<String, dynamic>>? preset}) {
    List<Map<String, dynamic>> list = preset ?? <Map<String, dynamic>>[];
    if (isList(data)) {
      for (var v in data) {
        if (v is Map<String, dynamic>) list.add(v);
      }
    }
    return list;
  }

  static Map<String, String> toMapStr(data, {Map<String, String>? preset}) {
    Map<String, String> mapStr = preset ?? <String, String>{};
    if (data != null && data is Map<String, dynamic>) {
      data.forEach((key, value) {
        mapStr[key] = Data.toStr(value);
      });
    }

    return mapStr;
  }

  static int toEpochSeconds(DateTime? datetime) {
    return datetime == null ? 0 : datetime.millisecondsSinceEpoch ~/ 1000;
  }

  static DateTime toDateTime(int seconds) {
    return DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
  }

  static String toDateTimeStr(int seconds,
      {bool isDate = false, bool isTime = false, bool military = false}) {
    final DateTime datetime = toDateTime(seconds);
    final List<String> split = datetime.toString().split(" ");
    final String date = split[0];
    final String time = Data.toTime(split[1], military);
    if (isDate && isTime) {
      return "$date $time";
    } else {
      return isDate ? date : time;
    }
  }

  static String toTime(String text, bool military) {
    final List<String> split = text.split(":");
    final String min = ":${split[1]}";
    if (military) {
      return split[0] + min;
    } else {
      final int hour = Data.toInt(split[0]);
      if (hour >= 12) {
        return "${hour - (hour == 12 ? 0 : 12)}$min PM";
      } else {
        return "${hour == 0 ? "12" : split[0]}$min AM";
      }
    }
  }
}