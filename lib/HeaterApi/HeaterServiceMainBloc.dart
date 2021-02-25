import 'dart:async';
import 'package:parker_mobile_framework/HeaterApi/HeaterServiceMainBlocRepo.dart';
import 'package:parker_mobile_framework/Network/ApiResponse.dart';
import 'package:parker_mobile_framework/Pojoclass/HeaterModel.dart';

class  HeaterServiceMainBloc{

  HeaterServiceMainBlocRepo _heaterServiceRepository;
  StreamController _baseServiceController;

  StreamSink<ApiResponse<HeaterModel>> get baseserviceSink =>
      _baseServiceController.sink;

  Stream<ApiResponse<HeaterModel>> get baseserviceStream =>
      _baseServiceController.stream;

  HeaterServiceMainBloc() {
    _baseServiceController =
        StreamController<ApiResponse<HeaterModel>>();
   _heaterServiceRepository = HeaterServiceMainBlocRepo();
  baseService();
 
  }

  baseService() async {
    baseserviceSink.add(ApiResponse.loading('please wait'));
    try {
      HeaterModel baseServicedata =
          await _heaterServiceRepository.fetchBaseServiceData();
      baseserviceSink.add(ApiResponse.completed(baseServicedata));
    } catch (e) {
      baseserviceSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _baseServiceController?.close();
  }

  

 
}