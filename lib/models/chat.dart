import 'message.dart';

class ChatModel {
  final String id;
  final String title;
  final List<MessageModel> messages;

  ChatModel({
    required this.id,
    required this.title,
    this.messages = const [],
  });

  /// Convenience getter for the latest message (if any)
  MessageModel? get lastMessage =>
      messages.isNotEmpty ? messages.last : null;

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['_id'] ?? json['id'] ?? '',
      title: (json['name'] ?? json['title'] ?? json['participantsName'] ?? 'Chat') as String,
      messages: (json['messages'] as List<dynamic>?)
              ?.map((m) => MessageModel.fromJson(m as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'messages': messages.map((m) => m.toJson()).toList(),
    };
  }
}
