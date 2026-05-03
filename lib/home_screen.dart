import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constants/app_colors.dart';
import 'constants/app_strings.dart';
import 'deals/bloc/deal_bloc.dart';
import 'deals/bloc/deal_event.dart';
import 'deals/bloc/filter_bloc.dart';
import 'deals/repository/deal_repository.dart';
import 'deals/ui/deal_list_screen.dart';
import 'login/bloc/login_bloc.dart';
import 'login/bloc/login_state.dart';
import 'login/repository/login_repository.dart';
import 'my_interest/bloc/my_interest_bloc.dart';
import 'my_interest/bloc/my_interest_event.dart';
import 'my_interest/repository/my_interest_repository.dart';
import 'my_interest/ui/my_interests_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final LoginBloc _loginBloc = LoginBloc(loginRepository: LoginRepository());
  late final DealBloc _dealBloc;
  late final FilterBloc _filterBloc;
  final MyInterestBloc _interestBloc = MyInterestBloc(
    interestRepository: MyInterestRepository(),
    dealRepository: DealRepository(),
  );

  @override
  void initState() {
    super.initState();
    _dealBloc = DealBloc(dealRepository: DealRepository());
    _filterBloc = FilterBloc(dealBloc: _dealBloc);
    _dealBloc.add(const LoadDeals());
  }

  @override
  void dispose() {
    _loginBloc.close();
    _dealBloc.close();
    _filterBloc.close();
    _interestBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>.value(value: _loginBloc),
        BlocProvider<DealBloc>.value(value: _dealBloc),
        BlocProvider<FilterBloc>.value(value: _filterBloc),
        BlocProvider<MyInterestBloc>.value(value: _interestBloc),
      ],
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginLoggedOut) {
            Navigator.of(context).pushReplacementNamed('/login');
          }
        },
        child: Scaffold(
          body: IndexedStack(
            index: _currentIndex,
            children: const [DealListScreen(), MyInterestsScreen()],
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: AppColors.divider.withValues(alpha: 0.5),
                  width: 1,
                ),
              ),
            ),
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() => _currentIndex = index);
                if (index == 1) {
                  _interestBloc.add(const LoadMyInterests());
                }
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.business_center_outlined),
                  activeIcon: Icon(Icons.business_center),
                  label: AppStrings.navDeals,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bookmark_border_rounded),
                  activeIcon: Icon(Icons.bookmark_rounded),
                  label: AppStrings.navMyInterests,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
