import 'package:flutter/material.dart';
import 'package:fpl_riverpod/models/player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FPL Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FPL Players"),
      ),
      body: Center(
        child: PlayersTable(),
      ),
    );
  }
}

class PlayersDataSource extends DataTableSource {
  final List<Player> playersData;

  PlayersDataSource({required this.playersData});

  @override
  int get rowCount => playersData.length;

  @override
  DataRow? getRow(int index){
    if (index < playersData.length){
      Player player = playersData[index];
      return DataRow(
        cells: <DataCell>[
           DataCell(Text("${player.firstName} ${player.lastName}")),
           DataCell(Text(player.goals.toString())),
           DataCell(Text(player.assists.toString())),
           DataCell(Text(player.expectedGoalsPer90.toString())),
           DataCell(Text(player.expectedAssistsPer90.toString())),
           DataCell(Text(player.expectedGoalInvolvementsPer90.toString())),
           DataCell(Text(player.selectedByPercent.toString())),
           DataCell(Text(player.totalPoints.toString())),
        ]
      );
    } else {
      return null;
    }
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}

List<Player> playersData = [
  Player(firstName: 'Erling', lastName: 'Haaland', goals: 7, assists: 0, expectedGoalsPer90: 1.26, expectedAssistsPer90: 0.05, expectedGoalInvolvementsPer90: 0.31, selectedByPercent: .2, totalPoints: 41), 
  Player(firstName: 'Mohamed', lastName: 'Salah', goals: 3, assists: 3, expectedGoalsPer90: 0.58, expectedAssistsPer90: 0.35, expectedGoalInvolvementsPer90: 0.93, selectedByPercent: 40.7, totalPoints: 41),
  Player(firstName: 'Luis', lastName: 'Diaz', goals: 3, assists: 1, expectedGoalsPer90: 0.77, expectedAssistsPer90: 0.22,expectedGoalInvolvementsPer90:  0.99, selectedByPercent: 14.3, totalPoints: 32),
];

class PlayersTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: PaginatedDataTable(
          columns: const <DataColumn> [
            DataColumn(label: Text("Full Name")),
            DataColumn(label: Text("Goals")),
            DataColumn(label: Text("Assists")),
            DataColumn(label: Text("xG per 90")),
            DataColumn(label: Text("xA per 90")),
            DataColumn(label: Text("xGI per 90")),
            DataColumn(label: Text("Selected By %")),
            DataColumn(label: Text("Total Points")),
          ],
          source: PlayersDataSource(playersData: playersData),
        ),
      );
  }
}
