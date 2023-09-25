import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mydirectcash/Controllers/Authcontroller.dart';
import 'package:mydirectcash/Models/Transaction.dart';
import 'package:mydirectcash/Repository/AuthService.dart';
import 'package:mydirectcash/Repository/OperationServices.dart';
import 'package:mydirectcash/Repository/TransactonService.dart';
import 'package:mydirectcash/screens/account_qr.dart';
import 'package:mydirectcash/screens/home.dart';
import 'package:mydirectcash/screens/login.dart';
import 'package:mydirectcash/screens/welcome.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './AppLanguage.dart';
import 'app_localizations.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => Authcontroller().auth),
      ChangeNotifierProvider(create: (context) => AppLanguage()),
      ChangeNotifierProvider(create: (context) => TransactonService()),
      ChangeNotifierProvider(create: (context) => OperationServices())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  //final AppLanguage appLanguage;
  MyApp();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  bool _isInForeground = true;
  @override
  bool isSupported(Locale locale) =>
      ['en', 'fr', 'es'].contains(locale.languageCode);
  @override
  void initState() {
    super.initState();
    context.read<AppLanguage>().fetchLocale();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    SharedPreferences pref = await SharedPreferences.getInstance();
    _isInForeground = state == AppLifecycleState.resumed;
    switch (state) {
      case AppLifecycleState.resumed:
        print("app in resumed");

        await pref.setBool("open", false);
        break;
      case AppLifecycleState.inactive:
        print("app in inactive");
        await pref.setBool("open", false);
        break;
      case AppLifecycleState.paused:
        print("app in paused");
        await pref.setBool("open", false);
        break;
      case AppLifecycleState.detached:
        await pref.setBool("open", false);
        print("app in detached");
        break;
      case AppLifecycleState.hidden:
        // TODO: Handle this case.
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLanguage = context.watch<AppLanguage>();
    print(appLanguage.appLocal);
    return MaterialApp(
      title: 'My Direct Cash',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      locale: appLanguage.appLocal,
      supportedLocales: const [
        Locale('en', ''),
        Locale('fr', ''),
        Locale('es', ''),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        AppLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: Consumer<AuthService>(
        builder: (context, auth, child) {
          // WelcomePage()

          if (auth.authenticate) {
            return Home();
          } else {
            return Consumer<AuthService>(builder: (context, auth, child) {
              if (auth.tel) {
                return Login(
                  isLogin: false,
                );
              } else {
                return WelcomePage();
              }
            });
          } //flutter build apk  --split-per-abi
        },
      ),
    );
  }
}
