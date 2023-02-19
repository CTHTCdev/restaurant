import 'dart:convert';

class CategoryNow {
  final String id;
  final String name;
  final String lang1;
  final bool active;
  final String type;

  CategoryNow({
    required this.id,
    required this.name,
    required this.lang1,
    required this.active,
    required this.type,
  });

  CategoryNow copyWith({
    String? id,
    String? name,
    String? lang1,
    bool? active,
    String? type,
  }) {
    return CategoryNow(
      id: id ?? this.id,
      name: name ?? this.name,
      lang1: lang1 ?? this.lang1,
      active: active ?? this.active,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'lang1': lang1,
      'active': active,
      'type': type,
    };
  }

  factory CategoryNow.fromMap(Map<String, dynamic> map) {
    return CategoryNow(
      id: map['id'] ?? '',
      name: map['category_name'] ?? '',
      lang1: map['category_lang1'] ?? '',
      active: map['category_active'] ?? false,
      type: map['category_type'] ?? '',
    );
  }

  @override
  String toString() {
    return 'CategoryNow(id: $id, name: $name, lang1: $lang1, active: $active, type: $type)';
  }
}
