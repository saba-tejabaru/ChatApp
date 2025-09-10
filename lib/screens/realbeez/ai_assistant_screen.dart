import 'package:flutter/material.dart';
import '../../services/ai_store.dart';
import '../../services/ai_rules.dart';

class AIAssistantScreen extends StatefulWidget {
  const AIAssistantScreen({super.key});

  @override
  State<AIAssistantScreen> createState() => _AIAssistantScreenState();
}

class _AIAssistantScreenState extends State<AIAssistantScreen> {
  final TextEditingController _controller = TextEditingController();
  final store = AIAssistantStore.instance;

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    store.addUser(text);
    final reply = AIRules.respond(text);
    if (reply.isNotEmpty) {
      store.addAI(reply);
    }
    _controller.clear();
    setState(() {});
  }

  // Rule-based replies moved to AIRules

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Beezy AI Assistant')),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder<List<AIMessage>>(
              valueListenable: store.messages,
              builder: (context, msgs, _) {
                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: msgs.length,
                  itemBuilder: (context, index) {
                    final m = msgs[index];
                    final isUser = m.role == 'user';
                    return Align(
                      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(
                          color: isUser ? const Color(0xFFDCFCE7) : Colors.white,
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(m.text),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(hintText: 'Ask about prices, areas, EMIs, selling...'),
                    onSubmitted: (_) => _send(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(onPressed: _send, icon: const Icon(Icons.send_rounded)),
              ],
            ),
          )
        ],
      ),
    );
  }
}

