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
  String newPasswordConfirmation = '';
  TextEditingController usernameTEC = TextEditingController();
  TextEditingController passwordTEC = TextEditingController();
  TextEditingController passwordConfirmationTEC = TextEditingController();
  late final databaseList = ref.watch(usersNotifierProvider);

  get userBalance => 0;

  createAccount(String username, String password, String passwordConfirmation) {
    newUsername = usernameTEC.text;
    newPassword = passwordTEC.text;
    newPasswordConfirmation = passwordConfirmationTEC.text;

    if (password == passwordConfirmation) {
      User newUser = User(
        username,
        password,
        userBalance,
        databaseList.length++
      );
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
  bool _userMatch = false;
  int userID = 0;

  void checkUserMatch(User user) {
    final allUsers = ref.watch(usersNotifierProvider);
    _userMatch = user == allUsers;
  }

  void logIn() {
    User enteredUser = User('$_usernameTEC', '$_passwordTEC', int as int, int as int);
    checkUserMatch(enteredUser);
    if ( _userMatch == true) {
      context.push('/dashboard');
      userID = enteredUser.userNumber;
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