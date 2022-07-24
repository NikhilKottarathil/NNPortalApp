import 'package:flutter/material.dart';

class TimeUtils{

  DateTime dateTimeFromTimeAndDate(TimeOfDay timeOfDay,{DateTime? dateTime}){

    DateTime date=dateTime??DateTime.now();


    DateTime d=DateTime(date.year,date.month,date.day,timeOfDay.hour,timeOfDay.minute,0,0,0);
    print('in Date $date time $timeOfDay');
    print('out Date $d');
    return  d;


  }
}



