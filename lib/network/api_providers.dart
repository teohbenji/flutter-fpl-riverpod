import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpl_riverpod/network/dio_service_provider.dart';
import 'package:fpl_riverpod/network/general_info/general_info_api.dart';

final generalInfoAPIProvider = Provider<GeneralInfoAPI>((ref){
  final dioService = ref.watch(dioServiceProvider);
  return GeneralInfoAPI(dioService);
});