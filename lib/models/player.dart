import 'package:fpl_riverpod/utils/helpers/players/get_player_position.dart';
import 'package:fpl_riverpod/utils/helpers/players/get_player_team.dart';

class Player {
  final String position;
  final String team;
  final String name;
  final String price;
  final int starts;
  final int goals;
  final int assists;
  final double expectedGoalsPer90;
  final double expectedAssistsPer90;
  final double expectedGoalInvolvementsPer90;
  final String creativityPer90;
  final String threatPer90;
  final String selectedByPercent;
  final int totalPoints;

  Player({
    required this.position,
    required this.team,
    required this.name,
    required this.price,
    required this.starts,
    required this.goals,
    required this.assists,
    required this.expectedGoalsPer90,
    required this.expectedAssistsPer90,
    required this.expectedGoalInvolvementsPer90,
    required this.creativityPer90,
    required this.threatPer90,
    required this.selectedByPercent,
    required this.totalPoints,
  });

  // Maps json data to player object
  Player.fromJson(Map<String, dynamic> json)
    : position = getPlayerPosition(json['element_type']),
      name = json['web_name'].toString(), 
      team = getPlayerTeam(json['team']),
      goals = json['goals_scored'],
      assists = json['assists'],
      price = (json['now_cost'] / 10).toStringAsFixed(1), //Provided price is * 10 of actual
      starts = json['starts'],
      expectedGoalsPer90 = json['expected_goals_per_90'],
      expectedAssistsPer90 = json['expected_assists_per_90'],
      expectedGoalInvolvementsPer90 = json['expected_goal_involvements_per_90'],
      creativityPer90 = (double.parse(json['creativity']) / 90).toStringAsFixed(2),
      threatPer90 = (double.parse(json['threat']) / 90).toStringAsFixed(2),
      selectedByPercent = double.parse(json['selected_by_percent']).toStringAsFixed(1),
      totalPoints = json['total_points'];
}
