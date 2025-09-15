part of 'welcome_page.dart';

final class WelcomeProvider extends BaseProvider {
  WelcomeProvider({required super.context});

  Artboard? _artboard;
  StateMachineController? _controller;
  RiveFile? _riveFile;

  Artboard? get artboard => _artboard;

  @override
  void initState() {
    super.initState();
    loadRiveFile();
  }

  Future<void> loadRiveFile() async {
    final data = await rootBundle.load('assets/animations/avatars.riv');
    final file = RiveFile.import(data);

    _riveFile = file;

    _loadArtboard("Avatar 3");
  }

  void _loadArtboard(String artboardName) {
    if (_riveFile == null) return;

    final artboard = _riveFile!.artboardByName(artboardName);
    if (artboard == null) {
      debugPrint("⚠️ Artboard $artboardName not found, falling back to main");
      _artboard = _riveFile!.mainArtboard;
      notifyListeners();
      return;
    }

    if (_controller != null) {
      artboard.removeController(_controller!);
    }

    final controller = StateMachineController.fromArtboard(artboard, "State Machine");
    if (controller != null) {
      artboard.addController(controller);
    }

    _artboard = artboard;
    _controller = controller;
    notifyListeners();
  }

  void changeAvatar(String artboardName) {
    _loadArtboard(artboardName);
  }
}
