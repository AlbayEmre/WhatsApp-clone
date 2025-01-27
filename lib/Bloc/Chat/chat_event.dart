part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

//Mesajalrın yüklenmsini başlat
class LoadMessages extends ChatEvent {
  final String roomId; //Bunun için yükelencek odanın Id si lağzım

  const LoadMessages(this.roomId);

  @override
  List<Object> get props => [roomId];
}

class SendMessage extends ChatEvent {
  final String roomId;
  final MessageModel message;

  SendMessage(this.roomId, this.message);

  @override
  List<Object> get props => [roomId, message];
}
