import 'package:coffe_front/utils/color_manager.dart';
import 'package:coffe_front/utils/text_styles.dart';
import 'package:flutter/material.dart';

class LoginRegisterToggle extends StatelessWidget {
  final String toShow;
  final Function loginTap;
  final Function registerTap;
  const LoginRegisterToggle({
    super.key,
    required this.toShow,
    required this.loginTap,
    required this.registerTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget toggleContainer(String text, bool toggled, Function pick) {
      return GestureDetector(
        onTap: () {
          pick();
        },
        child: Container(
          width: 145,
          height: double.infinity,
          decoration: BoxDecoration(
            color: toggled ? ColorManager.shade : null,
            borderRadius: BorderRadius.circular(33),
          ),
          child: Center(
            child: TextStyles.poppins_16_400(text, color: Colors.white),
          ),
        ),
      );
    }

    return Container(
      height: 59,
      width: 315,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: ColorManager.navy,
        borderRadius: BorderRadius.circular(33),
      ),
      child: Row(
        children: [
          toggleContainer("Login", toShow == "login", loginTap),
          toggleContainer("Register", toShow == "reg", registerTap),
        ],
      ),
    );
  }
}
