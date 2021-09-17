import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // location name for the UI
  late String time; // time at the specified location
  String flag; // url to asset flag icon
  String url; // location url for api endpoint
  bool isDayTime = true; // is day or not

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      Response response =
          await get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      // print(data);

      // get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      // String posNeg = data['utc_offset'].substring(0, 1);

      // Create DateTime obj
      // print(datetime);
      DateTime now = DateTime.parse(datetime);
      // print(now);
      now = now.add(Duration(
        hours: int.parse(offset),
      ));

      // set the time property
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print(e);
      time = 'could not get time data';
    }
  }
}
