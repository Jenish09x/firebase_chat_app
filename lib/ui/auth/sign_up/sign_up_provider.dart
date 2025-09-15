part of 'sign_up.dart';

final class SignUpProvider extends BaseProvider {
  final AuthRepository authRepository;
  final UserRepository userRepository;
  final LoadingDialogHandler loadingDialogHandler;

  SignUpProvider({
    required this.authRepository,
    required this.userRepository,
    required super.context,
    required this.loadingDialogHandler,
  });

  bool termsCheck = false;
  bool isLoading = false;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void checkTermsToggle() {
    termsCheck = !termsCheck;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  Future<void> signUp() async {
    final result = await processApi(
      request: () async => await authRepository.signUp(
        userDocument: UserDocument(
          email: emailController.text,
          password: passwordController.text,
          name: nameController.text,
        ),
      ),
      onLoading: loadingDialogHandler.handleLoading,
    );
    if ((result ?? false) && context.mounted) {
      context.navigator.pushNamed(SignInScreen.routeName);
    }
  }
}
