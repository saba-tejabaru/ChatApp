part of 'chats_bloc.dart';

abstract class ChatsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadChats extends ChatsEvent {
  final String userId;
  LoadChats({required this.userId});
  @override
  List<Object?> get props => [userId];
}
