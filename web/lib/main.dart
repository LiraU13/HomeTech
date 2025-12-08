import 'package:flutter/material.dart';
import 'package:hometech/authentication/main_page.dart';
import 'package:hometech/forgot_password.dart';
import 'package:hometech/screens/home/settings/about_screen.dart';
import 'package:hometech/screens/home/settings/devices_edit_screen.dart';
import 'package:hometech/screens/home/settings/notifications_screen.dart';
import 'package:hometech/screens/home/settings/profile_edit_screen.dart';
import 'package:hometech/screens/home/settings/restore_password.dart';
import 'package:hometech/screens/home/settings/support_screen.dart';
import 'package:hometech/screens/home/settings/terms_screen.dart';
import 'package:hometech/authentication/auth_page.dart';
// import 'package:hometech/Onboarding_screens/onboarding_view.dart'; // Estos imports son para el Onboarding
// import 'package:shared_preferences/shared_preferences.dart';
import 'signup_screen.dart';
import 'signin_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/home/settings_screen.dart';
import 'screens/home/devices_screen.dart';
import 'widgets/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:hometech/themes/theme.dart';
import 'package:hometech/themes/theme_provider.dart';
import 'package:provider/provider.dart';

import 'package:hometech/config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Onboarding
  // final prefs = await SharedPreferences.getInstance();
  // final onboarding = prefs.getBool("onboarding") ?? false;
  if (!AppConfig.isDemoMode) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
      // child: MyApp(onboarding: onboarding),
    ),
  );
}

class MyApp extends StatelessWidget {
  // final bool onboarding;
  const MyApp({super.key});
  // const MyApp({super.key, this.onboarding = false});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HomeTech',
      home: AppConfig.isDemoMode ? const HomeScreen() : const MainPage(),
      // home: onboarding ? SignInScreen(showSignUpScreen: () {}) : const OnboardingView(),
      //home: const MainPage(), // AuthPage(), (AuthPage se cambio por MainPage para crear cuentas)  // Si la autenticación no funciona teniendo la introducción se cambia.
      // Probar: En la pantalla de introduccion colocar en el boton de continuar el AuthPage y aqui dejar el IntroduccionScreen
      // Otra opción, es que main.dart tenga el contenido de IntroductionScreen
      // Por ahora IntroductioScreen tiene a MainPage en el botón de continuar, a simple vista funciona pero hay que testear
      themeMode: ThemeMode.light,
      theme: Provider.of<ThemeProvider>(context).themeData,
      // theme: lightMode, // Se quita la linea de arriba y se deja esta, si la configuración del modo es desde el dispositivo
      darkTheme: darkMode,
      routes: {
        // Pantallas de incio de sesión
        AppRoutes.signUp: (context) => SignUpScreen(
              showSignInScreen: () {},
            ),
        AppRoutes.signIn: (context) => SignInScreen(
              showSignUpScreen: () {},
            ), // Forma corregida con CTRL + .
        // AppRoutes.signIn: (context) => const SignInScreen(), // Forma inicial pero marca error
        AppRoutes.newpass: (context) => const NewPassScreen(),
        AppRoutes.authPage: (context) => const AuthPage(),
        AppRoutes.mainPage: (context) => const MainPage(),
        // Pantallas principales
        AppRoutes.home: (context) => const HomeScreen(),
        AppRoutes.devices: (context) => const DevicesScreen(),
        AppRoutes.settings: (context) => const SettingsScreen(),
        // Pantallas de configuraciones
        AppRoutes.profileEdit: (context) => const ProfileEditScreen(),
        AppRoutes.devicesEdit: (context) => const DevicesEditScreen(),
        AppRoutes.notifications: (context) => const NotificationsScreen(),
        AppRoutes.support: (context) => const SupportScreen(),
        AppRoutes.about: (context) => const AboutScreen(),
        AppRoutes.terms: (context) => const TermsScreen(),
        AppRoutes.restorepass: (context) => const RestorePassScreen(),
      },
    );
  }
}
