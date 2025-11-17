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
  late double balance = ref.read(currentUserNotifierProvider).userBalance;
  late double debt = ref.read(currentUserNotifierProvider).userDebt;
  double _balanceChange = 0;
  TextEditingController _balanceChangeTEC = TextEditingController();

  void error() {}

  double add(double a, double b) => (a + b);

  double subtract(double a, double b) => (a - b);

  double loan(double a, double b) => (a - b);

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
    _balanceChange = double.tryParse(_balanceChangeTEC.text) ?? 0;
    _balanceChange < 0 ? error() : computeDeposit();
  }

  void withdraw() {
    _balanceChange = double.tryParse(_balanceChangeTEC.text) ?? 0;
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
            BackingContainer(
              height: 600,
              width: 650,
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
                    child: ContainerLabel(label: 'Deposit/Withdraw', width: 500),
                  ),
                  Positioned(
                    left: 150,
                    bottom: 100,
                    child: DashboardButton(
                      label: 'Deposit',
                      height: 50,
                      width: 150,
                      onPressed: deposit,
                    )
                  ),
                  Positioned(
                    right: 150,
                    bottom: 100,
                    child: DashboardButton(
                      label: 'Withdraw',
                      height: 50,
                      width: 150,
                      onPressed: withdraw,
                    )
                  ),
                  Positioned(
                    right: 25,
                    bottom: 25,
                    child: DashboardButton(
                      label: 'Sign Out',
                      height: 40,
                      width: 100,
                      onPressed: () {
                        ref.read(
                          currentUserNotifierProvider.notifier
                        ).updateCurrentUser(
                          User(
                            ref.read(currentUserNotifierProvider).username,
                            ref.read(currentUserNotifierProvider).password,
                            balance,
                            debt
                          )
                        );
                        ref.read(
                          currentUserNotifierProvider.notifier
                        ).clearCurrentUser();
                        context.push('/bank');
                      }
                    )
                  ),
                ],
              )
            ),
            Spacer(),
            BackingContainer(
              height: 600,
              width: 450,
              child: Stack(
                children: [
                  Positioned(
                    top: 75,
                    left: 70,
                    child: ContainerLabel(label: 'Debt', width: 300),
                  ),
                  Positioned(
                      top: 200,
                      left: 70,
                      child: UserInformationContainer(value: debt)
                  ),
                  Positioned(
                    bottom: 175,
                    left: 70,
                    child: ContainerLabel(label: 'Balance', width: 300),
                  ),
                  Positioned(
                      bottom: 75,
                      left: 70,
                      child: UserInformationContainer(value: balance)
                  ),
                ],
              )
            ),
            SizedBox(width: 50),
          ],
        ),
      ),
    );
  }
}

class BackingContainer extends StatelessWidget {
  final double height;
  final double width;
  final Widget child;

  const BackingContainer({
    super.key,
    required this.height,
    required this.width,
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red,
        border: Border.all(color: Colors.black, width: 4),
      ),
      height: height,
      width: width,
      child: child
    );
  }
}

class ContainerLabel extends StatelessWidget {
  final String label;
  final double width;

  const ContainerLabel({
    super.key,
    required this.label,
    required this.width
  });

  @override
  Widget build(BuildContext context) {
    return Container (
      decoration: BoxDecoration(
        color: Colors.orange,
        border: Border.all(color: Colors.black, width: 4),
      ),
      width: width,
      height: 100,
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: (FontWeight.bold),
            fontSize: 40,
          ),
        ),
      ),
    );
  }
}

class UserInformationContainer extends StatelessWidget {
  final double value;

  const UserInformationContainer({
    super.key,
    required this.value
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          '\$$value',
          style: TextStyle(
            fontWeight: (FontWeight.bold),
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}

class DashboardButton extends StatelessWidget {
  final String label;
  final double height;
  final double width;
  final VoidCallback onPressed;

  const DashboardButton({
    super.key,
    required this.label,
    required this.height,
    required this.width,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.redAccent,
        padding: EdgeInsets.all(10),
        fixedSize: Size(width, height),
        textStyle: TextStyle(fontWeight: FontWeight.bold),
        side: BorderSide(color: Colors.black, width: 2),
        shape: StadiumBorder(),
      ),
      child: Text(label),
    );
  }
}