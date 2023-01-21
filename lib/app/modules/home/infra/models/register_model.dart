// ignore_for_file: public_member_api_docs, sort_constructors_first

class RegisterModel {
  final int id;
  final String name;

  RegisterModel({
    required this.id,
    required this.name,
  });

  factory RegisterModel.fromMap(Map<String, dynamic> map) {
    return RegisterModel(
      id: map['index'] as int,
      name: map['name'] as String,
    );
  }

  RegisterModel copyWith({
    int? id,
    String? name,
  }) {
    return RegisterModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
