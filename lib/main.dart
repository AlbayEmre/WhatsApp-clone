import 'package:bloc_pattern_firebase_tut/Bloc/Auth/auth_bloc_bloc.dart';
import 'package:bloc_pattern_firebase_tut/Bloc/Chat/chat_bloc.dart';
import 'package:bloc_pattern_firebase_tut/Bloc/room_bloc/room_bloc_bloc.dart';
import 'package:bloc_pattern_firebase_tut/Bloc/room_user_bloc/room_user_bloc.dart';
import 'package:bloc_pattern_firebase_tut/Bloc/room_user_bloc/room_user_event.dart';
import 'package:bloc_pattern_firebase_tut/Landing.dart';
import 'package:bloc_pattern_firebase_tut/Repository/Chat_Repository.dart';
import 'package:bloc_pattern_firebase_tut/Repository/auth_repository.dart';
import 'package:bloc_pattern_firebase_tut/Repository/room_repository.dart';
import 'package:bloc_pattern_firebase_tut/Repository/user_repository.dart';
import 'package:bloc_pattern_firebase_tut/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Yalnızca geliştirme modunda App Check'i devre dışı bırakın.
  //await FirebaseAppCheck.instance.setTokenAutoRefreshEnabled(false);
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => AuthRepository()),
        RepositoryProvider(create: (_) => UserRepository()),
        RepositoryProvider(create: (_) => ChatRepository()),
        RepositoryProvider(create: (_) => RoomRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBlocBloc(
              authRepository: context.read<AuthRepository>(), //AuthRepository repoyu alıyoruz
              userRepository: context.read<UserRepository>(), //UserRepository repoyu alıyoruz
            )..add(
                AppStarted()), //Uygylama il başladında eyer önceden kullanıcı varsa bunu eşitle ve state yi Authenticated yap ve root screnne yolla
          ),
          BlocProvider(
            create: (context) => ChatBloc(
              chatRepository: context.read<ChatRepository>(),
            ), //Chat başta yüklememeye gerek yok çünkü kullanıcı bir odaya girdinde tetiklenmesi daha mantıklı
          ),
          BlocProvider(
            create: (context) => RoomBlocBloc(roomRepository: context.read<RoomRepository>())
              ..add(
                LoadRooms(),
              ),
          ),
          BlocProvider(
              create: (context) => RoomUserBloc(
                    context.read<ChatRepository>(),
                    roomRepository: context.read<RoomRepository>(),
                  )..add(
                      LoadUserRooms(),
                    ))
        ],
        child: MaterialApp(
          theme: ThemeData(
            colorSchemeSeed: Colors.blue,
          ),
          debugShowCheckedModeBanner: false,
          home: Landing(),
        ),
      ),
    );
  }
}
