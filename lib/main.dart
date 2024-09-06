import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpl_riverpod/models/player.dart';
import 'package:fpl_riverpod/providers/players_provider.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
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

class PlayersTable extends ConsumerStatefulWidget {
  const PlayersTable({super.key});

  @override
  PlayersTableState createState() => PlayersTableState();
}

class PlayersTableState extends ConsumerState<PlayersTable> {
  // Initially sets UI of total points to be clicked and in descending order
  int _columnIndex = 7;
  bool _columnAscending = false;
  
  late PlayersDataSource dataSource;
  late List<Player> playersDataList;

  @override
  void initState() {
    super.initState();
    dataSource = PlayersDataSource();

    // Set these two variables only once, don't assign value again during sort/biuld
    playersDataList = ref.read(playersDataProvider).valueOrNull ?? [];
    dataSource.setData(playersDataList, _columnIndex, _columnAscending); 
  }

  void _sort(int columnIndex, bool ascending) {
    setState(() {
      _columnIndex = columnIndex;
      _columnAscending = ascending;

      dataSource.setData(playersDataList, _columnIndex, _columnAscending);
    });
  }

  @override
  Widget build(BuildContext context) {
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