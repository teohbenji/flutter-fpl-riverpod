import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpl_riverpod/network/api_providers.dart';
import 'package:fpl_riverpod/network/general_info/general_info_repository.dart';

final generalInfoRepositoryProvider = Provider<GeneralInfoRepository>((ref) {
  return GeneralInfoRepository(ref.read(generalInfoAPIProvider));
});