import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../Model/diagnosis_model.dart';
import '../Model/search_model.dart';
import '../Model/specialist_model.dart';
import '../../../Model/condition_model.dart' as con;
import '../Model/suggest_reason_model.dart';
import 'api_base_url_helper.dart';

class ApiService {
  final _secureStorage = const FlutterSecureStorage();

  Future<Diagnosis> postDiagnosis(
      String endPoint, List evidence) async {
    http.Response response;
    Map<String, String> header = {
      'App-Id': ApiBase.appId,
      'App-Key': ApiBase.appKey,
      'Content-Type': 'application/json',
      //'Dev-Mode': true,
    };
    var year = await _secureStorage.read(key: 'age');
    var sex = await _secureStorage.read(key: 'sex');
    int age = int.parse(year!);
    Map<String, dynamic> data = {
      'sex': sex,
      'age': {'value': age},
      'evidence': evidence,
      "extras": {
        "disable_groups": true,
        "enable_triage_3": true,
        "interview_mode": "triage",
        "include_condition_details": true
      }
    };
    var body = json.encode(data);
    try {
      var url = Uri.parse(ApiBase.baseUrl + endPoint);
      response = await http.post(url, headers: header, body: body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        //Map<String, dynamic> condition = json.decode(response.body) as Map<String, dynamic>;
        //print(condition['conditions']);
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

  Future<List<Suggest>> suggestReason(
      String endPoint, String id, List evidence) async {
    http.Response response;
    Map<String, String> header = {
      'App-Id': ApiBase.appId,
      'App-Key': ApiBase.appKey,
      'Content-Type': 'application/json'
      //'Dev-Mode': true,
    };
    var age = await _secureStorage.read(key: 'age');
    var sex = await _secureStorage.read(key: 'sex');
    Map<String, dynamic> data = {
      'sex': sex,
      'age': {'value': int.parse(age!)},
      "suggest_method": "symptoms",
      'evidence': evidence,
    };

    var body = json.encode(data);

    try {
      var url = Uri.parse(ApiBase.baseUrl + endPoint);
      response = await http.post(url, headers: header, body: body);
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        //return Suggest.fromJson(json.decode(response.body));
        List data = json.decode(response.body);
        print(data);
        return data.map((e) => Suggest.fromJson(e)).toList();
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

  Future<Specialist> postSpecialist(
      String endPoint, List evidence) async {
    var age = await _secureStorage.read(key: 'age');
    var sex = await _secureStorage.read(key: 'sex');
    http.Response response;
    Map<String, String> header = {
      'App-Id': ApiBase.appId,
      'App-Key': ApiBase.appKey,
      'Content-Type': 'application/json',
      //'Dev-Mode': true,
    };
    print(age);

    try {
      Map<String, dynamic> data = {
        'sex': sex,
        'age': {'value': int.parse(age!)},
        'evidence': evidence,
      };
      var body = json.encode(data);
      var url = Uri.parse(ApiBase.baseUrl + endPoint);
      response = await http.post(url, headers: header, body: body);
      //print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);
        return Specialist.fromJson(json.decode(response.body));
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

  Future<con.Condition> getCondition(
      String endPoint, String id) async {
    http.Response response;
    Map<String, String> header = {
      'App-Id': ApiBase.appId,
      'App-Key': ApiBase.appKey,
      'Accept': 'application/json'
      //'Dev-Mode': true,
    };
    var age = await _secureStorage.read(key: 'age');
    try {
      var url = Uri.parse("${ApiBase.baseUrl}$endPoint/$id?age.value=${int.parse(age!)}");
      response = await http.get(url, headers: header);
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return con.Condition.fromJson(json.decode(response.body));
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
