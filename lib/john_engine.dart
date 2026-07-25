/// 🗝️ John the Ripper Engine - Password cracking for Flutter
library john_engine;

import 'dart:convert';
import 'package:crypto/crypto.dart';

class JohnEngine {
  static final JohnEngine _instance = JohnEngine._internal();
  factory JohnEngine() => _instance;
  JohnEngine._internal();

  bool _initialized = false;

  static const List<String> _defaultWordlist = [
    'admin', 'password', '123456', 'root', 'toor',
    'admin123', 'password123', 'qwerty', 'letmein',
    'welcome', 'pass123', '123456789', 'qwerty123',
  ];

  /// 🚀 تهيئة المحرك
  Future<void> initialize() async {
    _initialized = true;
  }

  /// 🔍 كسر تجزئة MD5
  String? crackMD5(String hash, {List<String>? wordlist}) {
    final list = wordlist ?? _defaultWordlist;
    for (final word in list) {
      final hashed = md5.convert(utf8.encode(word)).toString();
      if (hashed == hash.toLowerCase()) {
        return word;
      }
    }
    return null;
  }

  /// 🔍 كسر تجزئة SHA1
  String? crackSHA1(String hash, {List<String>? wordlist}) {
    final list = wordlist ?? _defaultWordlist;
    for (final word in list) {
      final hashed = sha1.convert(utf8.encode(word)).toString();
      if (hashed == hash.toLowerCase()) {
        return word;
      }
    }
    return null;
  }

  /// 🔍 كسر تجزئة SHA256
  String? crackSHA256(String hash, {List<String>? wordlist}) {
    final list = wordlist ?? _defaultWordlist;
    for (final word in list) {
      final hashed = sha256.convert(utf8.encode(word)).toString();
      if (hashed == hash.toLowerCase()) {
        return word;
      }
    }
    return null;
  }

  /// 🔍 كسر تجزئة متعددة
  Future<JohnResult> crackMultiple(Map<String, String> hashes, {List<String>? wordlist}) async {
    final results = <String, String?>{};
    
    for (final entry in hashes.entries) {
      final algorithm = entry.key.toLowerCase();
      final hash = entry.value;
      String? cracked;
      
      switch (algorithm) {
        case 'md5':
          cracked = crackMD5(hash, wordlist: wordlist);
          break;
        case 'sha1':
          cracked = crackSHA1(hash, wordlist: wordlist);
          break;
        case 'sha256':
          cracked = crackSHA256(hash, wordlist: wordlist);
          break;
        default:
          cracked = null;
      }
      
      if (cracked != null) {
        results[hash] = cracked;
      }
    }

    return JohnResult(
      results: results,
      totalHashes: hashes.length,
      crackedCount: results.length,
    );
  }

  bool get isInitialized => _initialized;
}

class JohnResult {
  final Map<String, String?> results;
  final int totalHashes;
  final int crackedCount;
  JohnResult({
    required this.results,
    required this.totalHashes,
    required this.crackedCount,
  });
}
