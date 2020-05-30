import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _totPerPerson = 0.0;
  var _billAmount = 10.0;
  var _personCount = 1;
  var _tipPercentage = 0.0;
  var _sliderValue = 10.0;

  @override
  Widget build(BuildContext context) {

    

    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Container(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1,left: 20.0,right:20),
                alignment: Alignment.center,
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(10.0)
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Balance Per Person",
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10.0)),
                      Text(
                        "$_totPerPerson ₹",
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.white
                        ),
                      )
                    ],
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.05,left: 20.0,right:20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all()
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.attach_money),
                          prefixText: "Bill Amount ",
                        ),
                        onChanged: (var val) {
                          setState(() {
                            _billAmount = double.parse(val);

                            _totPerPerson = calculateBillPerPerson();
                          });
                        },
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[

                          Container(
                            padding: EdgeInsets.only(left:5.0),
                            child:Text(
                              "Split Between :",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),

                          Row(
                            children: <Widget>[
                              InkWell(
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color:Colors.blue[200],
                                    borderRadius: BorderRadius.circular(10.0)
                                  ),
                                  child: Center(
                                    child: Text(
                                      "-",
                                      style: TextStyle(
                                        fontSize: 30,
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    if(_personCount>1) {
                                      _personCount--;
                                      _totPerPerson = calculateBillPerPerson();
                                    }
                                    else {
                                      //Do Nothing
                                    }
                                  });
                                },
                              ),

                              Padding(padding: EdgeInsets.all(5)),

                              Text(
                                "$_personCount"
                              ),

                              Padding(padding: EdgeInsets.all(5)),

                              InkWell(
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color:Colors.blue[200],
                                    borderRadius: BorderRadius.circular(10.0)
                                  ),
                                  child: Center(
                                    child: Text(
                                      "+",
                                      style: TextStyle(
                                        fontSize: 25,
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    _personCount++;
                                    _totPerPerson = calculateBillPerPerson();
                                  });
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child:Text(
                              "Tip : ${_sliderValue.toInt()} %",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold
                              ),
                            )
                          ),

                          Slider(
                            min: 0,
                            max: 100,
                            divisions: 20,
                            activeColor: Colors.blue,
                            value: _sliderValue,
                            onChanged: (double value){
                              setState(() {
                                _sliderValue = value;
                                _totPerPerson = calculateBillPerPerson();
                              });
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ),
    );
  }

  double calculateBillPerPerson() {
    var totalPrice = _billAmount + _sliderValue*_billAmount/100;

    print(totalPrice);

    return (totalPrice/_personCount).round().toDouble();
  }
}
