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

// final playersDataProvider = StateProvider<List<Player>>((ref) {
//   //TODO: MODIFY THIS
//   return [
//   Player(
//     firstName: 'Erling', 
//     lastName: 'Haaland', 
//     goals: 7, 
//     assists: 0, 
//     expectedGoalsPer90: 1.26, 
//     expectedAssistsPer90: 0.05, 
//     expectedGoalInvolvementsPer90: 1.31, 
//     selectedByPercent: .2, 
//     totalPoints: 41,
//   ), 

//   Player(
//     firstName: 'Mohamed', 
//     lastName: 'Salah', 
//     goals: 3, assists: 3, 
//     expectedGoalsPer90: 0.58, 
//     expectedAssistsPer90: 0.35, 
//     expectedGoalInvolvementsPer90: 0.93, 
//     selectedByPercent: 40.7, 
//     totalPoints: 41,
//   ),

//   Player(
//     firstName: 'Luis',
//     lastName: 'Diaz',
//     goals: 3,
//     assists: 1,
//     expectedGoalsPer90: 0.77,
//     expectedAssistsPer90: 0.22,
//     expectedGoalInvolvementsPer90: 0.99, 
//     selectedByPercent: 14.3,
//     totalPoints: 32,
//   ),

//   Player(
//     firstName: 'Cody',
//     lastName: 'Gakpo',
//     goals: 0,
//     assists: 0,
//     expectedGoalsPer90: 0.37,
//     expectedAssistsPer90: 0.01,
//     expectedGoalInvolvementsPer90: 0.38, 
//     selectedByPercent: 2.3,
//     totalPoints: 2,
//   ),

//   Player(
//     firstName: 'Joe',
//     lastName: 'Gomez',
//     goals: 0,
//     assists: 0,
//     expectedGoalsPer90: 0,
//     expectedAssistsPer90: 0,
//     expectedGoalInvolvementsPer90: 0, 
//     selectedByPercent: 0.5,
//     totalPoints: 0,
//   ),

//   Player(
//     firstName: 'Ryan',
//     lastName: 'Gravenberch',
//     goals: 0,
//     assists: 0,
//     expectedGoalsPer90: 0,
//     expectedAssistsPer90: 0.51,
//     expectedGoalInvolvementsPer90: 0.51, 
//     selectedByPercent: 0.4,
//     totalPoints: 8,
//   ),

//   Player(
//     firstName: 'Curtis',
//     lastName: 'Jones',
//     goals: 0,
//     assists: 0,
//     expectedGoalsPer90: 0,
//     expectedAssistsPer90: 0,
//     expectedGoalInvolvementsPer90: 0, 
//     selectedByPercent: 0.5,
//     totalPoints: 0,
//   ),

//   Player(
//     firstName: 'Caoimhin',
//     lastName: 'Kelleher',
//     goals: 0,
//     assists: 0,
//     expectedGoalsPer90: 0,
//     expectedAssistsPer90: 0,
//     expectedGoalInvolvementsPer90: 0, 
//     selectedByPercent: 0.2,
//     totalPoints: 0,
//   ),

//   Player(
//     firstName: 'Ibrahima',
//     lastName: 'Konaté',
//     goals: 0,
//     assists: 0,
//     expectedGoalsPer90: 0,
//     expectedAssistsPer90: 0,
//     expectedGoalInvolvementsPer90: 0, 
//     selectedByPercent: 0.6,
//     totalPoints: 14,
//   ),

//   Player(
//     firstName: 'Conor',
//     lastName: 'Chaplin',
//     goals: 0,
//     assists: 0,
//     expectedGoalsPer90: 0,
//     expectedAssistsPer90: 0.03,
//     expectedGoalInvolvementsPer90: 0.03, 
//     selectedByPercent: 0.2,
//     totalPoints: 4,
//   ),

//   Player(
//     firstName: 'Conor',
//     lastName: 'Bradley',
//     goals: 0,
//     assists: 0,
//     expectedGoalsPer90: 0.48,
//     expectedAssistsPer90: 0.28,
//     expectedGoalInvolvementsPer90: 0.76, 
//     selectedByPercent: 0.5,
//     totalPoints: 3,
//   ),
//   ];
// });