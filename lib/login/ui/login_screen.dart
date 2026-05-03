import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_spacing.dart';
import '../../constants/app_strings.dart';
import '../../constants/app_text_styles.dart';
import '../../utils/validators.dart';
import '../../utils/widgets/app_button.dart';
import '../../utils/widgets/app_text_field.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';
import '../repository/login_repository.dart';

/// Login screen with email/password form, fintech-themed dark UI.
/// Creates its own LoginBloc instance — no global provider needed.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Local BLoC instance — explicit and easy to follow
  final LoginBloc _loginBloc = LoginBloc(
    loginRepository: LoginRepository(),
  );

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );
    _animationController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    _loginBloc.close();
    super.dispose();
  }

  void _onLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      _loginBloc.add(
        LoginSubmitted(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      bloc: _loginBloc,
      listener: (context, state) {
        if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSpacing.sm),
              ),
            ),
          );
        } else if (state is LoginSuccess) {
          Navigator.of(context).pushReplacementNamed('/home');
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // App Logo
                        _buildLogo(),
                        const SizedBox(height: AppSpacing.xxl),

                        // Title
                        Text(
                          AppStrings.loginTitle,
                          style: AppTextStyles.display,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          AppStrings.loginSubtitle,
                          style: AppTextStyles.caption.copyWith(fontSize: 14),
                        ),
                        const SizedBox(height: AppSpacing.xxl + AppSpacing.lg),

                        // Email Field
                        AppTextField(
                          controller: _emailController,
                          hintText: AppStrings.emailHint,
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: Validators.validateEmail,
                        ),
                        const SizedBox(height: AppSpacing.lg),

                        // Password Field
                        AppTextField(
                          controller: _passwordController,
                          hintText: AppStrings.passwordHint,
                          prefixIcon: Icons.lock_outlined,
                          obscureText: _obscurePassword,
                          textInputAction: TextInputAction.done,
                          validator: Validators.validatePassword,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: AppColors.textSecondary,
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xxl),

                        // Login Button — uses bloc: parameter
                        BlocBuilder<LoginBloc, LoginState>(
                          bloc: _loginBloc,
                          builder: (context, state) {
                            return AppButton(
                              label: AppStrings.loginButton,
                              isLoading: state is LoginLoading,
                              onPressed: _onLogin,
                            );
                          },
                        ),
                        const SizedBox(height: AppSpacing.xl),

                        // Demo credentials hint
                        _buildCredentialsHint(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the app logo with a gradient icon container.
  Widget _buildLogo() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.primaryLight],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: const Icon(
        Icons.trending_up_rounded,
        color: AppColors.background,
        size: 40,
      ),
    );
  }

  /// Builds a subtle hint showing demo credentials.
  Widget _buildCredentialsHint() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        children: [
          Text(
            'Demo Credentials',
            style: AppTextStyles.label.copyWith(color: AppColors.gold),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'investor@dealflow.com / password123',
            style: AppTextStyles.caption,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text('admin@dealflow.com / admin456', style: AppTextStyles.caption),
        ],
      ),
    );
  }
}
