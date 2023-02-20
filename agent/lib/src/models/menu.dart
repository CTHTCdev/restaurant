class MenuNow {
  final String id;
  final int code;
  final String name;
  final String lang1;
  final double price;
  final bool active;
  final String colour;

  MenuNow({
    required this.id,
    required this.code,
    required this.name,
    required this.lang1,
    required this.price,
    required this.active,
    required this.colour,
  });

  MenuNow copyWith({
    String? id,
    int? code,
    String? name,
    String? lang1,
    double? price,
    bool? active,
    String? colour,
  }) {
    return MenuNow(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      lang1: lang1 ?? this.lang1,
      price: price ?? this.price,
      active: active ?? this.active,
      colour: colour ?? this.colour,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'lang1': lang1,
      'price': price,
      'active': active,
      'colour': colour,
    };
  }

  factory MenuNow.fromMap(Map<String, dynamic> map) {
    return MenuNow(
      id: map['id'] ?? '',
      code: map['code'] ?? 0,
      name: map['name'] ?? '',
      lang1: map['lang1'] ?? '',
      price: map['price'] ?? 0.00,
      active: map['active'] ?? false,
      colour: map['colour'] ?? '',
    );
  }

  @override
  String toString() {
    return 'MenuNow(id: $id, code: $code, name: $name, lang1: $lang1, price: $price, active: $active, colour: $colour)';
  }
}
