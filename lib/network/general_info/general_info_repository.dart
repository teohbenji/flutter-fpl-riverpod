import 'package:flutter/material.dart';
import 'package:fpl_riverpod/models/player.dart';
import 'package:fpl_riverpod/network/general_info/general_info_api.dart';

class GeneralInfoRepository {
  final GeneralInfoAPI generalInfoAPI;

  GeneralInfoRepository(this.generalInfoAPI);

  Future<List<Player>> getAllPlayers() async {
    try {
      final response = await generalInfoAPI.getGeneralInfo();
      final String message = response['message'];
      if (message == "Success") {
        final List<dynamic> data = response["data"]["elements"]; 

        final List<Player> playersData = data.map((singleData) {
          // debugPrint('\n\n\n');
          // debugPrint('expected_goals_per_90: ${singleData["expected_goals_per_90"]}');
          // debugPrint('expected_goals_per_90 type: ${singleData["expected_goals_per_90"].runtimeType}');
          // debugPrint('expected_assists_per_90: ${singleData["expected_assists_per_90"]}');
          // debugPrint('expected_assists_per_90 type: ${singleData["expected_assists_per_90"].runtimeType}');
          // debugPrint('expected_goal_involvements_per_90: ${singleData["expected_goal_involvements_per_90"]}');
          // debugPrint('expected_goal_involvements_per_90 type: ${singleData["expected_goal_involvements_per_90"].runtimeType}');
          // const x = 1;
          // debugPrint('\n\n\n');
          // Convert singleData to a Player object
          final Player player = Player.fromJson(singleData);

          return player;
        }).toList();

        // final List<Player> playersData = 
        //    data.map((singleData) => Player.fromJson(singleData)).toList();
           
        return playersData; 
      } else {
        return [];
      }
    } catch (error) {
      debugPrint("Error in getAllPlayers: $error");
      return [];
    }
  }
}