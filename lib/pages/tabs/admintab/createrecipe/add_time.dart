import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:recipizz/utils/app_theme.dart';

class AddReqTime extends StatefulWidget {
  final Function(String ) onSetTimeValue;
  const AddReqTime({super.key,required this.onSetTimeValue});

  @override
  State<AddReqTime> createState() => _AddReqTimeState();
}

class _AddReqTimeState extends State<AddReqTime> {
  TimeOfDay selectedTime = const TimeOfDay(hour: 0, minute: 0);

  Future<void> selectTimeFn(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.input,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        widget.onSetTimeValue(_formatTime(selectedTime));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text('Duration*',
              style: TextStyle(
                fontWeight: FontWeight.bold, 
                fontSize: 14)),
        ),
        Text(
          "${_formatTime(selectedTime)} hr",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800
          ),
        ),
        Divider(
          color: AppTheme.colors.appGreyColor,
          height: 10,
          thickness: 1, 
          // indent: 1, 
          endIndent: 10, 
        ),
        const SizedBox(height: 20,),
         GestureDetector(
          onTap:() => selectTimeFn(context),
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                  color: AppTheme.colors.appButtonColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Text('Select Time',
                  style: TextStyle(color: AppTheme.colors.appWhiteColor)),
            ),
          ),
        ),
      ],
    );
  }

  String _formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final format = DateFormat('HH.mm');
    return format.format(dt);
  }
}
