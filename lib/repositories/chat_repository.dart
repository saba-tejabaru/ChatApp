import '../services/api_client.dart';
import '../models/chat.dart';
import '../models/message.dart';
import 'auth_repository.dart';

class ChatRepository {
  final AuthRepository authRepo;
  ChatRepository({required this.authRepo});

  Future<List<ChatModel>> getUserChats(String userId) async {
    final token = await authRepo.getToken();
    final client = ApiClient(token: token).dio;
    final resp = await client.get('/chats/user-chats/$userId');
    final data = resp.data;
    if (data is List) {
      return data.map((e) => ChatModel.fromJson(Map<String, dynamic>.from(e as Map))).toList();
    } else {
      return [];
    }
  }

  Future<List<MessageModel>> getChatMessages(String chatId) async {
    final token = await authRepo.getToken();
    final client = ApiClient(token: token).dio;
    final resp = await client.get('/messages/get-messagesformobile/$chatId');
    final data = resp.data;
    if (data is List) {
      return data.map((e) => MessageModel.fromJson(Map<String, dynamic>.from(e as Map))).toList();
    } else {
      return [];
    }
  }

  Future<MessageModel> sendMessage(Map<String, dynamic> body) async {
    final token = await authRepo.getToken();
    final client = ApiClient(token: token).dio;
    final resp = await client.post('/messages/sendMessage', data: body);
    final data = resp.data;
    if (data is Map<String, dynamic>) {
      return MessageModel.fromJson(data);
    } else {
      throw Exception('Unexpected sendMessage response');
    }
  }
}
