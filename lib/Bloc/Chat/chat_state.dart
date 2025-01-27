part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

//Mesajlar yüklenirken ne olsun
class ChatLoading extends ChatState {}

//Mesajlar yüklendiğinde ne olsun
class ChatLoaded extends ChatState {
  final List<MessageModel> allMessages;

  ChatLoaded(this.allMessages);

  @override
  List<Object> get props => [allMessages];
}

class ChatError extends ChatState {
  final String error;

  ChatError(this.error);

  @override
  List<Object> get props => [error];
}
