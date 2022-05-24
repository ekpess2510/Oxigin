import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../Model/diagnosis_model.dart';
import '../Model/search_model.dart';
import 'api_base_url_helper.dart';

class ApiService {
  Future<Diagnosis> postDiagnosis(
      String endPoint, String sex, int age, List evidence) async {
    http.Response response;
    Map<String, String> header = {
      'App-Id': ApiBase.appId,
      'App-Key': ApiBase.appKey,
      'Content-Type': 'application/json',
      //'Dev-Mode': true,
    };
    Map<String, dynamic> data = {
      'sex': sex,
      'age': {'value': age},
      'evidence': evidence
    };
    var body = json.encode(data);
    print(body);
    try {
      var url = Uri.parse(ApiBase.baseUrl + endPoint);
      response = await http.post(url, headers: header, body: body);
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);
        return Diagnosis.fromJson(json.decode(response.body));
      } else if (response.statusCode == 401) {
        throw http.ClientException('Unauthorized');
      } else if (response.statusCode == 500) {
        throw http.ClientException('Server error');
      } else {
        throw Exception('Oh darn! Something went wrong');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<SearchModel>> get(String endPoint) async {
    http.Response response;
    Map<String, String> header = {
      'App-Id': ApiBase.appId,
      'App-Key': ApiBase.appKey,
      'Accept': 'application/json',
      //'Dev-Mode': true,
    };
    try {
      var url = Uri.parse(ApiBase.baseUrl + endPoint);
      response = await http.get(url, headers: header);
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final List results = json.decode(response.body);
        print(results);
        return results.map(((e) => SearchModel.fromJson(e))).toList();
      } else if (response.statusCode == 401) {
        throw http.ClientException('Unauthorized');
      } else if (response.statusCode == 500) {
        throw http.ClientException('Server error');
      } else {
        throw Exception('Oh darn! Something went wrong');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}

final apiProvider = Provider<ApiService>((ref) => ApiService());
