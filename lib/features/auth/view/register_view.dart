import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/helper/app_navigator.dart';
import '/core/helper/app_popup.dart';
import '/core/helper/app_validator.dart';
import '/core/widgets/custom_filled_btn.dart';
import '/core/widgets/custom_form_field.dart';
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
        appBar: AppBar(title: const Text('Register')),
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
            return Form(
              key: RegisterCubit.get(context).formKey,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    CustomFormField(
                      controller: RegisterCubit.get(context).username,
                      prefix: Icon(Icons.person),
                      hintText: 'Username',
                      validator: AppValidator.validateRequired,
                    ),
                    SizedBox(height: 20),
                    CustomFormField(
                      controller: RegisterCubit.get(context).password,
                      prefix: Icon(Icons.lock),
                      hintText: 'Password',
                      obscureText: RegisterCubit.get(context).passwordSecure,
                      suffix: IconButton(
                        onPressed: RegisterCubit.get(
                          context,
                        ).changePasswordSecure,
                        icon: RegisterCubit.get(context).passwordSecure
                            ? Icon(Icons.lock_open)
                            : Icon(Icons.lock),
                      ),
                      validator: AppValidator
                          .validateRequired, // TODO: check Length mi 6
                    ),
                    SizedBox(height: 20),
                    CustomFormField(
                      controller: RegisterCubit.get(context).confirmPassword,
                      prefix: Icon(Icons.lock),
                      hintText: 'Confirm Password',
                      obscureText: RegisterCubit.get(
                        context,
                      ).confirmPasswordSecure,
                      validator: AppValidator
                          .validateRequired, // TODO: Check equal to password
                    ),
                    SizedBox(height: 40),
                    state is RegisterLoadingState
                        ? CircularProgressIndicator()
                        : CustomFilledBtn(
                            onPressed: RegisterCubit.get(
                              context,
                            ).onRegisterPressed,
                            text: 'Register',
                          ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account?'),
                        TextButton(
                          onPressed: () =>
                              AppNavigator.goTo(context, const LoginView()),
                          child: const Text('Login'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
