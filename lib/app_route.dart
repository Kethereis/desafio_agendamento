import 'package:desafio_agendamento/view/home_view.dart';
import 'package:desafio_agendamento/view/scheduling_view.dart';
import 'package:desafio_agendamento/view/widgets/route_wrapper_widget.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/home',
      builder: (context, state) =>  RouteWrapper(
          title: "Postagens Agendadas",
          showFloating: true,
          child: HomeView()),
    ),
    GoRoute(
      path: '/scheduling',
      builder: (context, state) =>  RouteWrapper(
          title: "Agendar Postagem",
          showFloating: false,
          child: SchedulingView()),
    ),

  ]
);