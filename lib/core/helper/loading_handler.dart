part of '../core.dart';

abstract class LoadingHandler {
  const LoadingHandler();

  void startLoading();

  void stopLoading();

  void handleLoading(bool loading) {
    if (loading) {
      startLoading();
    } else {
      stopLoading();
    }
  }
}

class LoadingDialogHandler extends LoadingHandler {
  LoadingDialogHandler({required BuildContext context}) : _context = context;

  final BuildContext _context;
  Route? _dialogRoute;

  Route _buildDialogRoute(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    final CapturedThemes themes = InheritedTheme.capture(from: context, to: context.navigator.context);
    return DialogRoute(
      context: context,
      barrierDismissible: false,
      useSafeArea: true,
      themes: themes,
      builder: (context) => PopScope(canPop: false, child: const LoadingIndicator()),
    );
  }

  @override
  void startLoading() {
    if (_dialogRoute != null) return;
    _dialogRoute = _buildDialogRoute(_context);
    _context.navigator.push(_dialogRoute!);
  }

  @override
  void stopLoading() {
    if (_dialogRoute != null && _context.mounted) _context.navigator.removeRoute(_dialogRoute!);
    _dialogRoute = null;
  }
}
