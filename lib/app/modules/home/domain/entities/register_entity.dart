class RegisterEntity {
  final int id;
  final String name;
  final Map<String, dynamic> fields;

  RegisterEntity({
    required this.id,
    required this.name,
    required this.fields,
  });

  RegisterEntity copyWith({
    int? id,
    String? name,
    Map<String, dynamic>? fields,
  }) {
    return RegisterEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      fields: fields ?? this.fields,
    );
  }
}
