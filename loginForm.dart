import 'package:flutter/material.dart';
// import 'package:du_commit/global/includes/actions.inc.global.dart' as actions;

class XLoginForm extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const XLoginForm({super.key, 
    required this.emailController,
    required this.passwordController,
  });

  @override
  // ignore: library_private_types_in_public_api
  _XLoginFormState createState() => _XLoginFormState();
}

class _XLoginFormState extends State<XLoginForm> {
  bool _isButtonPressed = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _isButtonPressed = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _isButtonPressed = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _isButtonPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return Column(
      children: <Widget>[
        // Input box for email
        Container(
          width: size.width * 0.8,
          margin: const EdgeInsets.only(top: 18.0),
          child: tInput(context, "Email", widget.emailController),
        ),
        const SizedBox(height: 15.0),
        // Input box for password
        Container(
          width: size.width * 0.8,
          margin: const EdgeInsets.only(top: 18.0),
          child: tInput(context, "Enter your password", widget.passwordController,
              isPass: true),
        ),
        const SizedBox(height: 30.0),
        // Login button
        GestureDetector(
          onTapDown: _handleTapDown,
          onTapUp: _handleTapUp,
          onTapCancel: _handleTapCancel,
          onTap: () {
            // actions.authentication(
            //   widget.emailController.text.trim().replaceAll('-', '/'),
            //   widget.passwordController.text.trim().replaceAll('-', '/'),
            //   context,
            // );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _isButtonPressed
                    ? theme.colorScheme.primary.withOpacity(0.5)
                    : theme.primaryColor,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: const Center(
                child: Text(
                  "LOGIN",
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 2,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget tInput(
      BuildContext context, String hint, TextEditingController controller,
      {bool isPass = false}) {
    final theme = Theme.of(context);
    final inputDecorationTheme = theme.inputDecorationTheme;

    return TextField(
      controller: controller,
      obscureText: isPass,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: inputDecorationTheme.hintStyle,
        contentPadding: inputDecorationTheme.contentPadding,
        enabledBorder: inputDecorationTheme.enabledBorder,
        focusedBorder: inputDecorationTheme.focusedBorder,
      ),
    );
  }
}
