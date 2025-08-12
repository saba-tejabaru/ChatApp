part of 'chats_bloc.dart';

abstract class ChatsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChatsInitial extends ChatsState {}

class ChatsLoading extends ChatsState {}

class ChatsLoaded extends ChatsState {
  final List<ChatModel> chats;
  ChatsLoaded({required this.chats});
  @override
  List<Object?> get props => [chats];
}

class ChatsError extends ChatsState {
  final String message;
  ChatsError({required this.message});
  @override
  List<Object?> get props => [message];
}
