import 'package:soul_comfort/flavors.dart';

import 'package:soul_comfort/main.dart' as runner;

Future<void> main() async {
  F.appFlavor = Flavor.dev;
  await runner.main();
}
