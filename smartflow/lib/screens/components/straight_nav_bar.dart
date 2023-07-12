import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smartflow/navigation/config.dart';

// ignore: must_be_immutable
class CustomBottomNav extends StatefulWidget {
  late int selectedTab;
  CustomBottomNav({super.key, required this.selectedTab});

  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.selectedTab,
      backgroundColor: Colors.green,
      selectedItemColor: Colors.greenAccent,
      unselectedItemColor: Colors.black,
      type: BottomNavigationBarType.fixed,
      onTap: (value) {
        switch (value) {
          case 0:
            GoRouter.of(context).pushReplacementNamed(RouteNames.home);
            break;
          case 1:
            GoRouter.of(context).pushNamed(RouteNames.irrigate);
            break;
          case 2:
            GoRouter.of(context).pushNamed(RouteNames.setup);
            break;
          default:
            GoRouter.of(context).pushNamed(RouteNames.home);
        }
      },
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home_filled),
            label: 'Dashboard'),
        BottomNavigationBarItem(
            icon: Icon(Icons.water_drop_outlined), label: 'Irrigate'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setup'),
      ],
    );
  }
}
