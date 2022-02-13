import 'package:flutter/material.dart';

dateTimePicker({
  required BuildContext parentContext,
}) {
  TimeOfDay? pickedTime;
  DateTime? pickedDate;
  DateTime? finalDateTime;
  showTimePicker(
    context: parentContext,
    initialTime: TimeOfDay.now(),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context),
        child: child!,
      );
    },
  ).then(
    (value) {
      pickedTime = value;
      if (pickedTime != null) {
        showDatePicker(
          context: parentContext,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(
            const Duration(days: 7),
          ),
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: Theme.of(context),
              child: child!,
            );
          },
        ).then((value) {
          pickedDate = value;
          if (pickedDate != null) {
            finalDateTime = DateTime(
              pickedDate!.year,
              pickedDate!.month,
              pickedDate!.day,
              pickedTime!.hour,
              pickedTime!.minute,
            );
            print(finalDateTime);
          }
        });
      }
    },
  );
}
