import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'machine.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class MachineHomePage extends StatefulWidget {
  @override
  _MachineHomePageState createState() {
    return _MachineHomePageState();
  }
}

class _MachineHomePageState extends State<MachineHomePage> {
  List<charts.Series<Machine, String>> _seriesBarData;
  List<Machine> mydata;
  _generateData(mydata) {
    _seriesBarData = List<charts.Series<Machine, String>>();
    _seriesBarData.add(
      charts.Series(
        domainFn: (Machine machine, _) => machine.id.toString(),
        measureFn: (Machine machine, _) => machine.injectTime,
        colorFn: (Machine machine, _) =>
            charts.ColorUtil.fromDartColor(Color(int.parse(machine.colorVal))),
        id: 'DJ001',
        data: mydata,
        labelAccessorFn: (Machine row, _) => "${row.id}",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Machine-data')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('machine-data').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        } else {
          List<Machine> machine = snapshot.data.docs
              .map((documentSnapshot) =>
                  Machine.fromMap(documentSnapshot.data()))
              .toList();
          return _buildChart(context, machine);
        }
      },
    );
  }

  Widget _buildChart(BuildContext context, List<Machine> machine) {
    mydata = machine;
    _generateData(mydata);
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                'Machine by Injection time',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: charts.BarChart(
                  _seriesBarData,
                  animate: true,
                  animationDuration: Duration(seconds: 4),
                  behaviors: [
                    new charts.DatumLegend(
                      entryTextStyle: charts.TextStyleSpec(
                          color: charts.MaterialPalette.purple.shadeDefault,
                          fontFamily: 'Georgia',
                          fontSize: 18),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
