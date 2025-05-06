import 'package:coffe_front/core/network/api/api_error_handler.dart';
import 'package:coffe_front/features/auth/presentation/viewmodels/auth_view_model.dart';
import 'package:coffe_front/features/auth/presentation/widgets/login_form.dart';
import 'package:coffe_front/features/auth/presentation/widgets/login_register_toggle.dart';
import 'package:coffe_front/features/auth/presentation/widgets/register_form.dart';
import 'package:coffe_front/features/navigations/presentation/navigation_screen.dart';
import 'package:coffe_front/utils/color_manager.dart';
import 'package:coffe_front/utils/string_manager.dart';
import 'package:coffe_front/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  String toShow = "login";
  _loginTap() {
    setState(() {
      toShow = "login";
    });
  }

  _registerTap() {
    setState(() {
      toShow = "reg";
    });
  }

  @override
  Widget build(BuildContext context) {
    final provRead = ref.read(authProvider.notifier);
    ref.listen<AuthStates>(authProvider, (previous, next) {
      if (next is RegisterSuccessState) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.message)));
        provRead.resetState();
        setState(() {
          toShow = "login";
        });
      }
      if (next is LoginSuccessState) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.message)));
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => NavigationScreen()),
          (Route<dynamic> route) => false,
        );
      }
      if (next is ErrorState) {
        ScaffoldMessenger.of(context).clearSnackBars();
        final ex = next.ex;
        if (ex is DioHttpException) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(ex.errorMessage)));
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Something went wrong")));
        }
        provRead.resetState();
      }
    });

    return Scaffold(
      backgroundColor: ColorManager.background,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: TextStyles.poppins_16_400(StringManager.welcome)),
              SizedBox(height: 20),
              LoginRegisterToggle(
                toShow: toShow,
                loginTap: _loginTap,
                registerTap: _registerTap,
              ),
              SizedBox(height: 30),
              toShow == "login" ? LoginForm() : RegisterForm(),
            ],
          ),
        ),
      ),
    );
  }
}
