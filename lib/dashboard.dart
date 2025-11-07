import 'package:flutter/material.dart';
import 'package:flutter_training_template/user_storage_provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<StatefulWidget> createState() {
    return DashboardState();
  }
}

class DashboardState extends State<Dashboard> {

  User signedInUser = User('', '', 0, 1);
  int _debt = 0;
  int _balance = int as int;
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
      if (c > 0) { // Have debt?
        if (b > c) {
          subtract(b, c, a); // payDebtSurplus()
          c = 0;
        } else {
          subtract(c, b, c); // payDebt()
        }
      } else {
        add(a, a, b); // depositToBalance()
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
    _balanceChange < 0 ? error() : computeDeposit(_balance, _balanceChange, _debt);
  }

  void withdraw() {
    _balanceChange = int.tryParse(_balanceChangeTEC.text) ?? 0;
    _balanceChange < 0 ? error() : computeWithdraw(_balance, _balanceChange, _debt);
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