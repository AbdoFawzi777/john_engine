import 'package:john_engine/john_engine.dart';

void main() async {
  final engine = JohnEngine();
  await engine.initialize();
  print('JohnEngine is ready for tactical operations.');
}
