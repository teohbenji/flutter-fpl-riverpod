class Player {
  final String firstName;
  final String lastName;
  final int goals;
  final int assists;
  final double expectedGoalsPer90;
  final double expectedAssistsPer90;
  final double expectedGoalInvolvementsPer90;
  final double selectedByPercent;
  final int totalPoints;

  Player({
    required this.firstName,
    required this.lastName,
    required this.goals,
    required this.assists,
    required this.expectedGoalsPer90,
    required this.expectedAssistsPer90,
    required this.expectedGoalInvolvementsPer90,
    required this.selectedByPercent,
    required this.totalPoints,
  });

  // Maps json data to player object
  Player.fromJson(Map<String, dynamic> json)
    : firstName = json['first_name'].toString(), 
      lastName = json['second_name'].toString(),
      goals = json['goals_scored'],
      assists = json['assists'],
      expectedGoalsPer90 = json['expected_goals_per_90'],
      expectedAssistsPer90 = json['expected_assists_per_90'],
      expectedGoalInvolvementsPer90 = json['expected_goal_involvements_per_90'],
      selectedByPercent = double.parse(json['selected_by_percent']),
      totalPoints = json['total_points'];
}
