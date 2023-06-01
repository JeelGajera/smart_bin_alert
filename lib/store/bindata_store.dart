import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';
import 'package:smartbin_alert/models/bin_model.dart';

class BinDataStore {
  @observable
  ObservableList<BinModel> bins = ObservableList<BinModel>();

  @observable
  bool isLoading = false;

  @observable
  bool isError = false;

  @observable
  String errorMessage = "";

  @action
  Future<void> getBinsData() async {
    try {
      // get data from json file
      final String jsonString = await rootBundle.loadString('assets/bins.json');
      final List<dynamic> jsonData = jsonDecode(jsonString);

      bins.clear();
      for (var item in jsonData) {
        bins.add(BinModel.fromJson(item));
      }
      isLoading = false;
    } catch (e) {
      isLoading = false;
      isError = true;
      errorMessage = e.toString();
    }
  }
}
