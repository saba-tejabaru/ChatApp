part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadChatMessages extends ChatEvent {
  final String chatId;
  LoadChatMessages({required this.chatId});
  @override
  List<Object?> get props => [chatId];
}

class SendChatMessage extends ChatEvent {
  final String chatId;
  final String senderId;
  final String content;
  final String messageType;
  final String? fileUrl;

  SendChatMessage({
    required this.chatId,
    required this.senderId,
    required this.content,
    this.messageType = 'text',
    this.fileUrl,
  });

  @override
  List<Object?> get props => [chatId, senderId, content, messageType, fileUrl];
}

class ReceiveSocketMessage extends ChatEvent {
  final MessageModel message;
  ReceiveSocketMessage({required this.message});
  @override
  List<Object?> get props => [message];
}
