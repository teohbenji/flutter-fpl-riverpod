import 'package:fpl_riverpod/network/dio_service.dart';

class GeneralInfoAPI {
  final DioService dioService;

  GeneralInfoAPI(this.dioService);

  Future<Map<String, dynamic>> getGeneralInfo() async {
    final response = await dioService.get(
      '/api/bootstrap-static',
    );
    return response.data;
  }
}