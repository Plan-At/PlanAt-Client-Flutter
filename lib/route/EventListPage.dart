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
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Column(
            children: [
              const Text("Create CalendarEvent"),
              MyStyle.blackDivider,
              ElevatedButton(
                child: const Text("Fetch CalendarEventIndex"),
                onPressed: () {
                  CalendarEventList.privateIndex(globalVar.apiClient).then(((ret) {
                    globalVar.calendarEventIndex = ret;
                    debugPrint(globalVar.calendarEventIndex.toString());
                    debugPrint("Finished fetch CalendarEventIndex");
                    /// setState() is not required to use the snack bar
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Finished fetch CalendarEventIndex")));
                  }));
                },
              ),
              ElevatedButton(
                child: const Text("Fetch CalendarEventCard(s)"),
                onPressed: () {
                  /// Probably will take too much time to fetch all the event at once
                  /// List.take() is used to trim the list to certain length
                  List<String> CEIndex = [];
                  for (int currentElement in globalVar.calendarEventIndex.take(10)){
                    CEIndex.add(currentElement.toString());
                  }
                  CalendarEventDataHelper.multipleEvent(httpClient: globalVar.apiClient, event_id_list: CEIndex).then((ret) {
                    globalVar.someCalendarEventData = ret;
                    debugPrint("Finished Fetching events");
                    for (CalendarEventData currentCED in globalVar.someCalendarEventData){
                      setState(() {
                        globalVar.someCalendarEventCard.add(CalendarEventCard(d: currentCED));
                        debugPrint("globalVar.someCalendarEventCard.length: "+globalVar.someCalendarEventCard.length.toString());
                      });
                    }
                    debugPrint("Finished creating event card");
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Finished creating event card")));
                  });
                },
              ),
              ElevatedButton(
                child: const Text("Show a SnackBar"),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("An example SnackBar")));
                },
              ),
              ElevatedButton(
                child: const Text("Show Time Picker"),
                onPressed: () {
                  showTimePicker(
                    context: context, 
                    initialTime: globalVar.inputedStartTime,
                  ).then((ret) {
                    // the returned TimeOfDay could be null so add a check here
                    if (ret != null){
                      setState(() {
                        globalVar.inputedStartTime = ret;
                      });
                    }
                  });
                },
              ),
              Text(globalVar.inputedStartTime.hour.toString()+":"+globalVar.inputedStartTime.minute.toString()),
            ],
          ),
        ),
        const VerticalDivider(),
        Expanded(
          flex: 1,
          child: Column(
            // children: List.from([const Text("All CalendarEvent"), MyStyle.blackDivider])..addAll(globalVar.someCalendarEventCard),
            children: [
              Row(
                children: [
                  const Text("All CalendarEvent"),
                  const Spacer(),
                  Text("There are "+globalVar.someCalendarEventCard.length.toString()+" event(s)"),
                ],
              ),
              MyStyle.blackDivider,
              Column(
                children: globalVar.someCalendarEventCard,
              ),
            ],
          ),
        ),
      ],
    );
  }
}