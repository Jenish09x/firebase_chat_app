part of 'forgot_password.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static const String routeName = '/forgot_password';

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ForgotPasswordProvider(context: context),
      builder: (context, child) => ForgotPasswordScreen(),
    );
  }

  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _Body());
  }
}

class _Body extends StatelessWidget {
  const _Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(top: 0, right: 0, child: Assets.images.x.svg(height: 400)),
        Positioned(bottom: 0, left: 0, child: Assets.images.r.svg(height: 400)),
        Padding(
          padding: EdgeInsets.all(Spacing.large),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(context.height * 0.18),
              Text(
                "Forgot\npassword?",
                style: context.textTheme.displayLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: context.colorScheme.primary,
                ),
              ),
              Gap(Spacing.large),
              Text(
                "Enter your email for the verification process, we will send code to your email",
                style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
              Gap(context.height * 0.19),
              Text("Email", style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
              Gap(Spacing.small),
              TextFormField(),
              Gap(48),
              GradientFilledButton(
                onPressed: () {
                  context.navigator.pushNamed(SignInScreen.routeName);
                },
                width: context.width,
                child: Text(
                  "Continue",
                  textAlign: TextAlign.center,
                  style: context.textTheme.titleMedium?.copyWith(
                    color: context.colorScheme.onPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
