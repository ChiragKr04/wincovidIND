class ResourceScript {
  final String timeStamp;
  final String name;
  final String mobile;
  final String email;
  final String items;
  final String quantity;
  final String description;
  final String address;
  final String district;

  ResourceScript(
    this.timeStamp,
    this.name,
    this.mobile,
    this.email,
    this.items,
    this.quantity,
    this.description,
    this.address,
    this.district,
  );

  factory ResourceScript.fromJson(dynamic json) {
    return ResourceScript(
      "${json['time']}",
      "${json['name']}",
      "${json['mobile']}",
      "${json['email']}",
      "${json['items']}",
      "${json['quantity']}",
      "${json['description']}",
      "${json['address']}",
      "${json['district']}",
    );
  }

  @override
  String toString() {
    return "${this.items}";
  }

  // Method to make GET parameters.
  Map toJson() => {
        'time': timeStamp,
        'name': name,
        'mobile': mobile,
        'email': email,
        'items': items,
        'quantity': quantity,
        'description': description,
        'address': address,
        'district': district,
      };
}
