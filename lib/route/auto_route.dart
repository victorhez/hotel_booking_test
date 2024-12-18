import 'package:auto_route/auto_route.dart';
import 'auto_route.gr.dart'; // Import generated file

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: DashboardRoute.page,
          initial: true,
          children: [
            AutoRoute(page: OverviewRoute.page),
            AutoRoute(page: HotelsRoute.page),
            AutoRoute(page: FavoritesRoute.page),
            AutoRoute(page: AccountRoute.page),
          ],
        ),
      ];
}

