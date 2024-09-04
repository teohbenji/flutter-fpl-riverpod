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

  late List<Player> sortedData;

  void setData(List<Player> rawData, int sortColumn,
      bool sortAscending) {
        sortedData = rawData..sort((Player a, Player b){
          switch (sortColumn) {
            // Sort by first name, if same, then sort according to last name
            case 0:
              int comparator = a.firstName.compareTo(b.firstName) * (sortAscending ? 1 : -1);
              if(comparator != 0){
                return comparator;
              } else {
                return a.lastName.compareTo(b.lastName) * (sortAscending ? 1 : -1); 
              }
            // Sort by goals
            case 1:
              return a.goals.compareTo(b.goals) * (sortAscending ? 1 : -1);
            // Sort by assists
            case 2:
              return a.assists.compareTo(b.assists) * (sortAscending ? 1 : -1);
            // Sort by xG per 90
            case 3:
              return a.expectedGoalsPer90.compareTo(b.expectedGoalsPer90) * (sortAscending ? 1 : -1);
            // Sort by xA per 90
            case 4:
              return a.expectedAssistsPer90.compareTo(b.expectedAssistsPer90) * (sortAscending ? 1 : -1);
            // Sort by xGI per 90
            case 5:
              return a.expectedGoalInvolvementsPer90.compareTo(b.expectedGoalInvolvementsPer90) * (sortAscending ? 1 : -1);
            // Sort by selected by %
            case 6:
              return a.selectedByPercent.compareTo(b.selectedByPercent) * (sortAscending ? 1 : -1);
            // Sort by total points
            case 7:
              return a.totalPoints.compareTo(b.totalPoints) * (sortAscending ? 1 : -1);
            default:
              return 0;   
          }
        }); // Cascade operator, as sorting list + assigning to variable. .sort only sorts list in place
        notifyListeners();
    }

  @override
  int get rowCount => sortedData.length;

  @override
  DataRow getRow(int index){
    final Player player = sortedData[index];

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text("${player.firstName} ${player.lastName}")),
        DataCell(Text(player.goals.toString())),
        DataCell(Text(player.assists.toString())),
        DataCell(Text(player.expectedGoalsPer90.toString())),
        DataCell(Text(player.expectedAssistsPer90.toString())),
        DataCell(Text(player.expectedGoalInvolvementsPer90.toString())),
        DataCell(Text(player.selectedByPercent.toString())),
        DataCell(Text(player.totalPoints.toString())),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}

class PlayersTable extends StatefulWidget {
  const PlayersTable({super.key});

  @override
  State<PlayersTable> createState() => _PlayersTableState();
}

class _PlayersTableState extends State<PlayersTable> {
  final PlayersDataSource dataSource = PlayersDataSource()..setData(playersDataList, 0, true);

  // Initial column filter values
  int _columnIndex = 0;
  bool _columnAscending = true;

  void _sort(int columnIndex, bool ascending) {
    setState(() {
      _columnIndex = columnIndex;
      _columnAscending = ascending;
      dataSource.setData(playersDataList, _columnIndex, _columnAscending);
    });
  }

  @override
  Widget build(BuildContext context) {
    _sort(7, false); // Sort by total points descending initially

    return PaginatedDataTable(
      sortColumnIndex: _columnIndex,
      sortAscending: _columnAscending,
      columns: <DataColumn>[
        DataColumn(
          label: const Text('Player Name'),
          onSort: _sort,
        ),
        DataColumn(
          label: const Text('Goals'),
          onSort: _sort,
        ),
        DataColumn(
          label: const Text('Assists'),
          onSort: _sort,
        ),
        DataColumn(
          label: const Text('xG per 90'),
          onSort: _sort,
        ),
        DataColumn(
          label: const Text('xA per 90'),
          onSort: _sort,
        ),
        DataColumn(
          label: const Text('xGI per 90'),
          onSort: _sort,
        ),
        DataColumn(
          label: const Text('Selected by %'),
          onSort: _sort,
        ),
        DataColumn(
          label: const Text('Total Points'),
          onSort: _sort,
        ),
      ],
      source: dataSource,
    );
  }
}

final List<Player> playersDataList = [
  Player(
    firstName: 'Erling', 
    lastName: 'Haaland', 
    goals: 7, 
    assists: 0, 
    expectedGoalsPer90: 1.26, 
    expectedAssistsPer90: 0.05, 
    expectedGoalInvolvementsPer90: 1.31, 
    selectedByPercent: .2, 
    totalPoints: 41,
  ), 

  Player(
    firstName: 'Mohamed', 
    lastName: 'Salah', 
    goals: 3, assists: 3, 
    expectedGoalsPer90: 0.58, 
    expectedAssistsPer90: 0.35, 
    expectedGoalInvolvementsPer90: 0.93, 
    selectedByPercent: 40.7, 
    totalPoints: 41,
  ),

  Player(
    firstName: 'Luis',
    lastName: 'Diaz',
    goals: 3,
    assists: 1,
    expectedGoalsPer90: 0.77,
    expectedAssistsPer90: 0.22,
    expectedGoalInvolvementsPer90: 0.99, 
    selectedByPercent: 14.3,
    totalPoints: 32,
  ),

  Player(
    firstName: 'Cody',
    lastName: 'Gakpo',
    goals: 0,
    assists: 0,
    expectedGoalsPer90: 0.37,
    expectedAssistsPer90: 0.01,
    expectedGoalInvolvementsPer90: 0.38, 
    selectedByPercent: 2.3,
    totalPoints: 2,
  ),

  Player(
    firstName: 'Joe',
    lastName: 'Gomez',
    goals: 0,
    assists: 0,
    expectedGoalsPer90: 0,
    expectedAssistsPer90: 0,
    expectedGoalInvolvementsPer90: 0, 
    selectedByPercent: 0.5,
    totalPoints: 0,
  ),

  Player(
    firstName: 'Ryan',
    lastName: 'Gravenberch',
    goals: 0,
    assists: 0,
    expectedGoalsPer90: 0,
    expectedAssistsPer90: 0.51,
    expectedGoalInvolvementsPer90: 0.51, 
    selectedByPercent: 0.4,
    totalPoints: 8,
  ),

  Player(
    firstName: 'Curtis',
    lastName: 'Jones',
    goals: 0,
    assists: 0,
    expectedGoalsPer90: 0,
    expectedAssistsPer90: 0,
    expectedGoalInvolvementsPer90: 0, 
    selectedByPercent: 0.5,
    totalPoints: 0,
  ),

  Player(
    firstName: 'Caoimhin',
    lastName: 'Kelleher',
    goals: 0,
    assists: 0,
    expectedGoalsPer90: 0,
    expectedAssistsPer90: 0,
    expectedGoalInvolvementsPer90: 0, 
    selectedByPercent: 0.2,
    totalPoints: 0,
  ),

  Player(
    firstName: 'Ibrahima',
    lastName: 'Konaté',
    goals: 0,
    assists: 0,
    expectedGoalsPer90: 0,
    expectedAssistsPer90: 0,
    expectedGoalInvolvementsPer90: 0, 
    selectedByPercent: 0.6,
    totalPoints: 14,
  ),

  Player(
    firstName: 'Conor',
    lastName: 'Chaplin',
    goals: 0,
    assists: 0,
    expectedGoalsPer90: 0,
    expectedAssistsPer90: 0.03,
    expectedGoalInvolvementsPer90: 0.03, 
    selectedByPercent: 0.2,
    totalPoints: 4,
  ),

  Player(
    firstName: 'Conor',
    lastName: 'Bradley',
    goals: 0,
    assists: 0,
    expectedGoalsPer90: 0.48,
    expectedAssistsPer90: 0.28,
    expectedGoalInvolvementsPer90: 0.76, 
    selectedByPercent: 0.5,
    totalPoints: 3,
  ),
];