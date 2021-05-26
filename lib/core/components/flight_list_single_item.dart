import 'package:capstone_project/core/constants/app_colors.dart';
import 'package:capstone_project/views/flight_list/Model/flight_log_item_model.dart';
import 'package:flutter/material.dart';

class FlightListSingleItem extends StatelessWidget {
  const FlightListSingleItem({
    Key? key,
    required this.queryData,
    required this.data
  }) : super(key: key);

  final MediaQueryData queryData;
  final FlightLogItemModel data;
  @override
  Widget build(BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(top: 5.0, bottom:5.0),
          child: Stack(
            alignment: Alignment.center,
            children: [

              Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 0.15),
              borderRadius: BorderRadius.all(Radius.circular(30))

            ),
            child:Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(children: [
                    Expanded(flex: 1,child: Center(child: Column(
                      children: createDoubleText("Flight Date",data.date),
                    ))),
                    Expanded(flex: 1,child: Center(child: Column(
                      children: createDoubleText("Start Time", data.time),
                    )))
                  ],),
                  Center(child: Column(
                    children:createDoubleText("Duration", data.duration)
                  ))
              ],),
            ),
          width: queryData.size.width*0.87,height: queryData.size.height*0.11,),
        ],
      ),
    );
  }

  List<Widget> createDoubleText(String label, String info) {
    return [
      Text(label, style: TextStyle(color: Colors.white),),
      Text(info, style: TextStyle(color: Colors.white)),];
  }
}