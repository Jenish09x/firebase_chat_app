part of 'sign_in.dart';

class SignInScreen extends StatelessWidget {
  static const String routeName = '/sign_in';

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignInProvider(
        context: context,
        authRepository: AuthRepository(),
        loadingDialogHandler: LoadingDialogHandler(context: context),
      ),
      builder: (context, child) => SignInScreen(),
    );
  }

  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _Body());
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final provider = context.read<SignInProvider>();
    return Stack(
      children: [
        Positioned(top: 0, right: 0, child: Assets.images.x.svg(height: 400)),
        Positioned(bottom: 0, left: 0, child: Assets.images.r.svg(height: 400)),
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(Spacing.large) + EdgeInsets.only(bottom: context.padding.bottom),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(context.height * 0.16),
                Text(
                  "Sign in",
                  style: context.textTheme.displayLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: context.colorScheme.primary,
                  ),
                ),
                Gap(Spacing.large),
                Text(
                  "Please log in into your account",
                  style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                ),
                Gap(context.height * 0.16),
                Text("Email", style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
                Gap(Spacing.small),
                TextFormField(controller: provider.emailController),
                Gap(Spacing.large),
                Text("Password", style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
                Gap(Spacing.small),
                TextFormField(controller: provider.passwordController),
                Gap(Spacing.normal),
                Align(
                  alignment: Alignment.centerRight,
                  child: CommonButton.cupertino(
                    onTap: () {
                      context.navigator.pushNamed(ForgotPasswordScreen.routeName);
                    },
                    child: Text(
                      "Forgot Password?",
                      style: context.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: context.colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                ),
                Gap(Spacing.medium),
                GradientFilledButton(
                  onPressed: provider.signIn,
                  width: context.width,
                  child: Text(
                    "Sign in",
                    textAlign: TextAlign.center,
                    style: context.textTheme.titleMedium?.copyWith(
                      color: context.colorScheme.onPrimary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Gap(Spacing.xxxLarge),
                OutlineCommonButton(
                  onPressed: () {},
                  width: context.width,
                  child: Text(
                    "Sign in with Google",
                    textAlign: TextAlign.center,
                    style: context.textTheme.titleMedium?.copyWith(
                      color: context.colorScheme.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Gap(Spacing.normal),
                OutlineCommonButton(
                  onPressed: () {},
                  width: context.width,
                  child: Text(
                    "Sign in with Google",
                    textAlign: TextAlign.center,
                    style: context.textTheme.titleMedium?.copyWith(
                      color: context.colorScheme.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
