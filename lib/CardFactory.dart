import 'package:flutter/material.dart';
import 'package:vin_clipper/Car.dart';

class CardFactory {
  static Container createCarCard() {
    final carThumbnail = new Container(
      margin: new EdgeInsets.symmetric(vertical: 16.0),
      alignment: FractionalOffset.centerLeft,
      child: new Image(
          image: new AssetImage("assets/images/unidentified-car.png"),
          height: 92.0,
          width: 92.0),
    );

    var car = new Car();
    car.make = "Toyota";
    car.model = "Camry";
    car.year = 2017;

    final baseTextStyle = const TextStyle(fontFamily: 'Poppins');

    final headerTextStyle =
        baseTextStyle.copyWith(fontSize: 18.0, fontWeight: FontWeight.w600);

    final regularTextStyle = baseTextStyle.copyWith(
        color: const Color(0xffb6b2df),
        fontSize: 9.0,
        fontWeight: FontWeight.w400);

    final subHeaderTextStyle = regularTextStyle.copyWith(fontSize: 12.0);

    final carCardContent = new Container(
      height: 124.0,
      margin: new EdgeInsets.fromLTRB(76.0, 16.0, 16.0, 16.0),
      decoration: new BoxDecoration(
        color: new Color(0xFF333366),
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0),
          ),
        ],
      ),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Container(height: 4.0),
          new Text(
            car.make,
            style: headerTextStyle,
          ),
          new Container(height: 10.0),
          new Text(car.model, style: subHeaderTextStyle),
          new Container(
              margin: new EdgeInsets.symmetric(vertical: 8.0),
              height: 2.0,
              width: 18.0,
              color: new Color(0xff00c6ff)),
          new Row(
            children: <Widget>[
              new Image.asset("assets/images/speedometer.png", height: 12.0),
              new Container(width: 8.0),
              new Text(
                car.year.toString(),
                style: regularTextStyle,
              ),
              new Container(width: 24.0),
              new Image.asset("assets/images/speedometer.png", height: 12.0),
              new Container(width: 8.0),
              new Text(
                car.year.toString(),
                style: regularTextStyle,
              ),
            ],
          ),
        ],
      ),
    );

    return Container(
        margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: new Stack(children: <Widget>[carCardContent, carThumbnail]));
  }
}
