
import 'package:capstone_project/core/base/view/base_widget.dart';
import 'package:capstone_project/core/components/flight_list_single_item.dart';
import 'package:capstone_project/core/components/logo.dart';
import 'package:capstone_project/core/constants/app_colors.dart';
import 'package:capstone_project/core/constants/text_constants.dart';
import 'package:capstone_project/views/flight_list/view_model/flight_list_view_model.dart';
import 'package:capstone_project/views/hompage/view_model/log/flightlog_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';



class FlightListView extends StatelessWidget {



  @override
  Widget build(BuildContext context) {

    MediaQueryData queryData = MediaQuery.of(context);
    return BaseView<FlightListViewModel>(
      viewModel: FlightListViewModel(),
      onPageBuilder: (context, flightListViewModel) => Container(
        decoration: BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: buildAppBar(queryData, flightListViewModel),  
          body: Column(
            children: [
              Center(child:Text("All Flights", style: TextConstants.home_screen_35)),
              Expanded(
                child:RefreshIndicator(
                  child: Observer(
                    builder: (context){
                      print("\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\");
                      return ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      controller: flightListViewModel.scrollController,
                      itemCount: flightListViewModel.flights.length,
                      itemBuilder: (context, index){
                        print("index: ${index}");
                        return FlightListSingleItem(queryData: queryData, data: flightListViewModel.flights[index]);
                      },
                    );
                    }
                  ),
                  onRefresh: flightListViewModel.getDocuments
                )
              ),
            ],
          ),
        )
      ),
       onModelReady: (model){
         print("flvm on onmodelready");
         model.setContext(context);
         model.init();
       }
       
    );
  }

  AppBar buildAppBar(MediaQueryData queryData, FlightListViewModel flightListViewModel) {
    return AppBar(
          backgroundColor: Colors.transparent ,
          foregroundColor: Colors.transparent,
          leading: Padding(
            padding: EdgeInsets.all(8.0),
            child: SizedBox(
              width:queryData.size.height*0.04
            ),
          ),
          centerTitle: true,
          title: ZettLogo(height:queryData.size.height*0.045),  
          actions: <Widget>[Padding(
            padding: const EdgeInsets.all(8.0),
            child:  Observer(
              builder: (_){
                print("++++++++++++++++++++");
                print(flightListViewModel.dropDownValue);
                return DropdownButton(
                value: flightListViewModel.dropDownValue,
                items: flightListViewModel.dropdownWidgetList,
                onChanged: flightListViewModel.dropDownValueChanged,
                );
              },
              )
          )],
          elevation: 0,
        );
  }
  
}

