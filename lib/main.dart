import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return MyHomePage();
      },
      routes: [
        GoRoute(
          path: 'create_account',
          builder: (BuildContext context, GoRouterState state) {
            return CreateAccount();
          },
        ),
        GoRoute(
          path: 'login',
          builder: (BuildContext context, GoRouterState state) {
            return LogIn();
          },
        ),
        GoRoute(
          path: 'dashboard',
          builder: (BuildContext context, GoRouterState state) {
            return Dashboard();
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: _router,
    );
  }
}

class MyHomePage extends StatefulWidget {

  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.redAccent,
                border: Border.all(color: Colors.black, width: 4),
              ),
              width: 450,
              height: 100,
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      'Welcome to the bank!',
                      style: TextStyle(
                        fontWeight: (FontWeight.bold),
                        fontSize: 35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () => context.push('/login'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.orangeAccent,
                padding: EdgeInsets.all(20),
                fixedSize: Size(250, 50),
                textStyle: TextStyle(fontWeight: FontWeight.bold),
                side: BorderSide(color: Colors.black, width: 2),
                shape: StadiumBorder(),
              ),
              child: Text('Log In'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.push('/create_account'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.orangeAccent,
                padding: EdgeInsets.all(20),
                fixedSize: Size(250, 50),
                textStyle: TextStyle(fontWeight: FontWeight.bold),
                side: BorderSide(color: Colors.black, width: 2),
                shape: StadiumBorder(),
              ),
              child: Text('Create an Account'),
            ),
          ],
        ),
      ),
    );
  }
}

class CreateAccount extends StatelessWidget {
  const CreateAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create an Account')),
      body: Center(
        child: Text(
          'Under Construction',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.red
          ),
        ),
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Padding(padding: const EdgeInsets.symmetric(horizontal: 400),
        //       child: TextFormField(
        //         decoration: const InputDecoration(
        //           border: OutlineInputBorder(),
        //           labelText: 'Enter a username',
        //         ),
        //       ),
        //     ),
        //     SizedBox(height: 20),
        //     Padding(padding: const EdgeInsets.symmetric(horizontal: 400),
        //       child: TextFormField(
        //         obscureText: true,
        //         decoration: const InputDecoration(
        //           border: OutlineInputBorder(),
        //           labelText: 'Enter a password',
        //         ),
        //       ),
        //     ),
        //     SizedBox(height: 20),
        //     Padding(padding: const EdgeInsets.symmetric(horizontal: 400),
        //       child: TextFormField(
        //         obscureText: true,
        //         decoration: const InputDecoration(
        //           border: OutlineInputBorder(),
        //           labelText: 'Confirm your password',
        //         ),
        //       ),
        //     ),
        //     SizedBox(height: 20),
        //     Padding(padding: const EdgeInsets.symmetric(horizontal: 400),
        //       child: ElevatedButton(
        //         onPressed: () {
        //           // insert functions here
        //           context.pop();
        //         },
        //         style: ElevatedButton.styleFrom(
        //           foregroundColor: Colors.black,
        //           backgroundColor: Colors.redAccent,
        //           padding: EdgeInsets.all(20),
        //           fixedSize: Size(250, 50),
        //           textStyle: TextStyle(fontWeight: FontWeight.bold),
        //           side: BorderSide(color: Colors.black, width: 2),
        //           shape: StadiumBorder(),
        //         ),
        //         child: Text('Create Account')
        //       ),
        //     ),
        //   ],
        // ),
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

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<StatefulWidget> createState() {
    return DashboardState();
  }
}

class DashboardState extends State<Dashboard> {

  int _debt = 0;
  int _balance = 0;
  int _balanceChange = 0;
  TextEditingController _balanceChangeTEC = TextEditingController();

  void payDebtSurplus(int a, int b) {
    setState(() {
      _balance = (a + b);
    });
  }

  void payDebt(int a, int b) {
    setState(() {
      _debt = (a + b);
    });
  }

  void deposit() {
    _balanceChange = int.tryParse(_balanceChangeTEC.text) ?? 0;
    computeDeposit(_balance, _balanceChange);
  }

  void withdraw() {
    _balanceChange = int.tryParse(_balanceChangeTEC.text) ?? 0;
    computeWithdraw(_balance, _balanceChange);
  }

  void computeDeposit(int a, int b) {
    setState(() {
      if (_debt < 0) {
        if (_balanceChange > _debt) {
          payDebtSurplus(_balanceChange, _debt);
          _debt = 0;
        } else {
          payDebt(_debt, _balanceChange);
          _debt = (a + b);
        }
      } else {
        _balance = (a + b);
      }
    });
  }

  void computeWithdraw(int a, int b) {
    setState(() {
      if (_balanceChange > _balance) {
        _debt = (a - b);
        _balance = 0;
      } else {
        _balance = (a - b);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: [
            SizedBox(width: 50),
            Container(
              decoration: BoxDecoration(
                color: Colors.redAccent,
                border: Border.all(color: Colors.black, width: 4),
              ),
              width: 650,
              height: 600,
              child: Stack(
                children: [
                  Positioned(
                    top: 300,
                    left: 100,
                    child: SizedBox(
                      width: 450,
                      height: 150,
                      child: Stack(
                        children: [
                          TextFormField(
                            controller: _balanceChangeTEC,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.orangeAccent,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)
                              ),
                              labelText: 'Enter a deposit or withdrawal amount',
                            ),
                            style: TextStyle(
                                color: Colors.black
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 75,
                    left: 70,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        border: Border.all(color: Colors.black, width: 4),
                      ),
                      width: 500,
                      height: 100,
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          'Deposit / Withdraw',
                          style: TextStyle(
                            fontWeight: (FontWeight.bold),
                            fontSize: 40,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 150,
                    bottom: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        deposit();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.orangeAccent,
                        padding: EdgeInsets.all(20),
                        fixedSize: Size(150, 50),
                        textStyle: TextStyle(fontWeight: FontWeight.bold),
                        side: BorderSide(color: Colors.black, width: 2),
                        shape: StadiumBorder(),
                      ),
                      child: Text('Deposit'),
                    ),
                  ),
                  Positioned(
                    right: 150,
                    bottom: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        withdraw();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.orangeAccent,
                        padding: EdgeInsets.all(20),
                        fixedSize: Size(150, 50),
                        textStyle: TextStyle(fontWeight: FontWeight.bold),
                        side: BorderSide(color: Colors.black, width: 2),
                        shape: StadiumBorder(),
                      ),
                      child: Text('Withdraw'),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                color: Colors.redAccent,
                border: Border.all(color: Colors.black, width: 4),
              ),
              width: 450,
              height: 600,
              child: Stack(
                children: [
                  Positioned(
                    top: 75,
                    left: 70,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        border: Border.all(color: Colors.black, width: 4),
                      ),
                      width: 300,
                      height: 100,
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          'Debt',
                          style: TextStyle(
                            fontWeight: (FontWeight.bold),
                            fontSize: 40,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 200,
                    left: 70,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        border: Border.all(color: Colors.black, width: 4),
                      ),
                      width: 300,
                      height: 75,
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          '\$$_debt',
                          style: TextStyle(
                            fontWeight: (FontWeight.bold),
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 175,
                    left: 70,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        border: Border.all(color: Colors.black, width: 4),
                      ),
                      width: 300,
                      height: 100,
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          'Balance',
                          style: TextStyle(
                            fontWeight: (FontWeight.bold),
                            fontSize: 40,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 75,
                    left: 70,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        border: Border.all(color: Colors.black, width: 4),
                      ),
                      width: 300,
                      height: 75,
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          '\$$_balance',
                          style: TextStyle(
                            fontWeight: (FontWeight.bold),
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 50),
          ],
        ),
      ),
    );
  }
}