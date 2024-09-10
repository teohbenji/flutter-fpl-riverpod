import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpl_riverpod/models/player.dart';
import 'package:fpl_riverpod/network/repository_providers.dart';

class PlayersNotifier extends AsyncNotifier<List<Player>> {
  @override
  Future<List<Player>> build() async {
    try {
      final List<Player> playersDataList = 
        await ref.watch(generalInfoRepositoryProvider).getAllPlayers();
      return playersDataList;
    } catch (error) {
      return [];
    }
  }
}

final playersDataProvider = AsyncNotifierProvider<PlayersNotifier, List<Player>>(
  () => PlayersNotifier(),
);