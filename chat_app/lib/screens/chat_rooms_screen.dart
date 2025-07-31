import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/chat_room.dart';
import '../services/chat_service.dart';
import 'chat_screen.dart';
import 'create_room_screen.dart';
import 'profile_screen.dart';

class ChatRoomsScreen extends StatefulWidget {
  @override
  _ChatRoomsScreenState createState() => _ChatRoomsScreenState();
}

class _ChatRoomsScreenState extends State<ChatRoomsScreen> {
  final ChatService _chatService = ChatService();
  List<ChatRoom> _chatRooms = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadChatRooms();
  }

  Future<void> _loadChatRooms() async {
    setState(() => _isLoading = true);
    try {
      await _chatService.loadCurrentUser();
      final rooms = await _chatService.getChatRooms();
      setState(() {
        _chatRooms = rooms;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sohbet odaları yüklenirken hata: $e')),
      );
    }
  }

  String _formatTime(DateTime? dateTime) {
    if (dateTime == null) return '';
    
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inDays > 0) {
      return DateFormat('dd/MM/yyyy').format(dateTime);
    } else if (difference.inHours > 0) {
      return '${difference.inHours} saat önce';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} dakika önce';
    } else {
      return 'Şimdi';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Sohbet Odaları',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        elevation: 2,
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            ).then((_) => _loadChatRooms()),
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _loadChatRooms,
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[600]!),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Sohbet odaları yükleniyor...',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            )
          : RefreshIndicator(
              onRefresh: _loadChatRooms,
              child: _chatRooms.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.chat_bubble_outline,
                            size: 80,
                            color: Colors.grey[400],
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Henüz sohbet odası yok',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Yeni bir oda oluşturmak için + butonuna basın',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.all(8),
                      itemCount: _chatRooms.length,
                      itemBuilder: (context, index) {
                        final room = _chatRooms[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(16),
                            leading: CircleAvatar(
                              backgroundColor: Colors.blue[600],
                              radius: 25,
                              child: Text(
                                room.name.isNotEmpty ? room.name[0].toUpperCase() : '?',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            title: Text(
                              room.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 4),
                                Text(
                                  room.description,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                                if (room.lastMessage != null) ...[
                                  SizedBox(height: 8),
                                  Text(
                                    room.lastMessage!,
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 14,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ],
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  _formatTime(room.lastMessageTime),
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.blue[100],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    '${room.participants.length}',
                                    style: TextStyle(
                                      color: Colors.blue[800],
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatScreen(chatRoom: room),
                              ),
                            ).then((_) => _loadChatRooms()),
                          ),
                        );
                      },
                    ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CreateRoomScreen()),
        ).then((_) => _loadChatRooms()),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        icon: Icon(Icons.add),
        label: Text('Yeni Oda'),
      ),
    );
  }
}