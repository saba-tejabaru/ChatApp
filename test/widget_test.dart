import 'package:chat_demo/main.dart';
import 'package:chat_demo/repositories/auth_repository.dart';
import 'package:chat_demo/repositories/chat_repository.dart';
import 'package:chat_demo/services/socket_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
void main() {
  testWidgets('App builds without crashing', (WidgetTester tester) async {
    final authRepo = AuthRepository();
    final chatRepo = ChatRepository(authRepo: authRepo);
    final socketService = SocketService();

    await tester.pumpWidget(
      MyApp(
        authRepo: authRepo,
        chatRepo: chatRepo,
        socketService: socketService,
      ),
    );

    // For now, just verify that some widget is found (like the CircularProgressIndicator)
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
