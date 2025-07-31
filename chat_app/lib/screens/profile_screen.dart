import 'package:flutter/material.dart';
import '../services/chat_service.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ChatService _chatService = ChatService();
  final TextEditingController _usernameController = TextEditingController();
  bool _isEditing = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  void _loadUserData() {
    _usernameController.text = _chatService.currentUser;
  }

  Future<void> _saveProfile() async {
    if (_usernameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kullanıcı adı boş olamaz')),
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      await _chatService.setCurrentUser(_usernameController.text.trim());
      setState(() => _isEditing = false);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Profil başarıyla güncellendi!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Profil güncellenirken hata: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _isSaving = false);
    }
  }

  void _cancelEdit() {
    setState(() => _isEditing = false);
    _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'Profil',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        elevation: 2,
        actions: [
          if (_isEditing)
            TextButton(
              onPressed: _cancelEdit,
              child: Text(
                'İptal',
                style: TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: 20),
            // Profile Picture Section
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              padding: EdgeInsets.all(24),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blue[600],
                    child: Text(
                      _chatService.currentUser.isNotEmpty 
                          ? _chatService.currentUser[0].toUpperCase() 
                          : '?',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    _chatService.currentUser,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Sohbet Uygulaması Kullanıcısı',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            // Profile Settings Section
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Profil Ayarları',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                  Divider(height: 1, color: Colors.grey[200]),
                  ListTile(
                    leading: Icon(Icons.person, color: Colors.blue[600]),
                    title: Text('Kullanıcı Adı'),
                    subtitle: _isEditing
                        ? TextField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              isDense: true,
                            ),
                          )
                        : Text(_chatService.currentUser),
                    trailing: _isEditing
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (_isSaving)
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                )
                              else
                                IconButton(
                                  icon: Icon(Icons.check, color: Colors.green),
                                  onPressed: _saveProfile,
                                ),
                            ],
                          )
                        : IconButton(
                            icon: Icon(Icons.edit, color: Colors.grey[600]),
                            onPressed: () => setState(() => _isEditing = true),
                          ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            // App Information Section
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Uygulama Hakkında',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                  Divider(height: 1, color: Colors.grey[200]),
                  ListTile(
                    leading: Icon(Icons.info, color: Colors.blue[600]),
                    title: Text('Versiyon'),
                    subtitle: Text('1.0.0'),
                  ),
                  ListTile(
                    leading: Icon(Icons.flutter_dash, color: Colors.blue[600]),
                    title: Text('Flutter ile geliştirildi'),
                    subtitle: Text('Modern Android sohbet uygulaması'),
                  ),
                  ListTile(
                    leading: Icon(Icons.storage, color: Colors.blue[600]),
                    title: Text('Veri Depolama'),
                    subtitle: Text('Veriler cihazınızda güvenle saklanır'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            // Feature Information
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.blue[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.blue[600]),
                      SizedBox(width: 8),
                      Text(
                        'Özellikler',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[800],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  _buildFeatureItem('Gerçek zamanlı mesajlaşma'),
                  _buildFeatureItem('Çoklu sohbet odaları'),
                  _buildFeatureItem('Kullanıcı profil yönetimi'),
                  _buildFeatureItem('Modern ve kullanıcı dostu arayüz'),
                  _buildFeatureItem('Yerel veri saklama'),
                ],
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.green[600],
            size: 20,
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.blue[800],
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}