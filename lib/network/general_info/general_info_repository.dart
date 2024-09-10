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
          final Player player = Player.fromJson(singleData);

          return player;
        }).toList();
           
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