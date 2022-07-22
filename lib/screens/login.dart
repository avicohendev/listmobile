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

  OverlayEntry? entry;
  void showOverlay() {
    final overlay = Overlay.of(context);
    final width = MediaQuery.of(context).size.width;
    entry = OverlayEntry(
      builder: ((context) => Positioned(
            width: width,
            height: MediaQuery.of(context).size.height,
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 2,
                sigmaY: 2,
              ),
              child: const OverlaySpinner(),
            ),
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
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 80.0),
            Column(
              children: const <Widget>[Text('Login')],
            ),
            const SizedBox(height: 120.0),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                filled: true,
                labelText: 'Username',
              ),
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                filled: true,
                labelText: 'Password',
              ),
              obscureText: true,
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
                    hideOverlay();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
