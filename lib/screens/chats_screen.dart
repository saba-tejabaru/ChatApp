import 'package:chat_demo/services/socket_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/auth_repository.dart';
import '../repositories/chat_repository.dart';
import '../blocs/chats/chats_bloc.dart';
import 'chat_screen.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  late final AuthRepository authRepository;
  late final ChatRepository chatRepository;
  late final SocketService socketService;
  late final ChatsBloc chatsBloc;
  String? userId = '673d80bc2330e08c323f4393'; // default sample; replace as needed

  @override
  void initState() {
    super.initState();
    authRepository = RepositoryProvider.of<AuthRepository>(context);
    chatRepository = ChatRepository(authRepo: authRepository);
    socketService = SocketService();
    chatsBloc = ChatsBloc(chatRepository: chatRepository);
    authRepository.getToken().then((t) {
      socketService.connect(token: t);
    });
    chatsBloc.add(LoadChats(userId: userId!));
  }

  @override
  void dispose() {
    chatsBloc.close();
    socketService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: chatsBloc,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 224, 214, 214),
          title: const Text(
            'Chats',
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: BlocBuilder<ChatsBloc, ChatsState>(
          builder: (context, state) {
            if (state is ChatsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ChatsLoaded) {
              final chats = state.chats;
              if (chats.isEmpty) return const Center(child: Text('No chats yet.'));

              final randomNames = [
                'Alice Johnson',
                'Bob Smith',
                'Charlie Davis',
                'Diana Prince',
                'Ethan Clarke',
                'Fiona Gallagher',
                'George Miller',
                'Hannah Wright',
                'Isaac Newton',
                'Julia Roberts'
              ];

              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                itemBuilder: (ctx, i) {
                  final c = chats[i];
                  final randomName = randomNames[i % randomNames.length];
                  final lastMessage = c.lastMessage?.content.trim() ?? 'No messages yet';

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChatScreen(
                            chatId: c.id,
                            currentUserId: userId!,
                            socketService: socketService,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundColor: Colors.blueAccent,
                              child: Text(
                                randomName[0],
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    randomName,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    lastMessage,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemCount: chats.length,
              );
            } else if (state is ChatsError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
