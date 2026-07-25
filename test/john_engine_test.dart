import 'package:flutter_test/flutter_test.dart';
import 'package:john_engine/john_engine.dart';

void main() {
  test('JohnEngine initialization test', () async {
    final engine = JohnEngine();
    await engine.initialize();
    expect(engine.isInitialized, true);
  });
}
