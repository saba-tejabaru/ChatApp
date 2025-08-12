import 'package:bloc/bloc.dart';
import 'package:chat_demo/services/socket_services.dart';
import 'package:equatable/equatable.dart';
import '../../models/message.dart';
import '../../repositories/chat_repository.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository chatRepository;
  final SocketService socketService;

  ChatBloc({required this.chatRepository, required this.socketService}) : super(ChatInitial()) {
    on<LoadChatMessages>(_onLoadMessages);
    on<SendChatMessage>(_onSendMessage);
    on<ReceiveSocketMessage>(_onReceiveSocketMessage);
  }

  Future<void> _onLoadMessages(LoadChatMessages event, Emitter<ChatState> emit) async {
    emit(ChatLoading());
    try {
      final messages = await chatRepository.getChatMessages(event.chatId);
      emit(ChatLoaded(messages: messages));
    } catch (e) {
      emit(ChatError(message: e.toString()));
    }
  }

  Future<void> _onSendMessage(SendChatMessage event, Emitter<ChatState> emit) async {
    try {
      // Optimistic add could be done here; for simplicity we reload after send
      await chatRepository.sendMessage({
        'chatId': event.chatId,
        'senderId': event.senderId,
        'content': event.content,
        'messageType': event.messageType,
        'fileUrl': event.fileUrl ?? '',
      });

      // Also send via socket for real-time
      socketService.send('message', {
        'chatId': event.chatId,
        'senderId': event.senderId,
        'content': event.content,
        'messageType': event.messageType,
        'fileUrl': event.fileUrl ?? '',
      });

      // Refresh messages
      final messages = await chatRepository.getChatMessages(event.chatId);
      emit(ChatLoaded(messages: messages));
    } catch (e) {
      emit(ChatError(message: e.toString()));
    }
  }

  Future<void> _onReceiveSocketMessage(ReceiveSocketMessage event, Emitter<ChatState> emit) async {
    final current = state;
    if (current is ChatLoaded) {
      final updated = List<MessageModel>.from(current.messages)..add(event.message);
      emit(ChatLoaded(messages: updated));
    }
  }
}
