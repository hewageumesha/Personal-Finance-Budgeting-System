import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_finance_budgeting_system/features/authentication/presentation/providers/auth_provider.dart';
import 'package:personal_finance_budgeting_system/features/dashboard/presentation/widgets/balance_card.dart';
import 'package:personal_finance_budgeting_system/shared/styles/app_colors.dart';
import 'package:personal_finance_budgeting_system/shared/widgets/finflow_logo.dart';
import 'package:provider/provider.dart';
import '../../../finance/presentation/provider/finance_provider.dart';
import '../widgets/quick_actions.dart';
import '../widgets/recent_transaction.dart';
import '../../../analytics/presentation/widgets/spending_overview.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final uid = context.read<AuthProviderr>().user?.uid;
        if (uid != null) {
          context.read<FinanceProvider>().loadFinanceData(uid);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Watch the provider for changes
    final financeProvider = context.watch<FinanceProvider>();
    final authProvider = context.watch<AuthProviderr>();

    return Scaffold(
      appBar: AppBar(
        title: const FinFlowLogo(
            textColor: AppColors.onPrimaryColor, iconSize: 28, textSize: 22),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authProvider.loginOut();
              GoRouter.of(context).go('/login');
            },
            tooltip: 'Logout',
          ),
        ],
      ),
      body: _buildBody(financeProvider, authProvider),
    );
  }

  Widget _buildBody(
      FinanceProvider financeProvider, AuthProviderr authProvider) {
    if (financeProvider.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (financeProvider.error) {
      return Center(
        child: Text("Error : ${financeProvider.error}"),
      );
    }

    return RefreshIndicator(
        onRefresh: () async {
          final uid = context.read<AuthProviderr>().user?.uid;
          if (uid != null) await financeProvider.loadFinanceData(uid);
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'Welcome, ${authProvider.user?.username} 👋',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.onBackgroundColor,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            const BalanceCard(),
            const SizedBox(
              height: 24,
            ),
            const QuickActions(),
            const SizedBox(
              height: 24,
            ),
            const RecentTransaction(),
          ],
        ));
  }
}
