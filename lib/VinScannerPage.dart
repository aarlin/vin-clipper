import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vin_clipper/VinInfo.dart';
import 'Makes.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:vin_clipper/VinList.dart';
import 'package:vin_clipper/CardFactory.dart';
import 'package:vin_clipper/ApiController.dart';

enum TabItem { history, scan, settings }

class VinScannerPage extends StatefulWidget {
  VinScannerPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _VinScannerPageState createState() => _VinScannerPageState();
}

class _VinScannerPageState extends State<VinScannerPage> {
  final TextEditingController _pinPutController = TextEditingController();

  List<String> makeStrings = List<String>();
  List<String> modelStrings = List<String>();
  String makeTitle = "Choose Make";
  String modelTitle = "Choose Model";
  String barcode = "";
  ScanResult scanResult;

  Future<void> getVinInfo(String vinText) {
    ApiController.fetchVinInfo(http.Client(), vinText).then((VinInfo vinInfo) {
      List<VinResults> vinResults = vinInfo.results;

//                   for(var vinResult in vinResults  ){
//                    this.makeTitle = vinResult.make;
//                    this.modelTitle = vinResult.model;
//                   }
      //example vin : 3LN6L2JKXFR605807
      print("vin results length is ${vinResults.length}");
      setState(() {
        if (vinResults.length > 0) {
          VinResults result = vinResults[0];
          print(result);
          this.makeTitle = result.make;
          this.modelTitle = result.model;
          print("this make is $makeTitle. this model is $modelTitle");
          this.modelStrings.add(this.modelTitle);
        }
      });
    });
    return null;
  }

  Center createVinScannerBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(onPressed: scan, child: new Text("Scan")),
          // onlySelectedBorderPinPut(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _pinPutController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(hintText: "Enter a vin"),
              textCapitalization: TextCapitalization.characters,
              textAlign: TextAlign.center,
            ),
          ),
          RaisedButton(
            child: Text("Get Vin Info"),
            onPressed: () {
              var vinText = _pinPutController.text;
              if (vinText.isNotEmpty) {
                getVinInfo(vinText);
              }
            },
          ),
          RaisedButton(child: Text("Copy"), onPressed: () {}),
          Divider(
            height: 3.0,
          ),
          CardFactory.createCarCard()
        ],
      ),
    );
  }

  Future scan() async {
    try {
      scanResult = await BarcodeScanner.scan();
      barcode = scanResult.rawContent;
      setState(() => this.barcode = barcode);
      print("barcode is $barcode");
      if (barcode?.isNotEmpty ?? false) {
        getVinInfo(barcode);
      }
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ApiController.fetchMakes(http.Client()).then((value) {
      setState(() {
        List<Results> results = value.results;
        for (var i in results) {
          print("make is ${i.makeName}");
          makeStrings.add(i.makeName);
        }
        makeStrings.sort();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: createVinScannerBody(),
    );
  }
}

class CameraAccessDenied {}
