import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:travel_app/screens/auth/components/my_text_field.dart';

class ForgotPasswordComponent extends StatefulWidget {
  const ForgotPasswordComponent({super.key});

  @override
  State<ForgotPasswordComponent> createState() =>
      _ForgotPasswordComponentState();
}

class _ForgotPasswordComponentState extends State<ForgotPasswordComponent> {
  final emailController = TextEditingController();
  String? _errorMsg;
  final _formKey = GlobalKey<FormState>();
  bool resetRequired = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state is ResetPasswordLoading) {
          setState(() {
            resetRequired = true;
          });
        } else if (state is ResetPasswordFailure) {
          setState(() {
            resetRequired = false;
            _errorMsg = state.errorMsg;
          });
        } else if (state is ResetPasswordSuccess) {
          setState(() {
            resetRequired = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Password reset email was sent.'),
            ),
          );
          Navigator.pop(context);
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 100),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: const Text(
                'Receive an email to reset your password.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: MyTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(CupertinoIcons.mail_solid),
                errorMsg: _errorMsg,
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Please fill in this field';
                  } else if (!RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$')
                      .hasMatch(val)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 25),
            !resetRequired
                ? SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context
                              .read<SignInBloc>()
                              .add(ResetPasswordRequired(emailController.text));
                        }
                      },
                      style: TextButton.styleFrom(
                        elevation: 3.0,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60),
                        ),
                      ),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                        child: Text(
                          'Send reset link',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  )
                : const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
