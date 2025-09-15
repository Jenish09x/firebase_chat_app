part of 'sign_up.dart';

class SignUpScreen extends StatelessWidget {
  static const String routeName = '/sign_up';

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignUpProvider(
        context: context,
        authRepository: AuthRepository(),
        userRepository: UserRepository(),
        loadingDialogHandler: LoadingDialogHandler(context: context),
      ),
      builder: (context, child) => SignUpScreen(),
    );
  }

  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _Body());
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final provider = context.read<SignUpProvider>();
    final onTermChange = context.select<SignUpProvider, bool>((value) => value.termsCheck);
    return Expanded(
      child: Stack(
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
                    "Sign up",
                    style: context.textTheme.displayLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: context.colorScheme.primary,
                    ),
                  ),
                  Gap(Spacing.large),
                  Text(
                    "Please create a new account",
                    style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  Gap(context.height * 0.10),
                  Text("Name", style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
                  Gap(Spacing.small),
                  TextFormField(controller: provider.nameController),
                  Gap(Spacing.large),
                  Text("Email", style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
                  Gap(Spacing.small),
                  TextFormField(controller: provider.emailController),
                  Gap(Spacing.large),
                  Text("Password", style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
                  Gap(Spacing.small),
                  TextFormField(controller: provider.passwordController),
                  Gap(Spacing.xxLarge),
                  Row(
                    children: [
                      Checkbox(
                        value: onTermChange,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                        visualDensity: VisualDensity(
                          horizontal: VisualDensity.minimumDensity,
                          vertical: VisualDensity.minimumDensity,
                        ),
                        onChanged: (value) {
                          provider.checkTermsToggle();
                        },
                      ),
                      Gap(Spacing.small),
                      Expanded(
                        child: Text(
                          "Agree the terms of use and privacy policy",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                  Gap(Spacing.xxLarge),
                  GradientFilledButton(
                    onPressed: provider.signUp,
                    width: context.width,
                    child: Text(
                      "Sign up",
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
          ),
        ],
      ),
    );
  }
}
