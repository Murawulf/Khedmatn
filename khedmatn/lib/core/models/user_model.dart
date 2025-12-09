class UserModel {
  final String id;
  final String name;
  final String role; // client, worker, admin
  
  UserModel({required this.id, required this.name, required this.role});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'role': role};
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      role: map['role'],
    );
  }
}
