import 'dart:async';
import 'dart:convert';
import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:parker_mobile_framework/CommonService/ErrorMessage.dart';
import 'package:parker_mobile_framework/HeaterApi/HeaterStatus.dart';
import 'package:parker_mobile_framework/HeaterApi/HeaterStatusPending.dart';
import 'package:parker_mobile_framework/Pojoclass/HeaterModel.dart';
import 'package:parker_mobile_framework/Utility/MyConstants.dart';
import 'package:http/http.dart' as http;
import 'package:parker_mobile_framework/Utility/shared_preferences_util.dart';

class HeaterMainView extends StatefulWidget {
  final HeaterModel availablelist;
  HeaterMainView({
    Key key,
    this.availablelist,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HeaterView();
  }
}

String controlstatus, connectionstateUpdateTime;
String reporttime;
HeaterModel heaterModel;
Future<dynamic> putheater(String body, BuildContext context) async {
  final response = await http.put(Base_server_URL ,
      headers: <String, String>{
        'Ocp-Apim-Subscription-Key': OcpApimSubscriptionKey,
        'Content-Type': 'application/json',
      },
      body: body);
  print(response.body.toString());
  print(response.statusCode);
  if (response.body != null) {
    heaterModel = HeaterModel.fromJson(jsonDecode(response.body));
    converter(response);
    print(controlstatus.toString());
    if (controlstatus.isNotEmpty) {
      var grade = controlstatus.toString();
      switch (grade) {
        case "Failed":
        case "Fail":
          print(grade);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      HeaterStatus(availablelist: heaterModel)));
          break;
        case "Pending":
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      HeaterStatusPending(availablelist: heaterModel)));
          break;

        case "Success":
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      HeaterStatus(availablelist: heaterModel)));
          break;

        default:
          {
            print("Invalid choice");
          }
          break;
      }
    }
  }
}

void getHeaterStatus() {}

void converter(http.Response response) {
  HeaterModel heaterModel = HeaterModel.fromJson(jsonDecode(response.body));
  controlstatus = heaterModel.controlStatus.toString();
  connectionstateUpdateTime =
      heaterModel.connectionStateLastUpdatedTime.toString();
  reporttime = heaterModel.reportedTime.toString();
}

class HeaterView extends State<HeaterMainView> {
  bool isSwitched = false;
  String txtValue = "Heater is OFF";
  Map data;
  // Future<HeaterModel> _heaterValue;
  @override
  void initState() {
    super.initState();
    PreferenceUtils.init();

    print("initState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(LoginString.title),
        ),
        body: Center(
          child: Column(
             mainAxisAlignment : MainAxisAlignment.center ,
            crossAxisAlignment : CrossAxisAlignment.center,
            children: <Widget>[
              
               Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Text(LoginString.huggigheater,
                        style: TextStyle(fontSize: 18,fontStyle: FontStyle.italic,color: Colors.blueAccent),
                        textAlign: TextAlign.center),
                  ),
                ]),
               SizedBox(height: 40),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Text(LoginString.hintheater,
                        style: TextStyle(fontSize: 18,fontStyle: FontStyle.italic,color: Colors.black),
                        textAlign: TextAlign.center),
                  ),
                ]),
                SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(txtValue,
                    style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic,color: Colors.black), textAlign: TextAlign.left,),
                Switch(
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                      isSwitched == false
                          ? txtValue = "Heater is OFF"
                          : txtValue = "Heater is ON";
                      if (isSwitched == true) {
                        
                        PreferenceUtils.setString(
                            LoginString.heaterstatus, isSwitched.toString());
                        data = {"desiredHeaterState": 1};
                        String body = json.encode(data);
                        setState(() {
                          postrequest(body, context);
                        });
                      } else {
                        data = {"desiredHeaterState": 0};
                        String body = json.encode(data);
                        setState(() {
                          postrequest(body, context);
                        });
                      }
                      print(isSwitched);
                    });
                  },
                  activeTrackColor: Colors.red,
                  activeColor: Colors.green,
                )
              ],
            ),
             SizedBox(height: 100),
          ]),

          // : FutureBuilder<HeaterModel>(
          //     future: _heaterValue,
          //     builder: (context, snapshot) {
          //       if (snapshot.hasData) {
          //         if (snapshot.data.controlStatus.contains("Fail")) {
          //           SchedulerBinding.instance.addPostFrameCallback((_) {
          //           Navigator.of(context).push(
          //           MaterialPageRoute(builder: (context) => HeaterStatusPending(availablelist: snapshot.data)));
          //         });}

          //           // return HeaterStatusPending(
          //           //     availablelist: snapshot.data);
          //          else {
          //            return HeaterStatus(availablelist: snapshot.data);
          //         }
          //       } else if (snapshot.hasError) {
          //         return Text(snapshot.hasError.toString());
          //       }
          //       return CircularProgressIndicator();
          //     },
        ));
  }

  @override
  void setState(fn) {
    print("setState");
    super.setState(fn);
  }

  @override
  void deactivate() {
    print("deactivate");
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> postrequest(String body, BuildContext context) async {
    print(body);
    final HeaterModel user = await putheater(body, context);
    if (user != null) {
      print(user.controlStatus.toLowerCase());
    }
  }
}
