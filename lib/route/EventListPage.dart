import 'package:flutter/material.dart';

import '../util/CalendarEvent.dart';
import '../util/MySharedVariable.dart';
import '../util/MyWidget.dart';

class MyEventListPage extends StatefulWidget {
  const MyEventListPage({Key? key}) : super(key: key);

  @override
  State<MyEventListPage> createState() => _MyMyEventListPageState();
}

class _MyMyEventListPageState extends State<MyEventListPage> {
  final MySharedVariable globalVar = MySharedVariable();

  @override
  Widget build(BuildContext context) {
    List<CalendarEventCard> showedCalendarEventCard = [CalendarEventCard(d: globalVar.exampleCED)];

    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Column(
            children: [
              const Text("Create CalendarEvent"),
              MyStyle.blackDivider,
              ElevatedButton(
                child: const Text("Fetch CalendarEventCard(s)"),
                onPressed: () {
                  List<String> CEIndex = [];
                  /// Probably will take too much time to fetch all the event at once
                  for (int currentElement in globalVar.calendarEventIndex.take(10)){
                    CEIndex.add(currentElement.toString());
                  }
                  CalendarEventDataGenerator.multipleEvent(httpClient: globalVar.apiClient, event_id_list: CEIndex).then((ret) {
                    globalVar.someCalendarEventData = ret;
                    debugPrint("Finished Fetching events");
                    for (CalendarEventData currentCED in globalVar.someCalendarEventData){
                      globalVar.someCalendarEventCard.add(CalendarEventCard(d: currentCED));
                    }
                    debugPrint("Finished creating event card");
                  });
                },
              ),
            ],
          ),
        ),
        const VerticalDivider(),
        Expanded(
          flex: 1,
          child: Column(
            children: List.from([const Text("All CalendarEvent"), MyStyle.blackDivider])..addAll(showedCalendarEventCard),
          ),
        ),
      ],
    );
  }
}