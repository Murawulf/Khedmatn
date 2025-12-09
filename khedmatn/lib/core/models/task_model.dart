class TaskModel {
  final String id;
  final String title;
  final String description;
  final double price;
  final double lat;
  final double lng;
  final String status; // pending, assigned, completed
  final String? workerId;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.lat,
    required this.lng,
    this.status = 'pending',
    this.workerId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'lat': lat,
      'lng': lng,
      'status': status,
      'workerId': workerId,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      price: map['price']?.toDouble() ?? 0.0,
      lat: map['lat']?.toDouble() ?? 0.0,
      lng: map['lng']?.toDouble() ?? 0.0,
      status: map['status'] ?? 'pending',
      workerId: map['workerId'],
    );
  }
}
