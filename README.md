# John Engine (`john_engine`)

> Offline Password Hash Entropy & Validation Engine  
> **Author & Original Architect:** [Abdallah Fawzi Ali Mahmoud](https://github.com/AbdoFawzi777)  
> **Part of the RedOps Hub Monorepo Suite**

---

## 📌 Overview
`john_engine` is a production-grade, standalone Flutter package engineered for high-performance mobile security auditing. Built with pure Dart and native Flutter MethodChannels/Isolates, it delivers enterprise-level capability directly on Android & iOS devices without relying on external Linux command-line dependencies.

---

## 🚀 New Capabilities & Features (v2.0)
- **Multi-Algorithm Hash Identification:** Automatic detection for MD5, SHA-1, SHA-256, SHA-512, NTLM, and bcrypt hashes.
- **Multi-Core Isolate Parallelism:** Leverages all mobile CPU cores using Flutter Isolates for maximum hash cracking speed.
- **Hybrid Mutation Rules:** Dictionary attacks with advanced mutation rules (capitalization, leetspeak, suffix/prefix addition).
- **Entropy & Strength Analytics:** Calculates password entropy score and estimated time-to-crack metrics.

---

## 🛠 Usage & Integration

Add `john_engine` to your Flutter `pubspec.yaml`:

```yaml
dependencies:
  john_engine:
    path: ../packages/john_engine
```

### Basic Example

```dart
import 'package:john_engine/john_engine.dart';

void main() async {
  final engine = JohnEngine();
  
  print('Starting John Engine audit...');
  final results = await engine.execute(
    target: '192.168.1.1',
  );
  
  print('Audit Complete!');
}
```

---

## 🔒 Security & Privacy
- **Zero Telemetry:** No analytics, tracking, or network calls home.
- **Encrypted Local Storage:** Integrates seamlessly with RedOps Hub AES-256 local database.
- **Thread Safety:** All heavy operations execute inside Dart Isolates to maintain 60fps UI rendering.

---

## 👤 Author & Copyright

**Abdallah Fawzi Ali Mahmoud**  
Lead Developer & Security Architect of RedOps Hub  
- **GitHub:** [@AbdoFawzi777](https://github.com/AbdoFawzi777)  
- **Telegram:** [@ABdo_FawZi1](https://telegram.me/ABdo_FawZi1)  
- **Website:** [RedOps Hub Platform](https://redops-hub.web.app)

*Copyright (c) 2026 Abdallah Fawzi Ali Mahmoud. All rights reserved.*
