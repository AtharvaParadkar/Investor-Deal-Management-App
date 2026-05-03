import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_spacing.dart';
import '../../constants/app_strings.dart';
import '../../constants/app_text_styles.dart';
import '../../deals/ui/deal_detail_screen.dart';
import '../../deals/ui/widgets/deal_card.dart';
import '../../utils/widgets/empty_state_widget.dart';
import '../../utils/widgets/loading_indicator.dart';
import '../bloc/my_interest_bloc.dart';
import '../bloc/my_interest_event.dart';
import '../bloc/my_interest_state.dart';

class MyInterestsScreen extends StatefulWidget {
  const MyInterestsScreen({super.key});

  @override
  State<MyInterestsScreen> createState() => _MyInterestsScreenState();
}

class _MyInterestsScreenState extends State<MyInterestsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MyInterestBloc>().add(const LoadMyInterests());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(AppStrings.myInterests, style: AppTextStyles.heading)),
      body: BlocConsumer<MyInterestBloc, MyInterestState>(
        listener: (context, state) {
          if (state is InterestToggled && !state.isInterested) {
            context.read<MyInterestBloc>().add(const LoadMyInterests());
          }
        },
        buildWhen: (previous, current) => current is! InterestToggled,
        builder: (context, state) {
          if (state is MyInterestsInitial || state is MyInterestsLoading) {
            return const LoadingIndicator(message: 'Loading your interests...');
          }
          if (state is MyInterestsEmpty) {
            return const EmptyStateWidget(
              icon: Icons.bookmark_border_rounded,
              message: AppStrings.noInterestsYet,
              subMessage: 'Browse deals and mark the ones you like!');
          }
          if (state is MyInterestsLoaded) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: ListView.builder(
                key: ValueKey(state.deals.length),
                padding: const EdgeInsets.all(AppSpacing.lg),
                itemCount: state.deals.length,
                itemBuilder: (context, index) {
                  final deal = state.deals[index];
                  return DealCard(
                    deal: deal,
                    onTap: () {
                      final interestBloc = context.read<MyInterestBloc>();
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: interestBloc,
                          child: DealDetailScreen(deal: deal),
                        ),
                      )).then((_) {
                        interestBloc.add(const LoadMyInterests());
                      });
                    },
                    trailing: GestureDetector(
                      onTap: () {
                        context.read<MyInterestBloc>().add(RemoveInterest(deal.id));
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(AppStrings.interestRemoved),
                          backgroundColor: AppColors.surfaceElevated,
                          behavior: SnackBarBehavior.floating));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.riskHigh.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8)),
                        child: const Icon(Icons.bookmark_remove_outlined,
                          size: 18, color: AppColors.riskHigh))));
                }),
            );
          }
          return const SizedBox.shrink();
        }),
    );
  }
}
