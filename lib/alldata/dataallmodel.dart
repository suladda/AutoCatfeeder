// To parse this JSON data, do
//
//     final dataallModelFromJson = dataallModelFromJsonFromJson(jsonString);

import 'dart:convert';

DataallModelFromJson dataallModelFromJsonFromJson(String str) => DataallModelFromJson.fromJson(json.decode(str));

String dataallModelFromJsonToJson(DataallModelFromJson data) => json.encode(data.toJson());

class DataallModelFromJson {
    DataallModelFromJson({
        this.variableFeederF,
        this.variableServo,
        this.variableUltrasonic,
    });

    VariableFeederF variableFeederF;
    VariableServo variableServo;
    VariableUltrasonic variableUltrasonic;

    factory DataallModelFromJson.fromJson(Map<String, dynamic> json) => DataallModelFromJson(
        variableFeederF: VariableFeederF.fromJson(json["Variable FeederF"]),
        variableServo: VariableServo.fromJson(json["Variable Servo"]),
        variableUltrasonic: VariableUltrasonic.fromJson(json["Variable Ultrasonic"]),
    );

    Map<String, dynamic> toJson() => {
        "Variable FeederF": variableFeederF.toJson(),
        "Variable Servo": variableServo.toJson(),
        "Variable Ultrasonic": variableUltrasonic.toJson(),
    };
}

class VariableFeederF {
    VariableFeederF({
        this.value,
    });

    String value;

    factory VariableFeederF.fromJson(Map<String, dynamic> json) => VariableFeederF(
        value: json["Value"],
    );

    Map<String, dynamic> toJson() => {
        "Value": value,
    };
}

class VariableServo {
    VariableServo({
        this.valueS,
    });

    int valueS;

    factory VariableServo.fromJson(Map<String, dynamic> json) => VariableServo(
        valueS: json["ValueS"],
    );

    Map<String, dynamic> toJson() => {
        "ValueS": valueS,
    };
}

class VariableUltrasonic {
    VariableUltrasonic({
        this.cm,
    });

    int cm;

    factory VariableUltrasonic.fromJson(Map<String, dynamic> json) => VariableUltrasonic(
        cm: json[" CM "],
    );

    Map<String, dynamic> toJson() => {
        " CM ": cm,
    };
}
