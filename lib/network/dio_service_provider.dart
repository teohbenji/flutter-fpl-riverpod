import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpl_riverpod/network/dio_service.dart';
import 'package:fpl_riverpod/network/general_info/general_info_api.dart';

final dioServiceProvider = Provider<DioService>((ref) {
  return DioService();
});

