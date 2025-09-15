part of 'dashboard.dart';

class DashboardScreen extends StatelessWidget {
  static const String routeName = '/dashboard';

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DashboardProvider(
        context: context,
        userRepository: UserRepository(),
        loadingDialogHandler: LoadingDialogHandler(context: context),
        authRepository: AuthRepository(),
      ),
      builder: (context, child) => DashboardScreen(),
    );
  }

  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<DashboardProvider>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Dashboard'),
        actions: [IconButton(onPressed: provider.signOut, icon: Icon(Icons.logout_outlined))],
      ),
      body: _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<DashboardProvider>();
    final users = context.select<DashboardProvider, List<UserDocument>?>((value) => value.users);
    return RefreshIndicator(
      onRefresh: provider.getAllUsers,
      child: ListView.separated(
        itemBuilder: (context, index) {
          final user = users?[index];
          return Padding(
            padding: EdgeInsets.only(
              top: Spacing.large,
              left: Spacing.medium,
              right: Spacing.medium,
              bottom: context.padding.bottom,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 4)),
                ],
              ),
              child: ListTile(
                onTap: () => context.navigator.pushNamed(ChatScreen.routeName, arguments: user),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                title: Text(
                  user?.name ?? '',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
                ),
                leading: CircleAvatar(
                  backgroundColor: Colors.grey.shade200,
                  child: Text(
                    user?.name?.substring(0, 1).toUpperCase() ?? '?',
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => Gap(Spacing.xSmall),
        itemCount: users?.length ?? 0,
      ),
    );
  }
}
