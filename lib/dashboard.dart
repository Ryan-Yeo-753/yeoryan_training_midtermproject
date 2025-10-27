import 'package:flutter/material.dart';

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

  void error() {}

  void payDebtSurplus(int a, int b) {
    setState(() {
      _balance = (a - b);
    });
  }

  void payDebt(int a, int b) {
    setState(() {
      _debt = (a + b);
    });
  }

  void extraLoan (int a, int b) {
    setState(() {
      _debt = (a + b);
    });
  }

  void computeDeposit(int a, int b) {
    setState(() {
      if (_debt > 0) {
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

  void computeWithdraw(int a, int b, int c) {
    setState(() {
      if (b > a) {
        if (c > 0) {
          extraLoan(c, b);
        } else {
          _debt = (-1 * (a - b));
          _balance = 0;
        }
      } else if (b <= a) {
        _balance = (a - b);
      }
    });
  }

  void deposit() {
    _balanceChange = int.tryParse(_balanceChangeTEC.text) ?? 0;
    _balanceChange < 0 ? error() : computeDeposit(_balance, _balanceChange);
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