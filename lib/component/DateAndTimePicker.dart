import 'package:flutter/material.dart';

import '../util/MySharedVariable.dart';

class DateAndTimePicker extends StatefulWidget {
  const DateAndTimePicker({Key? key}) : super(key: key);

  @override
  State<DateAndTimePicker> createState() => _DateAndTimePickerState();
}

class _DateAndTimePickerState extends State<DateAndTimePicker> {
  final MySharedVariable globalVar = MySharedVariable();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Column(
              children: [
                ElevatedButton(
                  child: const Text("Show Start Time Picker"),
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
            Column(
              children: [
                ElevatedButton(
                  child: const Text("Show End Time Picker"),
                  onPressed: () {
                    showTimePicker(
                      context: context, 
                      initialTime: globalVar.inputedEndTime,
                    ).then((ret) {
                      // the returned TimeOfDay could be null so add a check here
                      if (ret != null){
                        setState(() {
                          globalVar.inputedEndTime = ret;
                        });
                      }
                    });
                  },
                ),
                Text(globalVar.inputedEndTime.hour.toString()+":"+globalVar.inputedEndTime.minute.toString()),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Column(
              children: [
                ElevatedButton(
                  child: const Text("Show Date Picker"),
                  onPressed: () {
                    showDatePicker(
                      context: context, 
                      // Have to procide some date here
                      // So the start year is when the UNIX timestamp system begin
                      // And the end year is when the timestamp still under ten-digit
                      // To compatible with current backend
                      initialDate: DateTime.now(), 
                      firstDate: DateTime(1970), 
                      lastDate: DateTime(2286), 
                    ).then((ret) {
                      if (ret != null){
                        setState(() {
                          globalVar.inputedStartDate = ret;
                        });
                      }
                    });
                  },
                ),
                Text(globalVar.inputedStartDate.day.toString()),
              ],
            ),
            Column(
              children: [
                ElevatedButton(
                  child: const Text("Show Date Range Picker"),
                  onPressed: () {
                    showDateRangePicker(
                      context: context, 
                      // Have to procide some date here
                      // So the start year is when the UNIX timestamp system begin
                      // And the end year is when the timestamp still under ten-digit
                      // To compatible with current backend
                      firstDate: DateTime(1970), 
                      lastDate: DateTime(2286), 
                    ).then((ret) {
                      if (ret != null){
                        setState(() {
                          globalVar.inputedDateRange = ret;
                        });
                      }
                    });
                  },
                ),
                Text(globalVar.inputedDateRange.start.day.toString()+"~"+globalVar.inputedDateRange.end.day.toString()),
              ],
            ),
          ],
        ),
      ],
    );
  }
}