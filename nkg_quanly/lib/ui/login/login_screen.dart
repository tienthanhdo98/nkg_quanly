import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nkg_quanly/main.dart';

import '../../const.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(30, 70, 30, 70),
          child: SafeArea(
              child: Column(
            children: [
              Image.asset("assets/logo.png"),
              const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 20)),
              borderItem(Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Xin chào"),
                    const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
                    Text(
                      "Đăng nhập tài khoản",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
                    const Text("Email"),
                    borderInputText(""),
                    const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
                    const Text("Mật khẩu"),
                    borderInputText(""),
                    const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: kLoginButton,
                            minimumSize: const Size.fromHeight(40)),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()));

                        },
                        child: const Padding(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: Text("ĐĂNG NHẬP"))),
                    const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
                    const Center(
                      child: Text(
                        "Quên mật khẩu",
                        style: TextStyle(color: kBlueButton),
                      ),
                    )
                  ],
                ),
              ),context),
              const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Bạn chưa có mật khẩu?"),
                  Text(
                    " Đăng nhập",
                    style: TextStyle(color: kBlueButton),
                  ),
                ],
              ),
            ],
          )),
        ));
  }
}
