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