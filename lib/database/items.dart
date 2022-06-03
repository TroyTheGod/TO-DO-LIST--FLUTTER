class Items {
  int id;
  final String itemName;
  bool status;
  late int statusInInt;

  Items(this.id, this.itemName, [this.status = true]) {
    statusInInt = status ? 1 : 0;
    print('local items: ${id}, ${itemName}, ${status}, ${statusInInt}');
  }
  String getItemName() {
    return itemName;
  }

  factory Items.fromMap(Map<String, dynamic> json) => new Items(
        json['id'],
        json['itemName'],
      );
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'itemName': itemName,
      'statusInInt': statusInInt,
    };
  }
}
