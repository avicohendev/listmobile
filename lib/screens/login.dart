import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:listmobile/authentication/authentication.dart';
import 'package:listmobile/common/widgets/overlaySpinner.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  OverlayEntry? entry;
  void showOverlay() {
    final overlay = Overlay.of(context);
    final width = MediaQuery.of(context).size.width;
    entry = OverlayEntry(
      builder: ((context) => Positioned(
            width: width,
            height: MediaQuery.of(context).size.height,
            child: const OverlaySpinner(),
          )),
    );

    overlay!.insert(entry!);
  }

  void hideOverlay() {
    entry?.remove();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            children: <Widget>[
              const SizedBox(height: 80.0),
              Column(
                children: const <Widget>[Text('Login')],
              ),
              const SizedBox(height: 120.0),
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Username',
                ),
              ),
              const SizedBox(height: 12.0),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Password',
                ),
                obscureText: true,
                onFieldSubmitted: (value) async {
                  showOverlay();
                  await signIn(
                      email: _usernameController.text,
                      password: _passwordController.text);
                  Navigator.pushNamed(context, "/list");
                  hideOverlay();
                },
              ),
              OverflowBar(
                alignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: const Text('CANCEL'),
                    onPressed: () {
                      _usernameController.clear();
                      _passwordController.clear();
                    },
                  ),
                  // TODO: Add an elevation to NEXT (103)
                  // TODO: Add a beveled rectangular border to NEXT (103)
                  ElevatedButton(
                    child: const Text('NEXT'),
                    onPressed: () async {
                      showOverlay();
                      await signIn(
                          email: _usernameController.text,
                          password: _passwordController.text);
                      if (getUser().email != null) {
                        Navigator.pushNamed(context, "/list");
                        hideOverlay();
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
