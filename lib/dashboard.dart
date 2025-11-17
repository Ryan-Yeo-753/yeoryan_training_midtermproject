import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training_template/user_storage_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return DashboardState();
  }
}

class DashboardState extends ConsumerState<Dashboard> {
  late int balance = ref.read(currentUserNotifierProvider).userBalance;
  late int debt = ref.read(currentUserNotifierProvider).userDebt;
  int _balanceChange = 0;
  TextEditingController _balanceChangeTEC = TextEditingController();

  void error() {}

  int add(int a, int b) => (a + b);

  int subtract(int a, int b) => (a - b);

  int loan(int a, int b) => (a - b);

  void computeDeposit() {
    // a = balance, b = balanceChange, c = debt
    setState(() {
      if (debt != 0) { // Debt?
        if (_balanceChange >= debt) { // Enough to pay off debt?
          balance = subtract(_balanceChange, debt); // payDebtSurplus()
          debt = 0;
        } else {
          debt = subtract(debt, _balanceChange); // payDebt()
        }
      } else {  // No debt
        balance = add(balance, _balanceChange); // depositToBalance()
      }
    });
  }

  void computeWithdraw() {
    // a = balance, b = balanceChange, c = debt
    setState(() {
      if (_balanceChange > balance) { // Loan?
        if (debt > 0) { // Have debt?
          debt = add(debt, _balanceChange); // extraLoan()
        } else {
          debt = loan(_balanceChange, balance); // normalLoan()
          balance = 0;
        }
      } else if (_balanceChange <= balance) { // Enough money?
        balance = subtract(balance, _balanceChange); // withdrawFromBalance()
      }
    });
  }

  void deposit() {
    _balanceChange = int.tryParse(_balanceChangeTEC.text) ?? 0;
    _balanceChange < 0 ? error() : computeDeposit();
  }

  void withdraw() {
    _balanceChange = int.tryParse(_balanceChangeTEC.text) ?? 0;
    _balanceChange < 0 ? error() : computeWithdraw();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          ToggleSwitch(
            totalSwitches: 2,
            activeBgColors: [[Colors.white], [Colors.black]],
            activeFgColor: Colors.pinkAccent,
            inactiveBgColor: Colors.grey,
            inactiveFgColor: Colors.blueGrey,
            labels: const ['Light', 'Dark'],
            initialLabelIndex: 0,
            onToggle: (index) {
              index == 0 ?
              AdaptiveTheme.of(context).setLight() :
              AdaptiveTheme.of(context).setDark();
            },
          )
        ],
      ),
      body: Center(
        child: Row(
          children: [
            SizedBox(width: 50),
            Container(
              decoration: BoxDecoration(
                color: Colors.red,
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
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              labelText: 'Enter a deposit or withdrawal amount',
                            ),
                            style: TextStyle(color: Colors.black),
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
                      onPressed: () {deposit();},
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.redAccent,
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
                      onPressed: () {withdraw();},
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.redAccent,
                        padding: EdgeInsets.all(20),
                        fixedSize: Size(150, 50),
                        textStyle: TextStyle(fontWeight: FontWeight.bold),
                        side: BorderSide(color: Colors.black, width: 2),
                        shape: StadiumBorder(),
                      ),
                      child: Text('Withdraw'),
                    ),
                  ),
                  Positioned(
                    right: 25,
                    bottom: 25,
                    child: ElevatedButton(
                      onPressed: () {
                        ref.read(currentUserNotifierProvider.notifier).
                          updateCurrentUser(
                            User(
                              ref.read(currentUserNotifierProvider).username,
                              ref.read(currentUserNotifierProvider).password,
                              balance,
                              debt
                            )
                          );
                        ref.read(currentUserNotifierProvider.notifier).
                          clearCurrentUser();
                        context.push('/bank');
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.orangeAccent,
                        padding: EdgeInsets.all(10),
                        fixedSize: Size(100, 40),
                        textStyle: TextStyle(fontWeight: FontWeight.bold),
                        side: BorderSide(color: Colors.black, width: 2),
                        shape: StadiumBorder(),
                      ),
                      child: Text('Sign Out'),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                color: Colors.red,
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
                        color: Colors.redAccent,
                        border: Border.all(color: Colors.black, width: 4),
                      ),
                      width: 300,
                      height: 75,
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          '\$$debt',
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
                        color: Colors.redAccent,
                        border: Border.all(color: Colors.black, width: 4),
                      ),
                      width: 300,
                      height: 75,
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          '\$$balance',
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
