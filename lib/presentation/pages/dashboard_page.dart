import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/blocs/hotels/hotel_bloc.dart';
import '../../logic/blocs/hotels/hotel_event.dart';
import '../../route/auto_route.gr.dart'; // Import generated routes

@RoutePage()
// ignore: use_key_in_widget_constructors
class DashboardScreen extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    Future.microtask(() {
      // ignore: use_build_context_synchronously
      context.read<HotelBloc>().add(FetchHotels());
    });
    return Scaffold(
      body: AutoTabsScaffold(
        routes: const [
          OverviewRoute(),
          HotelsRoute(),
          FavoritesRoute(),
          AccountRoute(),
        ],
        bottomNavigationBuilder: (_, tabsRouter) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                label: 'Overview',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.hotel),
                label: 'Hotels',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'Account',
              ),
            ],
          );
        },
      ),
    );
  }
}
