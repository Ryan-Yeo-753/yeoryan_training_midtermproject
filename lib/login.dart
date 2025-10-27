import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class User {
  final String username;
  final String password;

  User(this.username, this.password);
}

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<StatefulWidget> createState() {
    return CreateAccountState();
  }
}

class CreateAccountState extends State<CreateAccount> {

  String newUsername = '';
  String newPassword = '';
  String newPasswordConfirmation = '';
  TextEditingController usernameTEC = TextEditingController();
  TextEditingController passwordTEC = TextEditingController();
  TextEditingController passwordConfirmationTEC = TextEditingController();

  var users = <User>[];

  createAccount(String username, String password, String passwordConfirmation) {
    newUsername = usernameTEC.text;
    newPassword = passwordTEC.text;
    newPasswordConfirmation = passwordConfirmationTEC.text;

    if (password == passwordConfirmation) {
      final newUser = User(username, password);
      users.add(newUser);
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
            Padding(padding: const EdgeInsets.symmetric(horizontal: 400),
              child: TextFormField(
                controller: usernameTEC,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter a username',
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 400),
              child: TextFormField(
                controller: passwordTEC,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter a password',
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 400),
              child: TextFormField(
                controller: passwordConfirmationTEC,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Confirm your password',
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 400),
              child: ElevatedButton(
                  onPressed: () {
                    createAccount(newUsername, newPassword, newPasswordConfirmation);
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
                  child: Text('Create Account')
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<StatefulWidget> createState() {
    return LogInState();
  }
}

class LogInState extends State<LogIn> {

  String _username = 'myUsername';
  String _password = 'myPassword';
  TextEditingController _usernameTEC = TextEditingController();
  TextEditingController _passwordTEC = TextEditingController();
  bool _usernameMatch = false;
  bool _passwordMatch = false;

  void logIn() {
    _username == _usernameTEC.text ? _usernameMatch = true : _usernameMatch = false;
    _password == _passwordTEC.text ? _passwordMatch = true : _usernameMatch = false;
    _usernameMatch == true && _passwordMatch == true ?
    context.push('/dashboard') :
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Log In')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: const EdgeInsets.symmetric(horizontal: 400),
              child: TextFormField(
                controller: _usernameTEC,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your username',
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 400),
              child: TextFormField(
                controller: _passwordTEC,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your password',
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {logIn();},
              child: Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}