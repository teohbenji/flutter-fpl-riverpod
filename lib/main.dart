import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpl_riverpod/models/player.dart';
import 'package:fpl_riverpod/providers/players_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
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
      body: const Center(
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
            // Sort by position
            case 1:
              return a.position.compareTo(b.position) * (sortAscending ? 1 : -1);
            // Sort by first name, if same, then sort according to last name
            case 2:
              int comparator = a.firstName.compareTo(b.firstName) * (sortAscending ? 1 : -1);
              if(comparator != 0){
                return comparator;
              } else {
                return a.lastName.compareTo(b.lastName) * (sortAscending ? 1 : -1); 
              }
            // Sort by team
            case 3:
              return a.team.compareTo(b.team) * (sortAscending ? 1 : -1);
            // Sort by price
            case 4:
              return double.parse(a.price).compareTo(double.parse(b.price)) * (sortAscending ? 1 : -1);   
            // Sort by starts
            case 5:
              return a.starts.compareTo(b.starts) * (sortAscending ? 1 : -1);
            // Sort by goals
            case 6:
              return a.goals.compareTo(b.goals) * (sortAscending ? 1 : -1);
            // Sort by assists
            case 7:
              return a.assists.compareTo(b.assists) * (sortAscending ? 1 : -1);
            // Sort by xG per 90
            case 8:
              return a.expectedGoalsPer90.compareTo(b.expectedGoalsPer90) * (sortAscending ? 1 : -1);
            // Sort by xA per 90
            case 9:
              return a.expectedAssistsPer90.compareTo(b.expectedAssistsPer90) * (sortAscending ? 1 : -1);
            // Sort by xGI per 90
            case 10:
              return a.expectedGoalInvolvementsPer90.compareTo(b.expectedGoalInvolvementsPer90) * (sortAscending ? 1 : -1);
            // Sort by creativity per 90
            case 11:
              return double.parse(a.creativityPer90).compareTo(double.parse(b.creativityPer90)) * (sortAscending ? 1 : -1);
            // Sort by threat per 90
            case 12:
              return double.parse(a.threatPer90).compareTo(double.parse(b.threatPer90)) * (sortAscending ? 1 : -1);
            // Sort by selected by %
            case 13:
              return double.parse(a.selectedByPercent).compareTo(double.parse(b.selectedByPercent)) * (sortAscending ? 1 : -1);
            // Sort by total points
            case 14:
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
    final int rank = index + 1;

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text("$rank")),
        DataCell(Text(player.position.toString())),
        DataCell(Text("${player.firstName} ${player.lastName}")),
        DataCell(Text(player.team.toString())),
        DataCell(Text(player.price.toString())),
        DataCell(Text(player.starts.toString())),
        DataCell(Text(player.goals.toString())),
        DataCell(Text(player.assists.toString())),
        DataCell(Text(player.expectedGoalsPer90.toString())),
        DataCell(Text(player.expectedAssistsPer90.toString())),
        DataCell(Text(player.expectedGoalInvolvementsPer90.toString())),
        DataCell(Text(player.creativityPer90.toString())),
        DataCell(Text(player.threatPer90.toString())),
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
  int _columnIndex = 14; 
  bool _columnAscending = false;

  late PlayersDataSource dataSource;

  @override
  void initState() {
    super.initState();
    dataSource = PlayersDataSource();
  }

  void _sort(int columnIndex, bool ascending) {
    setState(() {
      _columnIndex = columnIndex;
      _columnAscending = ascending;

      final playersDataList = ref.read(playersDataProvider).value ?? [];

      dataSource.setData(playersDataList, _columnIndex, _columnAscending);
    });
  }

  @override
  Widget build(BuildContext context) {
    final playersDataList = ref.watch(playersDataProvider).value ?? [];

    dataSource.setData(playersDataList, _columnIndex, _columnAscending);

    return PaginatedDataTable(
      sortColumnIndex: _columnIndex,
      sortAscending: _columnAscending,
      columns: <DataColumn>[
        const DataColumn(
          label: Text('Rank'),
        ),
        DataColumn(
          label: const Text('Position'),
          onSort: _sort,
        ),
        DataColumn(
          label: const Text('Player Name'),
          onSort: _sort,
        ),
        DataColumn(
          label: const Text('Team'),
          onSort: _sort,
        ),
        DataColumn(
          label: const Text('Price'),
          onSort: _sort,
        ),
        DataColumn(
          label: const Text('Starts'),
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
          label: const Text('Creativity per 90'),
          onSort: _sort,
        ),
        DataColumn(
          label: const Text('Threat per 90'),
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
