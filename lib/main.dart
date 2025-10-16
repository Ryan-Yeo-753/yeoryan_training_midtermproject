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
        GoRoute(
          path: 'deposit',
          builder: (BuildContext context, GoRouterState state) {
            return Deposit();
          },
        ),
        GoRoute(
          path: 'withdraw',
          builder: (BuildContext context, GoRouterState state) {
            return Withdraw();
          },
        ),
        GoRoute(
          path: 'loan',
          builder: (BuildContext context, GoRouterState state) {
            return Loan();
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: const EdgeInsets.symmetric(horizontal: 400),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter a username',
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 400),
              child: TextFormField(
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
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Are your username and password correct?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel')
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, 'Cancel');
                            context.pop();
                          },
                          child: const Text('Confirm')
                        ),
                      ],
                    ),
                  );
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

class LogIn extends StatelessWidget {
  const LogIn({super.key});

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
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your username',
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 400),
              child: TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your password',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.redAccent,
              width: 300,
              height: 500,
              child: Stack(
                children: [

                ],
              ),
            ),
            Container(
              color: Colors.pink,
              width: 300,
              height: 500,
              child: Stack(
                children: [

                ],
              ),
            ),
            Container(
              color: Colors.redAccent,
              width: 300,
              height: 500,
              child: Stack(
                children: [

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Deposit extends StatelessWidget {
  const Deposit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [TextField()],
        ),
      ),
    );
  }
}

class Withdraw extends StatelessWidget {
  const Withdraw({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [TextField()],
        ),
      ),
    );
  }
}

class Loan extends StatelessWidget {
  const Loan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [TextField()],
        ),
      ),
    );
  }
}