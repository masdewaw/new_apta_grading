part of '../../../../pages.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    context.read<LoginCCubit>().initPackageInfo();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget sectionTop() {
      return Container(
        margin: const EdgeInsets.only(bottom: 20, left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 106,
              height: 136,
              child: Image(image: AssetImage('assets/logo.png'), color: cWhite),
            ),
            Text(
              'Masuk Apta Grading',
              style: whiteTextStyle.copyWith(fontSize: 28, fontWeight: bold),
              textScaler: context.textScale(28),
            ),
            const SizedBox(height: 6),
            Text(
              'Dengan masuk kedalam aplikasi, anda bertanggung jawab dengan apa yang anda laporkan didalam aplikasi.',
              style: greyTextStyle.copyWith(fontSize: 14, fontWeight: regular),
              textScaler: context.textScale(14),
            ),
          ],
        ),
      );
    }

    Widget sectionFormLogin() {
      return Container(
        width: context.width * 1,
        height: context.height * 1,
        padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
        decoration: BoxDecoration(
          color: cWhite,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Silahkan Login dengan akun anda",
                        style: customTextStyle.copyWith(
                          fontSize: 20,
                          fontWeight: semiBold,
                          color: cBlue,
                        ),
                        textScaler: context.textScale(20),
                      ),
                      const SizedBox(height: 40),
                      TextFormField(
                        controller: emailController,
                        cursorColor: cBlue,
                        style: customTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: semiBold,
                          color: cBlue,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email tidak boleh kosong';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: greyTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: regular,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          prefixIcon: Icon(
                            LucideIcons.mail,
                            color: cGrey,
                            size: 24,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: cRed, width: 1),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: cBlue, width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: cGrey, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: cBlue, width: 1),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      BlocBuilder<LoginCCubit, LoginCState>(
                        builder: (context, state) {
                          return TextFormField(
                            controller: passwordController,
                            cursorColor: cBlue,
                            obscureText: state.passwordVisible,
                            style: customTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: semiBold,
                              color: cBlue,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password tidak boleh kosong';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: greyTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: regular,
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              suffixIcon: InkWell(
                                onTap: () => context
                                    .read<LoginCCubit>()
                                    .togglePasswordVisibility(),
                                child: Icon(
                                  state.passwordVisible
                                      ? LucideIcons.eyeOff
                                      : LucideIcons.eye,
                                  color: cGrey,
                                  size: 24,
                                ),
                              ),
                              prefixIcon: Icon(
                                LucideIcons.lock,
                                color: cGrey,
                                size: 24,
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(color: cRed, width: 1),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(color: cBlue, width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(color: cGrey, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(color: cBlue, width: 1),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            // TODO: Handle forgot password tap
                          },
                          child: Text(
                            'Lupa Password?',
                            style: greyTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: semiBold,
                            ),
                            textScaler: context.textScale(14),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Login button with BlocListener
                      BlocListener<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state is AuthSuccess) {
                            context.pushAndRemoveUntil(const HomePage());
                          }
                          if (state is AuthFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.message),
                                backgroundColor: cRed,
                              ),
                            );
                          }
                        },
                        child: BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            if (state is AuthLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return GestureDetector(
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  context.read<AuthBloc>().add(
                                    AuthLoginRequested(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                width: context.width * 1,
                                height: 56,
                                decoration: BoxDecoration(
                                  color: cBlue,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Center(
                                  child: Text(
                                    "Masuk Apta Grading",
                                    style: whiteTextStyle.copyWith(
                                      fontSize: 18,
                                      fontWeight: bold,
                                    ),
                                    textScaler: context.textScale(18),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              BlocBuilder<LoginCCubit, LoginCState>(
                builder: (context, state) {
                  return SizedBox(
                    width: context.width * 1,
                    height: 70,
                    child: Center(
                      child: Text(
                        "Version: ${state.versionApp}",
                        style: greyTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: regular,
                        ),
                        textScaler: context.textScale(14),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: cBlue,
      body: Container(
        margin: const EdgeInsets.only(top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionTop(),
            Expanded(child: sectionFormLogin()),
          ],
        ),
      ),
    );
  }
}
