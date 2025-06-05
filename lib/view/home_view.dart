import 'package:desafio_agendamento/viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../utils/constants.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewmodel()..loadCachedEvents(),
      child: Consumer<HomeViewmodel>(
        builder: (context, viewModel, child) {
          return Column(
            children: [
              SizedBox(
                height: 400,
                child: TableCalendar(
                  locale: 'pt_BR',
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: viewModel.focusedDay,
                  selectedDayPredicate: (day) =>
                  day.year == (viewModel.selectedDay?.year ?? 0) &&
                      day.month == (viewModel.selectedDay?.month ?? 0) &&
                      day.day == (viewModel.selectedDay?.day ?? 0),
                  onDaySelected: (selectedDay, focusedDay) {
                    viewModel.setSelectedDay(selectedDay, focusedDay);
                  },
                  eventLoader: viewModel.getEventsForDay,
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: ColorConstants.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    markerDecoration: BoxDecoration(
                      color: ColorConstants.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    markersMaxCount: 3,
                  ),
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                  calendarFormat: CalendarFormat.month,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Postagens Agendadas",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),) ,
              ),
              viewModel.getEventsForDay(viewModel.selectedDay ?? DateTime.now()).isEmpty ?
              Padding(padding: EdgeInsets.symmetric(vertical: 30),
                  child: Center(child: Text("Nenhuma postagem agendada", style: TextStyle(color: Colors.black)))) :
              const SizedBox(height: 8),
                  ...viewModel
                      .getEventsForDay(viewModel.selectedDay ?? DateTime.now())
                      .map((event) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: ColorConstants.primaryColor,
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: AssetImage(event.image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              event.title.length > 25
                                  ? event.title.substring(0, 25)
                                  : event.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              width: 250,
                              child: Text(
                                event.subtitle.length > 80
                                    ? '${event.subtitle.substring(0, 80)}...'
                                    : event.subtitle,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              width: 120,
                              height: 15,
                              decoration: BoxDecoration(
                                color: ColorConstants.primaryColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.access_time,
                                      color: Colors.white, size: 14),
                                  const SizedBox(width: 5),
                                  Text("${event.date} ${event.hour}",
                                      style: const TextStyle(
                                          fontSize: 10, color: Colors.white)),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )).toList(),
                ],
          );
        },
      ),
    );
  }
}
