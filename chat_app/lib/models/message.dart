class Message {
  final String id;
  final String content;
  final String sender;
  final DateTime timestamp;
  final bool isMe;

  Message({
    required this.id,
    required this.content,
    required this.sender,
    required this.timestamp,
    required this.isMe,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'sender': sender,
      'timestamp': timestamp.toIso8601String(),
      'isMe': isMe,
    };
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      content: json['content'],
      sender: json['sender'],
      timestamp: DateTime.parse(json['timestamp']),
      isMe: json['isMe'],
    );
  }
}