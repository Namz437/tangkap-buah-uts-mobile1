import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_games/bloc/auth/bloc/auth_bloc.dart';
import 'package:mini_games/bloc/register/bloc/register_bloc.dart';
import 'package:mini_games/login.dart';
import 'firebase_options.dart';
import 'visibility_cubit.dart'; // Buat file VisibilityCubit jika belum ada

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Inisialisasi widget Flutter
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Konfigurasi Firebase
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<VisibilityCubit>(
          create: (context) => VisibilityCubit(),
        ),
        BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // Menghilangkan banner debug
        home: Login(), // Tampilan awal adalah layar login
      ),
    );
  }
}
