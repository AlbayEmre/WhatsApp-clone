import 'package:bloc/bloc.dart';
import 'package:bloc_pattern_firebase_tut/Models/chat_model.dart';
import 'package:bloc_pattern_firebase_tut/Repository/Chat_Repository.dart';
import 'package:equatable/equatable.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository chatRepository;

  ChatBloc({required this.chatRepository}) : super(ChatLoading()) //!Başta yüklenme olacak ilk durum
  {
    on<LoadMessages>(_onLoadMessages);
    on<SendMessage>(_onSendMessages);
  }

  Future<void> _onLoadMessages(LoadMessages event, Emitter<ChatState> emit) async {
    emit(ChatLoading());
    try {
      await emit.forEach<List<MessageModel>>(
        chatRepository.getMessages(event.roomId),

        onData: (messages) => ChatLoaded(messages), //Gelen strem her geldiğinde bunun üstüne eklenir
        onError: (error, stackTrace) => ChatError(error.toString()),
      );
    } catch (error) {}
  }

  Future<void> _onSendMessages(SendMessage event, Emitter<ChatState> emit) async {
    emit(ChatLoading());
    try {
      await chatRepository.sendMessage(event.roomId, event.message);
    } catch (error) {
      emit(ChatError(error.toString()));
    }
  }
}
