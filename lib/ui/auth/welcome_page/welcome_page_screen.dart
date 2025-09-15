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
    final provider = context.watch<WelcomeProvider>();
    final artboard = provider.artboard;

    if (artboard == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 300, width: 300, child: Rive(artboard: artboard)),
            const SizedBox(height: 20),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ElevatedButton(onPressed: () => provider.changeAvatar("Avatar 3"), child: const Text("Avatar 1")),
                ElevatedButton(onPressed: () => provider.changeAvatar("Avatar 1"), child: const Text("Avatar 2")),
                ElevatedButton(onPressed: () => provider.changeAvatar("Avatar 4"), child: const Text("Avatar 3")),
                ElevatedButton(onPressed: () => provider.changeAvatar("Avatar 2"), child: const Text("Avatar 4")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
