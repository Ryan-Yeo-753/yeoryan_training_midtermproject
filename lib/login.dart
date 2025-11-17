import 'package:flutter/material.dart';
import 'package:flutter_training_template/user_storage_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateAccount extends ConsumerStatefulWidget {
  const CreateAccount({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return CreateAccountState();
  }
}

class CreateAccountState extends ConsumerState<CreateAccount> {
  String newUsername = '';
  String newPassword = '';
  final TextEditingController _newUsernameTEC = TextEditingController();
  final TextEditingController _newPasswordTEC = TextEditingController();
  final TextEditingController _passwordConfirmationTEC = TextEditingController();
  late final databaseList = ref.watch(usersNotifierProvider);

  get userBalance => 0;

  createAccount() {
    if (_newPasswordTEC.text == _passwordConfirmationTEC.text) {
      User newUser = User(_newUsernameTEC.text, _newPasswordTEC.text, 0, 0,);
      ref.read(usersNotifierProvider.notifier).addUser(newUser);
      context.push('/bank');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create an Account')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AccountDataCollector(
              controller: _newUsernameTEC,
              label: 'Enter a username',
              textObscured: false
            ),
            SizedBox(height: 20),
            AccountDataCollector(
              controller: _newPasswordTEC,
              label: 'Enter a password',
              textObscured: true
            ),
            SizedBox(height: 20),
            AccountDataCollector(
              controller: _passwordConfirmationTEC,
              label: 'Confirm your password',
              textObscured: true
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 400),
              child: ElevatedButton(
                onPressed: () {
                  createAccount();
                  context.pop();
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.redAccent,
                  padding: EdgeInsets.all(20),
                  fixedSize: Size(250, 50),
                  textStyle: TextStyle(fontWeight: FontWeight.bold),
                  side: BorderSide(color: Colors.black, width: 2),
                  shape: StadiumBorder(),
                ),
                child: Text('Create Account'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LogIn extends ConsumerStatefulWidget {
  const LogIn({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return LogInState();
  }
}

class LogInState extends ConsumerState<LogIn> {
  TextEditingController _usernameTEC = TextEditingController();
  TextEditingController _passwordTEC = TextEditingController();

  void logIn() {
    final allUsers = ref.read(usersNotifierProvider);

    for (User checkedUser in allUsers) {
      if (_usernameTEC.text == checkedUser.username &&
          _passwordTEC.text == checkedUser.password) {
        ref.read(currentUserNotifierProvider.notifier).newCurrentUser(checkedUser);
        context.push('/dashboard');
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Log In')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AccountDataCollector(
              controller: _usernameTEC,
              label: 'Enter your username',
              textObscured: false
            ),
            SizedBox(height: 20),
            AccountDataCollector(
              controller: _passwordTEC,
              label: 'Enter your password',
              textObscured: true
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                logIn();
              },
              child: Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}

class AccountDataCollector extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool textObscured;

  const AccountDataCollector({
    super.key,
    required this.controller,
    required this.label,
    required this.textObscured
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 400),
      child: TextFormField(
        controller: controller,
        obscureText: textObscured,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
        ),
      ),
    );
  }
}