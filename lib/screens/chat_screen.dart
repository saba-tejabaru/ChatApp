import 'package:chat_demo/services/socket_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/chat/chat_bloc.dart';
import '../repositories/chat_repository.dart';
import '../repositories/auth_repository.dart';
import '../models/message.dart';
import '../widgets/message_bubble.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;
  final String currentUserId;
  final SocketService socketService;

  const ChatScreen({Key? key, required this.chatId, required this.currentUserId, required this.socketService}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final ChatRepository chatRepository;
  late final ChatBloc chatBloc;
  final _controller = TextEditingController();
  late final Stream subscription;

  @override
  void initState() {
    super.initState();
    final authRepo = RepositoryProvider.of<AuthRepository>(context);
    chatRepository = ChatRepository(authRepo: authRepo);
    chatBloc = ChatBloc(chatRepository: chatRepository, socketService: widget.socketService);
    chatBloc.add(LoadChatMessages(chatId: widget.chatId));

    // Listen to socket events and add to bloc
    widget.socketService.onMessage.listen((data) {
      try {
        final message = MessageModel.fromJson(Map<String, dynamic>.from(data));
        if (message.chatId == widget.chatId) {
          chatBloc.add(ReceiveSocketMessage(message: message));
        }
      } catch (_) {}
    });
  }

  @override
  void dispose() {
    chatBloc.close();
    _controller.dispose();
    super.dispose();
  }

  void _send() {
    final txt = _controller.text.trim();
    if (txt.isEmpty) return;
    chatBloc.add(SendChatMessage(
      chatId: widget.chatId,
      senderId: widget.currentUserId,
      content: txt,
      messageType: 'text',
    ));
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: chatBloc,
      child: Scaffold(
        appBar: AppBar(title: const Text('Chat')),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
                  if (state is ChatLoading) return const Center(child: CircularProgressIndicator());
                  if (state is ChatLoaded) {
                    final messages = state.messages;
                    return ListView.builder(
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (ctx, idx) {
                        final m = messages[messages.length - 1 - idx];
                        final isMe = m.senderId == widget.currentUserId;
                        return MessageBubble(message: m, isMe: isMe);
                      },
                    );
                  } else if (state is ChatError) {
                    return Center(child: Text('Error: ${state.message}'));
                  }
                  return const SizedBox.shrink();
                }),
              ),
              const Divider(height: 1),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        textInputAction: TextInputAction.send,
                        onSubmitted: (_) => _send(),
                        decoration: const InputDecoration.collapsed(hintText: 'Type a message'),
                      ),
                    ),
                    IconButton(icon: const Icon(Icons.send), onPressed: _send),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
