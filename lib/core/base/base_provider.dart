part of '../core.dart';

abstract base class BaseProvider extends ChangeNotifier {
  BaseProvider({required this.context}) {
    initState();
  }

  final BuildContext context;

  void initState() {}

  Preference preference = Preference();

  Future<T?> processApi<T>({required Future<T?> Function() request, void Function(bool loading)? onLoading}) async {
    onLoading?.call(true);
    final result = await request().onError(handleException);
    if (context.mounted) {
      onLoading?.call(false);
      return result;
    }
    return null;
  }

  FutureOr<T?> handleException<T>(Object error, StackTrace stackTrace) {
    if (!context.mounted) {
      return null;
    }
    debugPrint(error.toString());
    debugPrint(stackTrace.toString());

    switch (error) {
      case UnAuthenticated():
        navigatorKey.currentState?.pushNamedAndRemoveUntil(SignInScreen.routeName, (route) => false);
        preference.clear();
        context.showErrorMessage(title: "User session expired!");
        break;

      case TimeoutException():
        context.showErrorMessage(title: "Timeout!", content: "Please check your internet connectivity and try again.");
        break;

      case HttpException():
      case SocketException():
        context.showErrorMessage(
          title: "Internet connection error!",
          content: "Please check your internet connectivity and try again.",
        );
        break;

      case DefaultException():
        context.showErrorMessage(title: error.error, content: null);
        break;

      default:
        context.showErrorMessage(
          title: "Something went wrong!",
          content: "An unknown error has been occurred. Please try after sometime.",
        );
    }
    return null;
  }
}
