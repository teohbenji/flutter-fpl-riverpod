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
}
