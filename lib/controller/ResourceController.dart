import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/ResourceScript.dart';

class ResourceController {
  static const String GETURL =
      "https://script.google.com/macros/s/AKfycbzhHbpfJz6MbMZE5R9cqKgNgkUOull7vXbBtJr-7Eto8pITX2SVoMj1mORkrW0ImLQg/exec";
  static const String POSTURL =
      "https://script.google.com/macros/s/AKfycbx_AJJzdcqqReEpOpde0SwHblN_jQx9dBTUwDod4dct7XwLvb1iB9cr17emGgLeku8H/exec";

  static const STATUS_SUCCESS = "SUCCESS";

  void submitForm(Map resourceForm, void Function(String) callback) async {
    try {
      await http.post(POSTURL, body: resourceForm).then((response) async {
        if (response.statusCode == 302) {
          var url = response.headers['location'];
          await http.get(url).then((response) {
            callback(jsonDecode(response.body)['status']);
          });
        } else {
          callback(jsonDecode(response.body)['status']);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Future<List<ResourceScript>> getFeedbackList() async {
    return await http.get(GETURL).then((response) {
      var jsonFeedback = jsonDecode(response.body) as List;
      return jsonFeedback.map((json) => ResourceScript.fromJson(json)).toList();
    });
  }
}
