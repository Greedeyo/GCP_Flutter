import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gcp/firebase_options.dart';
import 'package:gcp/src/constants/colors.dart';
import 'package:gcp/src/constants/sizes.dart';
import 'package:gcp/src/repository/authentication_repository/authentication_repository.dart';
import 'package:gcp/src/utils/theme/theme.dart';
import 'package:gcp/src/utils/theme/widget_themes/text_theme.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: TAppTheme.baseTheme,
      darkTheme: TAppTheme.baseTheme,
      themeMode: ThemeMode.system,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SpinKitWaveSpinner(color: tAccentColor, waveColor: tAccentColor, size: 100.0),
              const SizedBox(height: tFormHeight - 10.0),
              Text("로딩 중이에요", style: Theme.of(context).textTheme.inside),
            ]
          ),
        )
      )
    );
  }
}