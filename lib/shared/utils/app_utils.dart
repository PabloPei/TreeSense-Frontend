import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// TODO: Implement that retrieve the language from the user
class MessageLoader {
  static Map<String, dynamic> _messages = {};

  static Future<void> load() async {
    final String jsonString = await rootBundle.loadString(
      'assets/messages/es.json',
    );
    _messages = json.decode(jsonString);
  }

  static String get(String key) {
    final value = _messages[key];
    if (value == null) return '[$key]';
    if (value is String) return value;
    return value.toString();
  }

  /// Devuelve una lista de strings para la clave simple [key]
  /// Retorna lista vacía si no existe o no es lista
  static List<String> getStringList(String key) {
    final dynamic value = _messages[key];
    if (value is List) {
      return value.whereType<String>().toList();
    }
    return [];
  }
}

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    MessageLoader.load(),
    Future.delayed(const Duration(seconds: 3)), // TODO: Eliminar en producción
  ]);
}

/// Use this only for **visual display purposes**.
/// Do NOT use the returned DateTime for time zone-sensitive operations like:
/// - comparisons across time zones
/// - sending data back to the backend
/// - storing time-sensitive records.
DateTime parsePreservingLocalTime(String isoString) {
  final cleaned = isoString.replaceFirst(RegExp(r'(Z|[+-]\d{2}:\d{2})$'), '');
  return DateTime.parse(cleaned);
}

String interpolateMessage(String key, Map<String, String> values) {
  var message = MessageLoader.get(key);
  values.forEach((placeholder, value) {
    message = message.replaceAll('{$placeholder}', value);
  });
  return message;
}
