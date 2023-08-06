// utils/constants.dart

class Constants {
  static const String apiRootUrl = 'http://192.168.68.101:8000/';
  // static const String apiRootUrl = 'http://192.168.1.101:8000/';


  static Map<String, String> get headers => {
    'Content-Type': 'application/json; charset=UTF-8',
  };
}
