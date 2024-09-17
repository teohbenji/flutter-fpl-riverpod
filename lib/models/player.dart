import 'package:fpl_riverpod/utils/helpers/players/get_player_position.dart';
import 'package:fpl_riverpod/utils/helpers/players/get_player_team.dart';

class Player {
  final String position;
  final String team;
  final String firstName;
  final String lastName;
  final String price;
  final int starts;
  final int minutes;
  final int goals;
  final int assists;
  final double expectedGoalsPer90;
  final double expectedAssistsPer90;
  final double expectedGoalInvolvementsPer90;
  final double ictIndex;
  final double selectedByPercent;
  final int totalPoints;

  Player({
    required this.position,
    required this.team,
    required this.firstName,
    required this.lastName,
    required this.price,
    required this.starts,
    required this.minutes,
    required this.goals,
    required this.assists,
    required this.expectedGoalsPer90,
    required this.expectedAssistsPer90,
    required this.expectedGoalInvolvementsPer90,
    required this.ictIndex,
    required this.selectedByPercent,
    required this.totalPoints,
  });

  // Maps json data to player object
  Player.fromJson(Map<String, dynamic> json)
    : position = getPlayerPosition(json['element_type']),
      team = getPlayerTeam(json['team']),
      firstName = json['first_name'].toString(), 
      lastName = json['second_name'].toString(),
      goals = json['goals_scored'],
      assists = json['assists'],
      price = (json['now_cost'] / 10).toStringAsFixed(1), //Provided price is * 10 of actual
      starts = json['starts'],
      minutes = json['minutes'],
      expectedGoalsPer90 = json['expected_goals_per_90'],
      expectedAssistsPer90 = json['expected_assists_per_90'],
      expectedGoalInvolvementsPer90 = json['expected_goal_involvements_per_90'],
      ictIndex = double.parse(json['ict_index']),
      selectedByPercent = double.parse(json['selected_by_percent']),
      totalPoints = json['total_points'];
}
