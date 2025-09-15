part of 'dashboard.dart';

final class DashboardProvider extends BaseProvider {
  final UserRepository userRepository;
  final AuthRepository authRepository;
  final LoadingDialogHandler loadingDialogHandler;

  DashboardProvider({
    required super.context,
    required this.userRepository,
    required this.loadingDialogHandler,
    required this.authRepository,
  });

  List<UserDocument>? users = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getAllUsers();
    });
  }

  Future<void> getAllUsers() async {
    final result = await processApi(
      request: () async => await userRepository.getAllUsers(),
      onLoading: loadingDialogHandler.handleLoading,
    );
    if (result?.isNotEmpty ?? false) {
      users = result;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await processApi(
      request: () async => await authRepository.signOut(),
      onLoading: loadingDialogHandler.handleLoading,
    );
    Preference().isLogin = false;
    context.navigator.pushNamedAndRemoveUntil(WelcomePageScreen.routeName, (route) => false);
  }
}
