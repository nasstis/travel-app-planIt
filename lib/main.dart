import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:travel_app/app.dart';
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
    ),
  );
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp(FirebaseUserRepository()));
}
