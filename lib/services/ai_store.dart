import 'package:flutter/foundation.dart';

class AIMessage {
  final String role; // 'ai' or 'user'
  final String text;
  const AIMessage({required this.role, required this.text});
}

class AIAssistantStore {
  AIAssistantStore._();
  static final AIAssistantStore instance = AIAssistantStore._();

  final ValueNotifier<List<AIMessage>> messages = ValueNotifier<List<AIMessage>>([
    const AIMessage(role: 'ai', text: 'Hi! I am Beezy. Looking to buy, rent, or sell? I can help with prices, areas, EMIs, and more.'),
  ]);

  void addUser(String text) {
    final list = List<AIMessage>.from(messages.value)..add(AIMessage(role: 'user', text: text));
    messages.value = list;
  }

  void addAI(String text) {
    final list = List<AIMessage>.from(messages.value)..add(AIMessage(role: 'ai', text: text));
    messages.value = list;
  }

  void clear() {
    messages.value = [
      const AIMessage(role: 'ai', text: 'Hi! I am Beezy. Looking to buy, rent, or sell? I can help with prices, areas, EMIs, and more.'),
    ];
  }
}

