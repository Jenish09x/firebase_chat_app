part of 'sign_in.dart';

final class SignInProvider extends BaseProvider {
  final AuthRepository authRepository;
  final LoadingDialogHandler loadingDialogHandler;

  SignInProvider({required super.context, required this.authRepository, required this.loadingDialogHandler});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> signIn() async {
    final result = await processApi(
      request: () async => await authRepository.signIn(
        userDocument: UserDocument(email: emailController.text, password: passwordController.text),
      ),
      onLoading: loadingDialogHandler.handleLoading,
    );
    if ((result != null) && context.mounted) {
      Preference().isLogin = true;
      context.navigator.pushNamedAndRemoveUntil(DashboardScreen.routeName, (route) => false);
    }
  }
}
