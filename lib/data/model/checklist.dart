class Checklist {
  int statusCode;
  String message;
  String errorMessage;
  List<Data> data;

  Checklist({
    required this.statusCode,
    required this.message,
    required this.errorMessage,
    required this.data,
  });

  factory Checklist.fromJson(Map<String, dynamic> json) => Checklist(
        statusCode: json["statusCode"],
        message: json["message"],
        errorMessage: json["errorMessage"],
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "errorMessage": errorMessage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Data {
  int id;
  String name;
  List<Item> items;
  bool checklistCompletionStatus;

  Data({
    required this.id,
    required this.name,
    required this.items,
    required this.checklistCompletionStatus,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        checklistCompletionStatus: json["checklistCompletionStatus"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "checklistCompletionStatus": checklistCompletionStatus,
      };
}

class Item {
  int id;
  String name;
  bool itemCompletionStatus;

  Item({
    required this.id,
    required this.name,
    required this.itemCompletionStatus,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        name: json["name"],
        itemCompletionStatus: json["itemCompletionStatus"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "itemCompletionStatus": itemCompletionStatus,
      };
}
