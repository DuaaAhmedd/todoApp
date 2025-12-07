import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/helper/app_navigator.dart';
import '/core/helper/app_popup.dart';
import '/core/helper/app_validator.dart';
import '/core/utils/app_colors.dart';
import '/features/auth/cubit/register_cubit/register_cubit.dart';

import '../cubit/register_cubit/register_state.dart';
import 'login_view.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: Scaffold(
        body: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegisterErrorState) {
              SnackBarPopUp().show(
                context: context,
                message: state.error,
                state: PopUpState.error,
              );
            } else if (state is RegisterSuccessState) {
              SnackBarPopUp().show(
                context: context,
                message: 'Registered successfully',
                state: PopUpState.success,
              );

              AppNavigator.goTo(context, const LoginView());
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                // Palestinian Flag Background - Upper 40%
                Expanded(
                  flex: 4,
                  child: Image.asset(
                    'assets/flag.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                // Form Section - Lower 60%
                Expanded(
                  flex: 6,
                  child: Container(
                    color: Color(0xFFF5F5F5), // Light grey background
                    child: Form(
                      key: RegisterCubit.get(context).formKey,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 30,
                        ),
                        child: Column(
                          children: [
                            // Username Field
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 5,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                controller: RegisterCubit.get(context).username,
                                validator: AppValidator.validateRequired,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.grey[600],
                                  ),
                                  hintText: 'Username',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 16,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            // Password Field
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 5,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                controller: RegisterCubit.get(context).password,
                                obscureText: RegisterCubit.get(
                                  context,
                                ).passwordSecure,
                                validator: AppValidator.validateRequired,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.grey[600],
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: RegisterCubit.get(
                                      context,
                                    ).changePasswordSecure,
                                    icon: Icon(
                                      RegisterCubit.get(context).passwordSecure
                                          ? Icons.lock
                                          : Icons.lock_open,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  hintText: 'Password',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 16,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            // Confirm Password Field
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 5,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                controller: RegisterCubit.get(
                                  context,
                                ).confirmPassword,
                                obscureText: RegisterCubit.get(
                                  context,
                                ).confirmPasswordSecure,
                                validator: AppValidator.validateRequired,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.grey[600],
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: RegisterCubit.get(
                                      context,
                                    ).changeConfirmPasswordSecure,
                                    icon: Icon(
                                      RegisterCubit.get(
                                            context,
                                          ).confirmPasswordSecure
                                          ? Icons.lock
                                          : Icons.lock_open,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  hintText: 'Confirm Password',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 16,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            // Register Button
                            state is RegisterLoadingState
                                ? CircularProgressIndicator()
                                : Container(
                                    width: double.infinity,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: AppColors.primary, // Green
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.primary.withOpacity(
                                            0.3,
                                          ),
                                          blurRadius: 8,
                                          offset: Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: ElevatedButton(
                                      onPressed: RegisterCubit.get(
                                        context,
                                      ).onRegisterPressed,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'Register',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                            SizedBox(height: 30),
                            // Already Have An Account? Login
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Already Have An Account?',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(width: 5),
                                GestureDetector(
                                  onTap: () => AppNavigator.goTo(
                                    context,
                                    const LoginView(),
                                  ),
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                      color: Colors.grey[800],
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
