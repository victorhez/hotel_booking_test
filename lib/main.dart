import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hotel_booking_app/core/network/api_client.dart';

import 'domain/repositories/hotel_repository.dart';
import 'logic/blocs/hotels/hotel_bloc.dart';
import 'route/auto_route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appRouter = AppRouter();
  final apiClient = ApiService();
  final hotelRepository = HotelRepository(apiClient);
  runApp(MyApp(appRouter: appRouter, hotelRepository: hotelRepository,));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  final HotelRepository hotelRepository;

  const MyApp({
    super.key,
    required this.appRouter,
    required this.hotelRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Add your blocs/providers here
        BlocProvider(create: (_) => HotelBloc(hotelRepository)),

        // Add additional blocs/providers as needed
      ],
      child: MaterialApp.router(
        
        routerDelegate: AutoRouterDelegate(appRouter),
        routeInformationParser: appRouter.defaultRouteParser(),
        debugShowCheckedModeBanner: false,
        title: 'Hotel Booking App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
    );
  }
}
