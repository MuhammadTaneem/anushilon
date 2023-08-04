import 'dart:convert';

Object? reviver(Object? key, Object? value) {
  if (value is String) {
    return utf8.decode(value.codeUnits);
  }
  return value;
}