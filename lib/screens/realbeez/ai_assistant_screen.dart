import 'package:flutter/material.dart';

class AIAssistantScreen extends StatefulWidget {
  const AIAssistantScreen({super.key});

  @override
  State<AIAssistantScreen> createState() => _AIAssistantScreenState();
}

class _AIAssistantScreenState extends State<AIAssistantScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<_Message> _messages = [
    const _Message(role: 'ai', text: 'Hi! I am Beezy. Looking to buy, rent, or sell? I can help with prices, areas, EMIs, and more.'),
  ];

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(_Message(role: 'user', text: text));
      _messages.add(_Message(role: 'ai', text: _respond(text)));
      _controller.clear();
    });
  }

  String _respond(String input) {
    final lower = input.toLowerCase();
    if (lower.contains('emi') || lower.contains('loan')) {
      return 'You can estimate EMIs in Tools > Home Loan & EMI. Typical rates ~8-9% p.a. Want me to open it?';
    }
    if (lower.contains('2 bhk') || lower.contains('2bhk')) {
      return '2 BHK options around ₹70L–₹1.1Cr depending on city. Any preferred area and budget?';
    }
    if (lower.contains('rent') && lower.contains('hsr')) {
      return 'HSR Layout rents for 2 BHK are ~₹28k–₹42k/month depending on block and furnishing.';
    }
    if (lower.contains('best area') || lower.contains('which area')) {
      return 'For IT commute in Bengaluru: HSR, Sarjapur Rd, Whitefield. For Mumbai: Powai, Andheri East. What city and budget?';
    }
    if (lower.contains('sell')) {
      return 'To sell, list your property (Post Property Free). Verified photos, correct price, and paperwork speed up sales.';
    }
    if (lower.contains('trend') || lower.contains('price')) {
      return 'Check Tools > Rates & Trends for micro-market price charts. Which city/locality should I check?';
    }
    return 'Got it. Could you share city, locality, budget, and BHK? I can suggest options and tools.';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Beezy AI Assistant')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final m = _messages[index];
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

class _Message {
  final String role;
  final String text;
  const _Message({required this.role, required this.text});
}

