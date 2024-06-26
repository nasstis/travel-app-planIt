import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:travel_app/app.dart';
import 'package:travel_app/utils/constants/theme_mode.dart';
import 'package:travel_app/utils/helpers/simple_bloc_observer.dart';
import 'package:user_repository/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: FlutterConfig.get('API_KEY'),
      appId: '1:492359981927:android:cd183369d974b912756dc2',
      messagingSenderId: '492359981927',
      projectId: 'travel-app-b3617',
      storageBucket: 'gs://travel-app-b3617.appspot.com',
    ),
  );
  // if (FlutterConfig.get('USE_FIREBASE_EMU') == 'true') {
  //   await FirebaseAuth.instance.useAuthEmulator('10.0.2.2', 9099);
  //   await FirebaseStorage.instance.useStorageEmulator('10.0.2.2', 9199);
  //   FirebaseFirestore.instance.settings = const Settings(
  //     host: '10.0.2.2:8080',
  //     sslEnabled: false,
  //     persistenceEnabled: false,
  //   );
  // }
  Bloc.observer = SimpleBlocObserver();
  await MyThemeMode.initialize();
  runApp(MyApp(FirebaseUserRepository()));
}
