import 'message.dart';

class ChatRoom {
  final String id;
  final String name;
  final String description;
  final List<String> participants;
  final DateTime createdAt;
  final String? lastMessage;
  final DateTime? lastMessageTime;

  ChatRoom({
    required this.id,
    required this.name,
    required this.description,
    required this.participants,
    required this.createdAt,
    this.lastMessage,
    this.lastMessageTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'participants': participants,
      'createdAt': createdAt.toIso8601String(),
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime?.toIso8601String(),
    };
  }

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      participants: List<String>.from(json['participants']),
      createdAt: DateTime.parse(json['createdAt']),
      lastMessage: json['lastMessage'],
      lastMessageTime: json['lastMessageTime'] != null 
          ? DateTime.parse(json['lastMessageTime']) 
          : null,
    );
  }

  ChatRoom copyWith({
    String? lastMessage,
    DateTime? lastMessageTime,
  }) {
    return ChatRoom(
      id: id,
      name: name,
      description: description,
      participants: participants,
      createdAt: createdAt,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
    );
  }
}