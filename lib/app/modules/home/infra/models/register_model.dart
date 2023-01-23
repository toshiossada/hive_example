// ignore_for_file: public_member_api_docs, sort_constructors_first

class RegisterModel {
  final int id;
  final String name;
  final Map<String, dynamic> fields;

  RegisterModel({
    required this.id,
    required this.name,
    required this.fields,
  });

  factory RegisterModel.fromMap(Map<String, dynamic> map) {
    return RegisterModel(
      id: map['index'] as int,
      name: map['name'] as String,
      fields: {},
    );
  }

  RegisterModel copyWith({
    int? id,
    String? name,
    Map<String, dynamic>? fields,
  }) {
    return RegisterModel(
      id: id ?? this.id,
      name: name ?? this.name,
      fields: fields ?? this.fields,
    );
  }
}
