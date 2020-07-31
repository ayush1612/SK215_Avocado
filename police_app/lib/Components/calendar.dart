import 'package:flutter/material.dart';
import 'package:police_app/Components/reusablecard.dart';
import 'package:table_calendar/table_calendar.dart';

import '../constants.dart';

class CalendarOption {
  CalendarController _calendarController = CalendarController();

  TextStyle kDaysColor = TextStyle(
    color: Colors.pinkAccent,
  );

  ReusableCard showCalendar() {
    return ReusableCard(
      colour: kActiveCardColor,
      cardChild: TableCalendar(
        daysOfWeekStyle: DaysOfWeekStyle(
          weekendStyle: kDaysColor,
          weekdayStyle: kDaysColor,
        ),

        headerStyle: HeaderStyle(
            leftChevronIcon: Icon(
              Icons.chevron_left,
              color: Colors.white,
            ),
            formatButtonPadding: EdgeInsets.fromLTRB(15, 10, 15, 10),
            rightChevronIcon: Icon(
              Icons.chevron_right,
              color: Colors.white,
            ),
            formatButtonDecoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(15.0),
            )),
//          builders: CalendarBuilders(),
        calendarStyle: CalendarStyle(
//              weekdayStyle: TextStyle(
//                  color: Colors.lightBlueAccent, fontWeight: FontWeight.bold),
          weekendStyle: TextStyle(
            color: Colors.lightBlueAccent,
          ),
//            weekdayStyle: ,
//            markersColor: Colors.lightBlueAccent,
          outsideWeekendStyle: TextStyle(
            color: Colors.blueAccent,
          ),
        ),
        calendarController: _calendarController,
      ),
    );
  }
}
