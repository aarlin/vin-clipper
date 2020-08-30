import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:vin_clipper/Makes.dart';
import 'package:vin_clipper/Models.dart';
import 'package:vin_clipper/VinInfo.dart';

import 'package:http/http.dart' as http;

class ApiController {
  //Makes

  static Future<Makes> fetchMakes(http.Client client) async {
    final response = await client.get(
        'https://vpic.nhtsa.dot.gov/api/vehicles/GetMakesForVehicleType/car?format=json');

    // Use the compute function to run parsePhotos in a separate isolate.
    return compute(parseMakes, response.body);
  }

// A function that converts a response body into a List<Photo>.
  static Makes parseMakes(String responseBody) {
    final parsed = jsonDecode(responseBody);

    return Makes.fromJson(parsed);
  }

//Models

  Future<Models> fetchModels(http.Client client, String make) async {
    final response = await client.get(
        'https://vpic.nhtsa.dot.gov/api/vehicles/GetModelsForMake/' +
            make +
            '?format=json');

    // Use the compute function to run parsePhotos in a separate isolate.
    return compute(parseModels, response.body);
  }

// A function that converts a response body into a List<Photo>.

  Models parseModels(String responseBody) {
    final parsed = jsonDecode(responseBody);

    return Models.fromJson(parsed);
  }

//Models

  static Future<VinInfo> fetchVinInfo(http.Client client, String vin) async {
    final response = await client.get(
        'https://vpic.nhtsa.dot.gov/api/vehicles/decodevinvaluesextended/' +
            vin +
            '?format=json');

    // Use the compute function to run parsePhotos in a separate isolate.
    print(response.body);
    return compute(parseVinInfo, response.body);
  }

// A function that converts a response body into a List<Photo>.

  static VinInfo parseVinInfo(String responseBody) {
    final parsed = jsonDecode(responseBody);

    return VinInfo.fromJson(parsed);
  }
}
