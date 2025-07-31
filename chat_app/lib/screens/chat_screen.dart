import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/chat_room.dart';
import '../models/message.dart';
import '../services/chat_service.dart';

class ChatScreen extends StatefulWidget {
  final ChatRoom chatRoom;

  const ChatScreen({Key? key, required this.chatRoom}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatService _chatService = ChatService();
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<Message> _messages = [];
  bool _isLoading = true;
  Timer? _messageTimer;

  @override
  void initState() {
    super.initState();
    _loadMessages();
    _startMessageSimulation();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _messageTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadMessages() async {
    setState(() => _isLoading = true);
    try {
      final messages = await _chatService.getMessages(widget.chatRoom.id);
      setState(() {
        _messages = messages;
        _isLoading = false;
      });
      _scrollToBottom();
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Mesajlar yüklenirken hata: $e')),
      );
    }
  }

  void _startMessageSimulation() {
    _messageTimer = Timer.periodic(Duration(seconds: 15), (timer) {
      if (mounted && _messages.isNotEmpty) {
        _simulateIncomingMessage();
      }
    });
  }

  Future<void> _simulateIncomingMessage() async {
    await _chatService.simulateIncomingMessage(widget.chatRoom.id);
    await _loadMessages();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _sendMessage() async {
    final content = _messageController.text.trim();
    if (content.isEmpty) return;

    _messageController.clear();
    
    try {
      await _chatService.sendMessage(widget.chatRoom.id, content);
      await _loadMessages();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Mesaj gönderilirken hata: $e')),
      );
    }
  }

  Widget _buildMessageBubble(Message message) {
    final isMe = message.isMe;
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        padding: EdgeInsets.all(12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isMe ? Colors.blue[600] : Colors.grey[200],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomLeft: isMe ? Radius.circular(16) : Radius.circular(4),
            bottomRight: isMe ? Radius.circular(4) : Radius.circular(16),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isMe)
              Text(
                message.sender,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.blue[700],
                ),
              ),
            if (!isMe) SizedBox(height: 4),
            Text(
              message.content,
              style: TextStyle(
                color: isMe ? Colors.white : Colors.black87,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 4),
            Text(
              DateFormat('HH:mm').format(message.timestamp),
              style: TextStyle(
                color: isMe ? Colors.white70 : Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.chatRoom.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              '${widget.chatRoom.participants.length} katılımcı',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white70,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        elevation: 2,
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'participants',
                child: Row(
                  children: [
                    Icon(Icons.people, color: Colors.grey[600]),
                    SizedBox(width: 8),
                    Text('Katılımcılar'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'info',
                child: Row(
                  children: [
                    Icon(Icons.info, color: Colors.grey[600]),
                    SizedBox(width: 8),
                    Text('Oda Bilgileri'),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              switch (value) {
                case 'participants':
                  _showParticipants();
                  break;
                case 'info':
                  _showRoomInfo();
                  break;
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[600]!),
                    ),
                  )
                : _messages.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.chat_bubble_outline,
                              size: 64,
                              color: Colors.grey[400],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Henüz mesaj yok',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'İlk mesajı gönderin!',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        controller: _scrollController,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        itemCount: _messages.length,
                        itemBuilder: (context, index) {
                          final message = _messages[index];
                          final showDateHeader = index == 0 ||
                              !_isSameDay(_messages[index - 1].timestamp, message.timestamp);

                          return Column(
                            children: [
                              if (showDateHeader)
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    _formatDate(message.timestamp),
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              _buildMessageBubble(message),
                            ],
                          );
                        },
                      ),
          ),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey[300]!, width: 0.5),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Mesajınızı yazın...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      maxLines: null,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[600],
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    if (_isSameDay(date, now)) {
      return 'Bugün';
    } else if (_isSameDay(date, now.subtract(Duration(days: 1)))) {
      return 'Dün';
    } else {
      return DateFormat('dd MMMM yyyy', 'tr_TR').format(date);
    }
  }

  void _showParticipants() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Katılımcılar'),
        content: Container(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.chatRoom.participants.length,
            itemBuilder: (context, index) {
              final participant = widget.chatRoom.participants[index];
              final isCurrentUser = participant == _chatService.currentUser;
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue[600],
                  child: Text(
                    participant.isNotEmpty ? participant[0].toUpperCase() : '?',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(
                  isCurrentUser ? '$participant (Siz)' : participant,
                  style: TextStyle(
                    fontWeight: isCurrentUser ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Kapat'),
          ),
        ],
      ),
    );
  }

  void _showRoomInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Oda Bilgileri'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Oda Adı:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(widget.chatRoom.name),
            SizedBox(height: 16),
            Text(
              'Açıklama:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(widget.chatRoom.description),
            SizedBox(height: 16),
            Text(
              'Oluşturulma Tarihi:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(DateFormat('dd MMMM yyyy HH:mm').format(widget.chatRoom.createdAt)),
            SizedBox(height: 16),
            Text(
              'Katılımcı Sayısı:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('${widget.chatRoom.participants.length} kişi'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Kapat'),
          ),
        ],
      ),
    );
  }
}