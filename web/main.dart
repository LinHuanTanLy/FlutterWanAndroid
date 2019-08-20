import 'package:flutter_web_ui/ui.dart' as ui;
// 将flutter_web_challenge_googlemaps替换为自己的package
import 'package:flutter_app/main.dart' as app;

main() async {
  await ui.webOnlyInitializePlatform();
  app.main();
}