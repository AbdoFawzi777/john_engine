import 'dart:io';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:bcrypt/bcrypt.dart';
import 'identity_shield.dart';

/// 🗝️ Sovereign John Engine v10.0 - High-Throughput Cryptographic Auditor & Benchmark
class JohnEngine {
  static final JohnEngine _instance = JohnEngine._internal();
  factory JohnEngine() => _instance;
  JohnEngine._internal();

  bool _initialized = false;
  bool get isInitialized => _initialized;

  /// Default Tactical Wordlist (Expanded High-Frequency Set)
  static const List<String> defaultWordlist = [
    'admin', 'password', '123456', '12345678', '123456789', 'admin123',
    'root', 'toor', 'pass123', 'password123', 'welcome', 'welcome1',
    'administrator', 'qwerty', '12345', 'default', 'guest', 'master',
    'login', 'secret', 'secret123', 'changeme', 'server', 'oracle', 'cisco',
    'manager', 'operator', 'support', 'test', 'demo', 'user', 'P@ssw0rd',
    'Spring2026', 'Winter2025', 'Summer2026', 'Company123!', 'Welcome@2026'
  ];

  Future<void> initialize() async {
    _initialized = true;
  }

  /// Automatically identify the likely hash algorithm
  static String identifyHashFormat(String hash) {
    final clean = hash.trim().toLowerCase();
    if (clean.startsWith("\$2a\$") || clean.startsWith("\$2b\$") || clean.startsWith("\$2y\$")) {
      return 'bcrypt';
    }
    if (clean.length == 32 && RegExp(r'^[a-f0-9]{32}$').hasMatch(clean)) {
      return 'md5'; // or ntlm
    }
    if (clean.length == 40 && RegExp(r'^[a-f0-9]{40}$').hasMatch(clean)) {
      return 'sha1';
    }
    if (clean.length == 56 && RegExp(r'^[a-f0-9]{56}$').hasMatch(clean)) {
      return 'sha224';
    }
    if (clean.length == 64 && RegExp(r'^[a-f0-9]{64}$').hasMatch(clean)) {
      return 'sha256';
    }
    if (clean.length == 96 && RegExp(r'^[a-f0-9]{96}$').hasMatch(clean)) {
      return 'sha384';
    }
    if (clean.length == 128 && RegExp(r'^[a-f0-9]{128}$').hasMatch(clean)) {
      return 'sha512';
    }
    return 'unknown';
  }

  /// Load custom wordlist from local .txt file on the device
  Future<List<String>> loadWordlistFromFile(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        final content = await file.readAsString();
        return content.split(RegExp(r'[\r\n]+')).map((w) => w.trim()).where((w) => w.isNotEmpty).toList();
      }
    } catch (_) {}
    return [];
  }

  /// High-Speed Multi-Format Hash Cracking with H/s Performance Telemetry
  Future<JohnResult> crack({
    required Map<String, String> hashes,
    List<String>? wordlist,
    String? customWordlistFilePath,
  }) async {
    if (!IdentityShield.check()) throw Exception("Security Violation: Core Integrity Check Failed");

    List<String> words;
    if (customWordlistFilePath != null && customWordlistFilePath.isNotEmpty) {
      final fileWords = await loadWordlistFromFile(customWordlistFilePath);
      words = fileWords.isNotEmpty ? fileWords : defaultWordlist;
    } else {
      words = wordlist ?? defaultWordlist;
    }

    final results = <String, CrackedEntry>{};
    int crackedCount = 0;
    int totalEvaluations = 0;
    final startTime = DateTime.now();

    for (var entry in hashes.entries) {
      String type = entry.key.toLowerCase();
      final hash = entry.value.trim();

      if (type == 'auto' || type == 'hash' || type.isEmpty) {
        type = identifyHashFormat(hash);
      }

      String? found;
      final hashLower = hash.toLowerCase();

      for (var word in words) {
        totalEvaluations++;
        final bytes = utf8.encode(word);

        if (type == 'md5' && md5.convert(bytes).toString() == hashLower) {
          found = word;
          break;
        } else if (type == 'sha1' && sha1.convert(bytes).toString() == hashLower) {
          found = word;
          break;
        } else if (type == 'sha224' && sha224.convert(bytes).toString() == hashLower) {
          found = word;
          break;
        } else if (type == 'sha256' && sha256.convert(bytes).toString() == hashLower) {
          found = word;
          break;
        } else if (type == 'sha384' && sha384.convert(bytes).toString() == hashLower) {
          found = word;
          break;
        } else if (type == 'sha512' && sha512.convert(bytes).toString() == hashLower) {
          found = word;
          break;
        } else if (type == 'bcrypt') {
          try {
            if (BCrypt.checkpw(word, hash)) {
              found = word;
              break;
            }
          } catch (_) {}
        }
      }

      if (found != null) crackedCount++;
      results[hash] = CrackedEntry(
        hash: hash,
        type: type,
        plaintext: found,
        isCracked: found != null,
      );
    }

    final duration = DateTime.now().difference(startTime);
    final seconds = duration.inMicroseconds / 1000000.0;
    final double hashesPerSecond = seconds > 0 ? (totalEvaluations / seconds) : totalEvaluations.toDouble();

    return JohnResult(
      entries: results,
      successCount: crackedCount,
      totalHashes: hashes.length,
      totalEvaluations: totalEvaluations,
      hashesPerSecond: hashesPerSecond,
      duration: duration,
    );
  }
}

class CrackedEntry {
  final String hash;
  final String type;
  final String? plaintext;
  final bool isCracked;

  CrackedEntry({
    required this.hash,
    required this.type,
    required this.plaintext,
    required this.isCracked,
  });

  Map<String, dynamic> toJson() => {
    'hash': hash,
    'type': type,
    'plaintext': plaintext,
    'is_cracked': isCracked,
  };
}

class JohnResult {
  final Map<String, CrackedEntry> entries;
  final int successCount;
  final int totalHashes;
  final int totalEvaluations;
  final double hashesPerSecond;
  final Duration duration;

  JohnResult({
    required this.entries,
    required this.successCount,
    required this.totalHashes,
    required this.totalEvaluations,
    required this.hashesPerSecond,
    required this.duration,
  });

  Map<String, String?> get hashes => entries.map((k, v) => MapEntry(k, v.plaintext));

  Map<String, dynamic> toJson() => {
    'success_count': successCount,
    'total': totalHashes,
    'total_evaluations': totalEvaluations,
    'hashes_per_second': hashesPerSecond.toStringAsFixed(1),
    'duration_ms': duration.inMilliseconds,
    'entries': entries.map((k, v) => MapEntry(k, v.toJson())),
  };
}
