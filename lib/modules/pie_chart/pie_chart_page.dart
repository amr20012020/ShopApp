import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/commentCounter.dart';
import 'package:shop_app/modules/admin/adminHome.dart';
import 'package:shop_app/modules/register/home.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Pie_chart_Page extends StatefulWidget {
  Pie_chart_Page({Key? key, required this.ProductId, required this.positiveCount, required this.negativeCount, required this.counter, required this.Email, required this.Name}) : super(key: key);
  final String Email;
  final String Name;
  final String ProductId;
  int positiveCount;
  int negativeCount;
 // int mixedCount;
  double counter;

  @override
  _Pie_chart_PageState createState() => _Pie_chart_PageState(ProductId: ProductId, positiveCount: positiveCount, negativeCount: negativeCount, counter: counter, Email: Email, Name: Name);
}



class _Pie_chart_PageState extends State<Pie_chart_Page> {
  late List<GDPData> _chartData;
  late TooltipBehavior _tooltipBehavior;
  final String ProductId;
  final String Email;
  final String Name;
  _Pie_chart_PageState({required this.ProductId, required this.positiveCount, required this.negativeCount, required this.counter, required this.Email, required this.Name});

  final counterRef = FirebaseFirestore.instance.collection('counters');


  @override
  void initState() {
    //getCounter();
    _tooltipBehavior = TooltipBehavior(enable: true);
    //print(ProductId);
    //print(negativeCount);
    super.initState();
  }


  //final commentCount = comments.length;
 /* int positiveCount = 0;
  int negativeCount = 0;
  int mixedCount = 0; */

  double counter;

  late commentCounter count;

  double productCount = 0;

  int positiveCount;
  int negativeCount;
 // int mixedCount;


 /* getCounter() async{
    print("Hello");
    final DocumentSnapshot doc =  await counterRef.doc(ProductId).get();
   // count = commentCounter(doc.get("positiveCount"),doc.get("negativeCount"), doc.get("commentsCount"), doc.get("mixedCount"));
    positiveCount = doc.get("positiveCount");
    negativeCount = doc.get("negativeCount");
    mixedCount = doc.get("mixedCount");
   var C = [positiveCount, negativeCount, mixedCount].reduce(max);
    counter = C + productCount;
    print(counter);
    //print(doc);
    print("well");
    print(positiveCount);
   // print(negativeCount);
    //print(doc.get("mixedCount"));
    _chartData = getChartData();
  } */

  getCount() async{
    final DocumentSnapshot doc =  await counterRef.doc(ProductId).get();
    print(doc.get("positiveCount"));
    positiveCount = doc.get("positiveCount");
    negativeCount = doc.get("negativeCount");
   // mixedCount = doc.get("mixedCount");

    //final QuerySnapshot snapshot =  await counterRef.doc.get();
  }





  @override
  Widget build(BuildContext context) {
    //getCounter();
   // count = commentCounter(2, 3, 4, 5);
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("Chart Page", style: TextStyle(color: Colors.black)),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (ctx) => AdminHome(ProductId: ProductId, EmailAdmin: Email, /*NameAdmin: Name,*/),
                      //Home(title: '', UserName: '', UserImage: '',),
                    ),
                  );
                },
              ),
            ),
            body: SfCircularChart(
              title:
              ChartTitle(text: 'Sentimental Analysis For Product'),
              legend:
              Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
              tooltipBehavior: _tooltipBehavior,
              series: <CircularSeries>[
                RadialBarSeries<GDPData, String>(
                    dataSource: getChartData(),
                    xValueMapper: (GDPData data, _) => data.continent,
                    yValueMapper: (GDPData data, _) => data.gdp,
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                    enableTooltip: true,
                    maximumValue: counter as double)
              ],
            )));
  }

  List<GDPData> getChartData() {
    //getCount();
    final List<GDPData> chartData = [
      GDPData('Positive Comments', positiveCount),
      GDPData('Negative Comments', negativeCount),
     // GDPData('Draw Comments', mixedCount),
    ];
    return chartData;
  }
}

class GDPData {
  GDPData(this.continent, this.gdp);
  final String continent;
  final int gdp;
}