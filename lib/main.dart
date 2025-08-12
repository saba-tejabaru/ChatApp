import 'package:chat_demo/services/socket_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'repositories/auth_repository.dart';
import 'repositories/chat_repository.dart';
import 'blocs/auth/auth_bloc.dart';
import 'screens/login_screen.dart';
import 'screens/chats_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final authRepo = AuthRepository();
  final chatRepo = ChatRepository(authRepo: authRepo);
  final socket = SocketService();
  runApp(MyApp(authRepo: authRepo, chatRepo: chatRepo, socketService: socket));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepo;
  final ChatRepository chatRepo;
  final SocketService socketService;
  const MyApp({required this.authRepo, required this.chatRepo, required this.socketService, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authRepo),
        RepositoryProvider.value(value: chatRepo),
        RepositoryProvider.value(value: socketService),
      ],
      child: BlocProvider(
        create: (_) => AuthBloc(authRepository: authRepo)..add(AuthCheckRequested()),
        child: MaterialApp(
          title: 'Chat Demo',
           debugShowCheckedModeBanner: false,
          theme: ThemeData(primarySwatch: Colors.blue),
          home: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
            if (state is Authenticated) return ChatsScreen();
            if (state is Unauthenticated) return LoginScreen();
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }),
        ),
      ),
    );
  }
}
