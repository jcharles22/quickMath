library routes;


import '../../constants/routeNames.dart';
import 'route_matcher.dart';
import '../screens/game/gameScreen.dart';
import '../screens/menu/menuScreen.dart';

final List<RouteMatcher> ROUTES = [
  RouteMatcher(
    route: MENU_SCREEN,
    builder: (context, params) {
      return const MenuScreen();
    },
  ),
  RouteMatcher(
    route: GAME_SCREEN,
    builder: (context, params) {
      return const GameScreen(title: 'GameScreen');
    },
  )
];
