import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/helper/app_navigator.dart';
import '/core/helper/app_popup.dart';
import '/core/helper/app_validator.dart';
import '/core/widgets/custom_filled_btn.dart';
import '/core/widgets/custom_form_field.dart';
import '/features/auth/view/Login_view.dart';

import '../cubit/login_cubit/login_cubit.dart';
import '../cubit/login_cubit/login_state.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Login')),
        body: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginErrorState) {
              SnackBarPopUp().show(
                context: context,
                message: state.error,
                state: PopUpState.error,
              );
            } else if (state is LoginSuccessState) {
              SnackBarPopUp().show(
                context: context,
                message: 'Logined successfully\nWelcome ${state.user.username}',
                state: PopUpState.success,
              );

              //  AppNavigator.goTo(context, const LoginView()); TODO: home
            }
          },
          builder: (context, state) {
            return Form(
              key: LoginCubit.get(context).formKey,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    CustomFormField(
                      controller: LoginCubit.get(context).username,
                      prefix: Icon(Icons.person),
                      hintText: 'Username',
                      validator: AppValidator.validateRequired,
                    ),
                    SizedBox(height: 20),
                    CustomFormField(
                      controller: LoginCubit.get(context).password,
                      prefix: Icon(Icons.lock),
                      hintText: 'Password',
                      obscureText: LoginCubit.get(context).passwordSecure,
                      suffix: IconButton(
                        onPressed: LoginCubit.get(context).changePasswordSecure,
                        icon: LoginCubit.get(context).passwordSecure
                            ? Icon(Icons.lock_open)
                            : Icon(Icons.lock),
                      ),
                      validator: AppValidator
                          .validateRequired, // TODO: check Length mi 6
                    ),
                    SizedBox(height: 20),

                    state is LoginLoadingState
                        ? CircularProgressIndicator()
                        : CustomFilledBtn(
                            onPressed: LoginCubit.get(context).onLoginPressed,
                            text: 'login',
                          ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don\'t have an account?'),
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
