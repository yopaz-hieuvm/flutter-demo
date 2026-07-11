import 'package:flutter/material.dart';
import 'package:flutter_demo/Pages/auth/login_screen.dart';
import 'package:flutter_demo/Pages/home/home_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
   url: 'https://wyynappfygocmjnujaam.supabase.co',
   anonKey: 'sb_publishable_3XcqFxIKp9cqt5091GUrqw_Zkljh8SV',

  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: AuthCheck()
    );
  }
}

class AuthCheck extends StatelessWidget {
  final SupabaseClient supabase = Supabase.instance.client;

  AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: supabase.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session = supabase.auth.currentSession;

        if (session != null) {
          return HomeScreen(); // if logged in, go to home screen
        } else {
          return LoginScreen(); // otherwise, show login screen
        }
      },
    ); // StreamBuilder
  }
}
