import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fultter_tip_calculator/util/hexcolor.dart';

class BillSplitter extends StatefulWidget {
  const BillSplitter({Key? key}) : super(key: key);

  @override
  State<BillSplitter> createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {
  int _tipPercentage = 0;
  int _personCounter = 1;
  double _billAmount = 0.0;

  //final Color _purple = HexColor("#6908D6");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
      alignment: Alignment.center,
      color: Colors.white,
      child: ListView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(20.5),
        children: <Widget>[
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
                color: Colors.purpleAccent.shade100,
                borderRadius: BorderRadius.circular(12.0)),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Total Per Person",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: Color.fromARGB(255, 84, 9, 97)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                          "\$ ${calculateTotalPerPerson(_billAmount, _personCounter, _tipPercentage)}",
                          style: TextStyle(
                            fontSize: 35,
                            color: Color.fromARGB(255, 104, 15, 120),
                          )),
                    )
                  ]),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                      style: BorderStyle.solid,
                      color: Colors.blueGrey.shade100),
                  borderRadius: BorderRadius.circular(12.0)),
              child: Column(
                children: <Widget>[
                  TextField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(color: Colors.purple),
                    decoration: InputDecoration(
                        prefixText: "Bill amount",
                        prefixIcon: Icon(Icons.attach_money)),
                    onChanged: (String value) {
                      try {
                        _billAmount = double.parse(value);
                      } catch (exception) {
                        _billAmount = 0.0;
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Split",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (_personCounter > 1) {
                                  _personCounter--;
                                } else {
                                  //do nothing
                                }
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.0),
                                  color: Color.fromARGB(255, 214, 175, 221)),
                              child: Center(
                                child: Text("-",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 76, 17, 86),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.0)),
                              ),
                            ),
                          ),
                          Text(
                            "$_personCounter",
                            style: TextStyle(
                                color: Color.fromARGB(255, 76, 17, 86),
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _personCounter++;
                              });
                            },
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.0),
                                  color: Color.fromARGB(255, 214, 175, 221)),
                              child: Center(
                                child: Text("+",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 76, 17, 86),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.0)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  //Tip
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Tip",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          " \$ ${(calculateTotalTip(_billAmount, _personCounter, _tipPercentage)).toStringAsFixed(2)}",
                          style: TextStyle(
                              color: Color.fromARGB(255, 76, 17, 86),
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0),
                        ),
                      )
                    ],
                  ),
                  //slider
                  Column(
                    children: <Widget>[
                      Text(
                        "$_tipPercentage%",
                        style: TextStyle(
                            color: Color.fromARGB(255, 76, 17, 86),
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0),
                      ),
                      Slider(
                          min: 0,
                          max: 100,
                          activeColor: Color.fromARGB(255, 76, 17, 86),
                          inactiveColor: Colors.grey,
                          divisions: 10,
                          value: _tipPercentage.toDouble(),
                          onChanged: (double value) {
                            setState(() {
                              _tipPercentage = value.round();
                            });
                          })
                    ],
                  )
                ],
              ))
        ],
      ),
    ));
  }

  calculateTotalPerPerson(double billAmount, int splitBy, int tipPercentage) {
    var totalPerPerson =
        (calculateTotalTip(billAmount, splitBy, tipPercentage) + billAmount) /
            splitBy;

    return totalPerPerson.toStringAsFixed(2);
  }

  calculateTotalTip(double billamount, int splitBy, int tipPercentage) {
    double totalTip = 0.00;

    if (billamount < 0 || billamount.toString().isEmpty) {
      //no go
    } else {
      totalTip = (billamount * tipPercentage) / 100;
    }

    return totalTip;
    //return totalTip.toStringAsFixed(2);
  }
}
