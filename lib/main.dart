import 'package:flutter/material.dart';
import 'package:pocket_pal/src/screens/patient/chatCall/login.dart';
import 'package:pocket_pal/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:pocket_pal/routes.dart';
import 'package:pocket_pal/src/screens/universal/onboarding/onboarding.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import 'package:zego_zimkit/zego_zimkit.dart';
import './providers.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  ZIMKit().init(
    appID: 303929327,
    appSign:
        "c66bfd5a6cc72b673497f8429a1ec0faaca26c9489571dafe8af3b8bfb1f811f", // your appSign
  );
  WidgetsFlutterBinding.ensureInitialized();
  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);

  ZegoUIKit().initLog().then((value) {
    ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
      [ZegoUIKitSignalingPlugin()],
    );
    runApp(MyApp(navigatorKey: navigatorKey));
  });
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const MyApp({super.key, required this.navigatorKey});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: Providers.providers,
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Pocket Pal',
        theme: AppTheme.lightTheme,
        home: const OnboardingPage(),
        routes: Routes.routes,
      ),
    );
  }
}
