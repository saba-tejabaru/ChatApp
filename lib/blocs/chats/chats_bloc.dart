import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../repositories/chat_repository.dart';
import '../../models/chat.dart';

part 'chats_event.dart';
part 'chats_state.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  final ChatRepository chatRepository;
  ChatsBloc({required this.chatRepository}) : super(ChatsInitial()) {
    on<LoadChats>(_onLoadChats);
  }

  Future<void> _onLoadChats(LoadChats event, Emitter<ChatsState> emit) async {
    emit(ChatsLoading());
    try {
      final chats = await chatRepository.getUserChats(event.userId);
      emit(ChatsLoaded(chats: chats));
    } catch (e) {
      emit(ChatsError(message: e.toString()));
    }
  }
}
