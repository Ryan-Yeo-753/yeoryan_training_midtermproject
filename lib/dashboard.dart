import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training_template/user_storage_provider.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return DashboardState();
  }
}

class DashboardState extends ConsumerState<Dashboard> {
  late final signedInUser = ref.read(currentUserNotifierProvider);

  late int? balance = signedInUser?.userBalance;
  late int? debt = signedInUser?.userDebt;
  int _balanceChange = 0;
  TextEditingController _balanceChangeTEC = TextEditingController();

  void error() {}

  void add(int a, int b, int c) {
    setState(() {
      c = (a + b);
    });
  }

  void subtract(int a, int b, int c) {
    setState(() {
      c = (a - b);
    });
  }

  void loan(int a, int b, int c) {
    c = (-1 * (a - b));
  }

  void computeDeposit(int a, int b, int c) {
    // a = balance, b = balanceChange, c = debt
    setState(() {
      if (c <= 0) { // No debt?
        add(a, a, b); // depositToBalance()
      }
      if (b > c) {
        subtract(b, c, a); // payDebtSurplus()
        c = 0;
      } else {
        subtract(c, b, c); // payDebt()
      }
    });
  }

  void computeWithdraw(int a, int b, int c) {
    // a = balance, b = balanceChange, c = debt
    setState(() {
      if (b > a) { // Loan?
        if (c > 0) {
          add(c, c, b); // extraLoan()
        } else {
          loan(a, b, c);
          a = 0;
        }
      } else if (b <= a) { // Enough money?
        subtract(a, b, a); // withdrawFromBalance()
      }
    });
  }

  void deposit() {
    _balanceChange = int.tryParse(_balanceChangeTEC.text) ?? 0;
    _balanceChange < 0 ? error() : computeDeposit(balance!, _balanceChange, debt!);
  }

  void withdraw() {
    _balanceChange = int.tryParse(_balanceChangeTEC.text) ?? 0;
    _balanceChange < 0 ? error() : computeWithdraw(balance!, _balanceChange, debt!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                        color: Colors.orangeAccent,
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