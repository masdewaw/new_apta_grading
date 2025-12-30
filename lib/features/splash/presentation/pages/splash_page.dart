part of '../../../../pages.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      getStringStorage(StorageKey.session).then((value) {
        if (value != null) {
          if (mounted) {
            context.pushAndRemoveUntil(const HomePage());
          }
        } else {
          if (mounted) {
            context.pushAndRemoveUntil(const LoginPage());
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          width: 136,
          height: 196,
          child: Image(image: AssetImage('assets/logo.png')),
        ),
      ),
    );
  }
}
