import 'package:bloc_pattern_firebase_tut/Bloc/User_bloc/user_bloc_bloc.dart';
import 'package:bloc_pattern_firebase_tut/Repository/user_repository.dart';
import 'package:bloc_pattern_firebase_tut/controller/User_uid_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class RootScreen extends StatelessWidget {
  final PersistentTabController _controller = PersistentTabController(initialIndex: 1);
  RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        //! GetUserUid fonksyonu burda çalışacak
        final userBloc = UserBlocBloc(userRepository: UserRepository());

        userBloc.add(LoadUser(GetUserInformation.getUserUid()));
        return userBloc;
      },
      child: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(context),
        items: _navBarsItems(),
      ),
    );
  }

  List<Widget> _buildScreens(BuildContext context) {
    return [
      Container(), //MyRoomsScreen
      Container(), //AllRoomsScreen
      Container(), //ProfileScreen
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          icon: Icon(Icons.home),
          title: ("Odalarım"),
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.grey),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.search_rounded),
          title: ("Keşvet"),
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.grey),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.person),
          title: ("Profilim"),
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.grey),
    ];
  }
}
