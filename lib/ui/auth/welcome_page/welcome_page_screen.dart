part of 'welcome_page.dart';

class WelcomePageScreen extends StatelessWidget {
  static const String routeName = '/welcome_page';

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WelcomeProvider(context: context),
      builder: (context, child) => WelcomePageScreen(),
    );
  }

  const WelcomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _Body());
  }
}

class _Body extends StatelessWidget {
  const _Body();

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
              Gap(context.height * 0.16),
              Text(
                "Welcome",
                style: context.textTheme.displayLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: context.colorScheme.primary,
                ),
              ),
              Gap(Spacing.large),
              Text("Lets get started", style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
              Gap(context.height * 0.36),
              Text(
                "Existing  customer / Get started",
                style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
              Gap(Spacing.medium),
              GradientFilledButton(
                onPressed: () {
                  context.navigator.pushNamed(SignInScreen.routeName);
                },
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
              Gap(Spacing.medium),
              CommonButton.cupertino(
                onTap: () {
                  context.navigator.pushNamed(SignUpScreen.routeName);
                },
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "New customer? ",
                        style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      TextSpan(
                        text: "Create new account",
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: context.colorScheme.primary,
                        ),
                      ),
                    ],
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
