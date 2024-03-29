// To parse this JSON data, do
//
//     final diagnosis = diagnosisFromJson(jsonString);

import 'dart:convert';

Diagnosis diagnosisFromJson(String str) => Diagnosis.fromJson(json.decode(str));

String diagnosisToJson(Diagnosis data) => json.encode(data.toJson());

class Diagnosis {
  Diagnosis(
      {required this.question,
      required this.conditions,
      required this.extras,
      required this.hasEmergencyEvidence,
      required this.interviewToken,
      required this.shouldStop});

  Question? question;
  List<Condition> conditions;
  Extras extras;
  bool hasEmergencyEvidence;
  String interviewToken;
  bool shouldStop;

  factory Diagnosis.fromJson(Map<String, dynamic> json) => Diagnosis(
        question: json["question"] == null
            ? null
            : Question.fromJson(json["question"]),
        conditions: List<Condition>.from(
            json["conditions"].map((x) => Condition.fromJson(x))),
        extras: Extras.fromJson(json["extras"]),
        hasEmergencyEvidence: json["has_emergency_evidence"],
        shouldStop: json["should_stop"],
        interviewToken: json["interview_token"],
      );

  Map<String, dynamic> toJson() => {
        "question": question!.toJson(),
        "conditions": List<dynamic>.from(conditions.map((x) => x.toJson())),
        "extras": extras.toJson(),
        "has_emergency_evidence": hasEmergencyEvidence,
        "interview_token": interviewToken,
      };
}

class Condition {
  Condition({
    required this.id,
    required this.name,
    required this.commonName,
    required this.probability,
    required this.conditionDetails,
  });

  String id;
  String name;
  String commonName;
  double probability;
  final ConditionDetails? conditionDetails;

  factory Condition.fromJson(Map<String, dynamic> json) => Condition(
        id: json["id"],
        name: json["name"],
        commonName: json["common_name"],
        probability: json["probability"].toDouble(),
        conditionDetails: json["condition_details"] == null
            ? null
            : ConditionDetails.fromJson(json["condition_details"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "common_name": commonName,
        "probability": probability,
        "condition_details": conditionDetails?.toJson(),
      };
}

class ConditionDetails {
  ConditionDetails({
    required this.icd10Code,
    required this.category,
    required this.prevalence,
    required this.severity,
    required this.acuteness,
    required this.triageLevel,
    required this.hint,
    required this.hasPatientEducation,
  });

  final String icd10Code;
  final Category? category;
  final String prevalence;
  final String severity;
  final String acuteness;
  final String triageLevel;
  final String hint;
  final bool hasPatientEducation;

  factory ConditionDetails.fromJson(Map<String, dynamic> json) {
    return ConditionDetails(
      icd10Code: json["icd10_code"] ?? "",
      category:
          json["category"] == null ? null : Category.fromJson(json["category"]),
      prevalence: json["prevalence"] ?? "",
      severity: json["severity"] ?? "",
      acuteness: json["acuteness"] ?? "",
      triageLevel: json["triage_level"] ?? "",
      hint: json["hint"] ?? "",
      hasPatientEducation: json["has_patient_education"] ?? false,
    );
  }

  @override
  String toString() {
    return '$icd10Code, $category, $prevalence, $severity, $acuteness, $triageLevel, $hint, $hasPatientEducation';
  }

  Map<String, dynamic> toJson() => {
        "icd10_code": icd10Code,
        "category": category?.toJson(),
        "prevalence": prevalence,
        "severity": severity,
        "acuteness": acuteness,
        "triage_level": triageLevel,
        "hint": hint,
        "has_patient_education": hasPatientEducation,
      };
}

class Category {
  Category({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
    );
  }

  @override
  String toString() {
    return '$id, $name';
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Extras {
  Extras();

  factory Extras.fromJson(Map<String, dynamic> json) => Extras();

  Map<String, dynamic> toJson() => {};
}

class Question {
  Question({
    required this.type,
    required this.text,
    required this.items,
    required this.extras,
  });

  String type;
  String text;
  List<Item> items;
  Extras extras;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        type: json["type"],
        text: json["text"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        extras: Extras.fromJson(json["extras"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "text": text,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "extras": extras.toJson(),
      };
}

class Item {
  Item({
    required this.id,
    required this.name,
    required this.choices,
  });

  String id;
  String name;
  final List<Choice>? choices;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        name: json["name"],
        choices: json['choices'] == null
            ? []
            : List<Choice>.from(
                json["choices"].map((x) => Choice.fromJson(x)).toList()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "choices": List<dynamic>.from(choices!.map((x) => x.toJson())),
      };
}

class Choice {
  Choice({
    required this.id,
    required this.label,
  });

  String id;
  String label;

  factory Choice.fromJson(Map<String, dynamic> json) => Choice(
        id: json["id"],
        label: json["label"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "label": label,
      };
}
