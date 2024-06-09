import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_app/ui/register/register_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined,
                size: 18, color: Colors.white),
          )),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPageTitle(),
              const SizedBox(height: 53),
              _buildFormLogin(),
              _buildOrSplitDivider(),
              _buildSocialLogin(),
              _buildHaveAccount(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageTitle() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 40),
      child: Text(
        "Login",
        style: TextStyle(
            color: Colors.white.withOpacity(0.87),
            fontFamily: "Lato",
            fontSize: 32,
            fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildFormLogin() {
    return Form(
        child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUsernameField(),
          const SizedBox(height: 25),
          _buildPasswordField(),
          _buildLoginButton()
        ],
      ),
    ));
  }

  Column _buildUsernameField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Username",
          style: TextStyle(
            color: Colors.white.withOpacity(0.87),
            fontFamily: "Lato",
            fontSize: 16,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: TextFormField(
            decoration: InputDecoration(
                hintText: "Enter your Username",
                hintStyle: const TextStyle(
                  color: Color(0xFF535353),
                  fontFamily: "Lato",
                  fontSize: 16,
                ),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
                fillColor: Color(0xFF1D1D1D),
                filled: true),
            style: const TextStyle(
              color: Colors.white,
              fontFamily: "Lato",
              fontSize: 16,
            ),
          ),
        )
      ],
    );
  }

  Column _buildPasswordField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Password",
          style: TextStyle(
            color: Colors.white.withOpacity(0.87),
            fontFamily: "Lato",
            fontSize: 16,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: TextFormField(
            decoration: InputDecoration(
                hintText: "********",
                hintStyle: const TextStyle(
                  color: Color(0xFF535353),
                  fontFamily: "Lato",
                  fontSize: 16,
                ),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
                fillColor: Color(0xFF1D1D1D),
                filled: true),
            style: const TextStyle(
              color: Colors.white,
              fontFamily: "Lato",
              fontSize: 16,
            ),
            obscureText: true,
          ),
        )
      ],
    );
  }

  Widget _buildLoginButton() {
    return Container(
      width: double.infinity,
      height: 48,
      margin: const EdgeInsets.only(top: 70),
      child: ElevatedButton(
          onPressed: null, //Muốn disable thì trả về giá trị null
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8875FF),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              disabledBackgroundColor:
                  const Color(0xFF8687E7).withOpacity(0.5)),
          child: const Text(
            "Login",
            style: TextStyle(
                fontSize: 16, fontFamily: "Lato", color: Colors.white),
          )),
    );
  }

  Widget _buildOrSplitDivider() {
    return Container(
      margin: const EdgeInsets.only(top: 45, bottom: 40),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 1,
              width: double.infinity,
              color: const Color(0xFF979797),
            ),
          ),
          const Text(
            "or",
            style: TextStyle(
                fontSize: 16, fontFamily: "Lato", color: Color(0xFF979797)),
          ),
          Expanded(
            child: Container(
              height: 1,
              width: double.infinity,
              color: const Color(0xFF979797),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialLogin() {
    return Column(
      children: [
        _buildSocialGoogleLogin(),
        _buildSocialAppleLogin(),
      ],
    );
  }

  Widget _buildSocialGoogleLogin() {
    return Container(
      width: double.infinity,
      height: 48,
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ElevatedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              side: BorderSide(width: 1, color: const Color(0xFF8875FF))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/google.png",
                width: 24,
                height: 24,
                fit: BoxFit.fill,
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: const Text(
                  "Login with Google",
                  style: TextStyle(
                      fontSize: 16, fontFamily: "Lato", color: Colors.white),
                ),
              ),
            ],
          )),
    );
  }

  Widget _buildSocialAppleLogin() {
    return Container(
      width: double.infinity,
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ElevatedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              side: BorderSide(width: 1, color: const Color(0xFF8875FF))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/apple.png",
                width: 24,
                height: 24,
                fit: BoxFit.fill,
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: const Text(
                  "Login with Appe",
                  style: TextStyle(
                      fontSize: 16, fontFamily: "Lato", color: Colors.white),
                ),
              ),
            ],
          )),
    );
  }

  Widget _buildHaveAccount(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 46, bottom: 20),
      alignment: Alignment.center,
      child: RichText(
          text: TextSpan(
              text: "Don’t have an account? ",
              style: const TextStyle(
                  fontSize: 12, fontFamily: "Lato", color: Color(0xFF979797)),
              children: [
            TextSpan(
                text: "Login",
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Lato",
                    color: Colors.white.withOpacity(0.87)),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    _goToRegisterPage(context);
                  })
          ])),
    );
  }

  void _goToRegisterPage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const RegisterPage()));
  }
}
