import 'package:localstorage/localstorage.dart';

getStorage() async {
  final LocalStorage storage = LocalStorage('anushilon');
  await storage.ready;
  return storage;
}

clearStorage() async {
  final LocalStorage storage = LocalStorage('anushilon');
  await storage.ready;
  storage.clear();
}


String queryParamsSetter(data,String apiUrl){
  bool firstQur = true;

  data.forEach((key, value) {
    if (firstQur) {
      apiUrl += '?$key=$value';
      firstQur = false;
    } else {
      apiUrl += '&$key=$value';
    }
  });

  return apiUrl;
}