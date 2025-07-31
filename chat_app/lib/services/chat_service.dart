import 'dart:convert';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/message.dart';
import '../models/chat_room.dart';

class ChatService {
  static final ChatService _instance = ChatService._internal();
  factory ChatService() => _instance;
  ChatService._internal();

  static const String _chatRoomsKey = 'chat_rooms';
  static const String _messagesKey = 'messages_';
  static const String _currentUserKey = 'current_user';

  String _currentUser = 'Ben';
  String get currentUser => _currentUser;

  Future<void> setCurrentUser(String username) async {
    _currentUser = username;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_currentUserKey, username);
  }

  Future<void> loadCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    _currentUser = prefs.getString(_currentUserKey) ?? 'Ben';
  }

  Future<List<ChatRoom>> getChatRooms() async {
    final prefs = await SharedPreferences.getInstance();
    final String? chatRoomsJson = prefs.getString(_chatRoomsKey);
    
    if (chatRoomsJson == null) {
      // İlk çalıştırmada örnek sohbet odaları oluştur
      return await _createInitialChatRooms();
    }
    
    final List<dynamic> chatRoomsList = json.decode(chatRoomsJson);
    return chatRoomsList.map((json) => ChatRoom.fromJson(json)).toList();
  }

  Future<List<ChatRoom>> _createInitialChatRooms() async {
    final List<ChatRoom> initialRooms = [
      ChatRoom(
        id: _generateId(),
        name: 'Genel Sohbet',
        description: 'Herkesle sohbet edebileceğiniz genel alan',
        participants: ['Ben', 'Ahmet', 'Ayşe', 'Mehmet'],
        createdAt: DateTime.now().subtract(Duration(days: 2)),
        lastMessage: 'Merhaba, nasılsınız?',
        lastMessageTime: DateTime.now().subtract(Duration(minutes: 30)),
      ),
      ChatRoom(
        id: _generateId(),
        name: 'Teknoloji',
        description: 'Teknoloji konularını konuşalım',
        participants: ['Ben', 'Ali', 'Fatma'],
        createdAt: DateTime.now().subtract(Duration(days: 1)),
        lastMessage: 'Yeni Flutter sürümü harika!',
        lastMessageTime: DateTime.now().subtract(Duration(hours: 2)),
      ),
      ChatRoom(
        id: _generateId(),
        name: 'Spor',
        description: 'Spor haberlerini takip edelim',
        participants: ['Ben', 'Okan', 'Zeynep'],
        createdAt: DateTime.now().subtract(Duration(hours: 12)),
        lastMessage: 'Maç ne zaman?',
        lastMessageTime: DateTime.now().subtract(Duration(hours: 4)),
      ),
    ];

    await _saveChatRooms(initialRooms);
    
    // Her oda için örnek mesajlar oluştur
    for (final room in initialRooms) {
      await _createInitialMessages(room.id);
    }
    
    return initialRooms;
  }

  Future<void> _createInitialMessages(String roomId) async {
    final List<Message> messages = [
      Message(
        id: _generateId(),
        content: 'Merhaba herkese!',
        sender: 'Ahmet',
        timestamp: DateTime.now().subtract(Duration(hours: 3)),
        isMe: false,
      ),
      Message(
        id: _generateId(),
        content: 'Selam! Nasılsınız?',
        sender: _currentUser,
        timestamp: DateTime.now().subtract(Duration(hours: 2, minutes: 30)),
        isMe: true,
      ),
      Message(
        id: _generateId(),
        content: 'İyiyiz, sen nasılsın?',
        sender: 'Ayşe',
        timestamp: DateTime.now().subtract(Duration(hours: 2)),
        isMe: false,
      ),
    ];

    await _saveMessages(roomId, messages);
  }

  Future<void> _saveChatRooms(List<ChatRoom> chatRooms) async {
    final prefs = await SharedPreferences.getInstance();
    final String chatRoomsJson = json.encode(
      chatRooms.map((room) => room.toJson()).toList(),
    );
    await prefs.setString(_chatRoomsKey, chatRoomsJson);
  }

  Future<List<Message>> getMessages(String roomId) async {
    final prefs = await SharedPreferences.getInstance();
    final String? messagesJson = prefs.getString('$_messagesKey$roomId');
    
    if (messagesJson == null) {
      return [];
    }
    
    final List<dynamic> messagesList = json.decode(messagesJson);
    return messagesList.map((json) => Message.fromJson(json)).toList();
  }

  Future<void> _saveMessages(String roomId, List<Message> messages) async {
    final prefs = await SharedPreferences.getInstance();
    final String messagesJson = json.encode(
      messages.map((message) => message.toJson()).toList(),
    );
    await prefs.setString('$_messagesKey$roomId', messagesJson);
  }

  Future<void> sendMessage(String roomId, String content) async {
    final messages = await getMessages(roomId);
    final newMessage = Message(
      id: _generateId(),
      content: content,
      sender: _currentUser,
      timestamp: DateTime.now(),
      isMe: true,
    );
    
    messages.add(newMessage);
    await _saveMessages(roomId, messages);
    
    // Son mesajı sohbet odasında güncelle
    await _updateLastMessage(roomId, content, DateTime.now());
  }

  Future<void> _updateLastMessage(String roomId, String lastMessage, DateTime timestamp) async {
    final chatRooms = await getChatRooms();
    final roomIndex = chatRooms.indexWhere((room) => room.id == roomId);
    
    if (roomIndex != -1) {
      chatRooms[roomIndex] = chatRooms[roomIndex].copyWith(
        lastMessage: lastMessage,
        lastMessageTime: timestamp,
      );
      await _saveChatRooms(chatRooms);
    }
  }

  Future<ChatRoom> createChatRoom(String name, String description) async {
    final chatRooms = await getChatRooms();
    final newRoom = ChatRoom(
      id: _generateId(),
      name: name,
      description: description,
      participants: [_currentUser],
      createdAt: DateTime.now(),
    );
    
    chatRooms.add(newRoom);
    await _saveChatRooms(chatRooms);
    return newRoom;
  }

  String _generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString() + 
           Random().nextInt(1000).toString();
  }

  // Simulate receiving messages from other users
  Future<void> simulateIncomingMessage(String roomId) async {
    final List<String> sampleMessages = [
      'Merhaba!',
      'Nasılsınız?',
      'Güzel bir gün!',
      'Bu konuyu çok seviyorum',
      'Haklısın, katılıyorum',
      'İlginç bir bakış açısı',
      'Teşekkürler paylaştığın için',
      'Daha sonra konuşalım',
    ];
    
    final List<String> sampleUsers = ['Ahmet', 'Ayşe', 'Mehmet', 'Ali', 'Fatma', 'Okan', 'Zeynep'];
    
    await Future.delayed(Duration(seconds: 2 + Random().nextInt(8)));
    
    final messages = await getMessages(roomId);
    final randomMessage = sampleMessages[Random().nextInt(sampleMessages.length)];
    final randomUser = sampleUsers[Random().nextInt(sampleUsers.length)];
    
    final newMessage = Message(
      id: _generateId(),
      content: randomMessage,
      sender: randomUser,
      timestamp: DateTime.now(),
      isMe: false,
    );
    
    messages.add(newMessage);
    await _saveMessages(roomId, messages);
    await _updateLastMessage(roomId, randomMessage, DateTime.now());
  }
}