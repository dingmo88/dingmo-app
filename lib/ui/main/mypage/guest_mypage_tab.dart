import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/ui/account/signup/form/signup_form.dart';
import 'package:dingmo/ui/widgets/light_status_bar.dart';
import 'package:flutter/material.dart';

class GuestMypageTab extends StatelessWidget {
  const GuestMypageTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LightStatusBarWidget(
      child: Scaffold(
        body: SafeArea(
            child: Center(
          child: GestureDetector(
            onTap: () {
              SignUpForm.instance().startRouteName =
                  ModalRoute.of(context)?.settings.name;
              Navigator.pushNamed(context, Routes.loginMain);
            },
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: AppColors.mediumPink)),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  "로그인/회원가입",
                  style: TextStyle(
                      fontSize: 16,
                      color: AppColors.mediumPink,
                      fontWeight: FontWeight.bold),
                )
              ]),
            ),
          ),
        )),
      ),
    );
  }
}
