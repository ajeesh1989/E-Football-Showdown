import 'package:flutter/material.dart';
import 'package:shared_pre_hive_sampleproject/model3/grouphomename.dart';
import 'package:hive/hive.dart';

class UniquePage extends StatefulWidget {
  final String taskId;

  UniquePage({required this.taskId});

  @override
  _UniquePageState createState() => _UniquePageState();
}

class _UniquePageState extends State<UniquePage> {
  late Box<Grouphomename> grouphomename;
  String playerName = '';
  final nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    grouphomename = Hive.box<Grouphomename>('TaskBox3');
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.taskId),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.people)),
              Tab(icon: Icon(Icons.sports_football)),
              Tab(icon: Icon(Icons.score)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildPlayerNamesTab(),
            _buildMatchesTab(),
            _buildScorecardTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerNamesTab() {
    return Container(
      color: Colors.grey.shade900,
      child: Column(
        children: [
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  _showBottomSheet(context);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Add Names', style: TextStyle(fontSize: 14)),
              ),
              ElevatedButton(
                onPressed: () {
                  deleteAllData();
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Delete All', style: TextStyle(fontSize: 14)),
              ),
            ],
          ),
          Expanded(
            child: grouphomename.isEmpty
                ? const Center(
                    child: Text(
                      'No players available',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : ListView.builder(
                    itemCount: grouphomename.length,
                    itemExtent: 30.0,
                    itemBuilder: (context, index) {
                      Grouphomename? ghn = grouphomename.getAt(index);

                      return ListTile(
                        title: Text(
                          '${index + 1}. ${ghn?.playernamegroup ?? ''}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                editFunction(index);
                              },
                              icon:
                                  const Icon(Icons.edit, color: Colors.yellow),
                            ),
                            IconButton(
                              onPressed: () {
                                deleteOneData(context, index);
                              },
                              icon: const Icon(Icons.delete, color: Colors.red),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchesTab() {
    List<List<String>> fixtures = generateFixtures();

    return Container(
      color: Colors.black87,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 16.0),
            Center(
              child: fixtures.isEmpty
                  ? const Text(
                      'No matches available',
                      style: TextStyle(color: Colors.white),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: fixtures.asMap().entries.map((roundEntry) {
                        int roundNumber = roundEntry.key + 1;
                        List<String> roundFixtures = roundEntry.value;

                        return Card(
                          color: Colors.grey.shade900,
                          elevation: 8.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          margin: const EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 24.0,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Form(
                              key: Key(
                                  'round_$roundNumber'), // Unique key for each form
                              child: Column(
                                children: [
                                  Text(
                                    'Round $roundNumber',
                                    style: const TextStyle(
                                      color: Colors.orange,
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 16.0),
                                  ...roundFixtures
                                      .asMap()
                                      .entries
                                      .map((matchEntry) {
                                    int matchIndex = matchEntry.key;
                                    String fixture = matchEntry.value;

                                    return Container(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  fixture,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 120.0,
                                                child: Row(
                                                  children: [
                                                    Flexible(
                                                      child: Form(
                                                        child: TextFormField(
                                                          key: Key(
                                                              'teamA_$roundNumber$matchIndex'), // Unique key for each text field
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                          decoration:
                                                              InputDecoration(
                                                            fillColor: Colors
                                                                .grey.shade800,
                                                            filled: true,
                                                            border:
                                                                const OutlineInputBorder(),
                                                            hintText: 'A',
                                                            hintStyle:
                                                                const TextStyle(
                                                              color: Colors
                                                                  .white70,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8.0),
                                                    Flexible(
                                                      child: Form(
                                                        child: TextFormField(
                                                          key: Key(
                                                              'teamB_$roundNumber$matchIndex'), // Unique key for each text field
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                          decoration:
                                                              InputDecoration(
                                                            fillColor: Colors
                                                                .grey.shade800,
                                                            filled: true,
                                                            border:
                                                                const OutlineInputBorder(),
                                                            hintText: 'B',
                                                            hintStyle:
                                                                const TextStyle(
                                                              color: Colors
                                                                  .white70,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 16.0),
                                          ElevatedButton(
                                            onPressed: () => _submitScores(
                                              roundNumber,
                                              matchIndex,
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 39, 77, 96),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 12.0,
                                              ),
                                            ),
                                            child: const Text(
                                              '  Submit  ',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitScores(int roundNumber, int matchIndex) {
    // Add your logic to handle the submitted scores
    // You can access the scores using the controller values
    // For example:
    // teamAScoreController.text
    // teamBScoreController.text

    // Example: Print the round and match index for demonstration
    print('Round $roundNumber, Match $matchIndex submitted');
  }

  List<List<String>> generateFixtures() {
    List<List<String>> fixtures = [];

    List<String> playerNames = List<String>.from(
        grouphomename.values.map((ghn) => ghn.playernamegroup));
    playerNames.sort();

    int n = playerNames.length;
    int totalRounds = n - 1;

    for (int round = 0; round < totalRounds; round++) {
      List<String> roundFixtures = [];
      for (int i = 0; i < n / 2; i++) {
        String fixture = '${playerNames[i]} vs ${playerNames[n - 1 - i]}';
        roundFixtures.add(fixture);
      }
      fixtures.add(roundFixtures);

      // Rotate the array for the next round
      playerNames.insert(1, playerNames.removeLast());
    }

    return fixtures;
  }

  Widget _buildScorecardTable() {
    List<String> playerNames = List<String>.from(
        grouphomename.values.map((ghn) => ghn.playernamegroup));

    playerNames.sort();

    playerNames.sort((a, b) {
      // Replace this logic with your actual calculation for points
      int pointsA =
          0; // Calculate points for player a (replace with actual logic)
      int pointsB =
          0; // Calculate points for player b (replace with actual logic)
      return pointsB.compareTo(pointsA);
    });

    List<DataRow> dataRows = playerNames.map((name) {
      int points = 0; // Replace with your actual data
      int matchesPlayed = 0; // Replace with your actual data
      int won = 0; // Replace with your actual data
      int draw = 0; // Replace with your actual data
      int loss = 0; // Replace with your actual data
      int goalsScored = 0; // Replace with your actual data
      int goalsConceded = 0; // Replace with your actual data

      // Calculate other values based on your logic
      int goalDifference = goalsScored - goalsConceded;
      double percentage = (won / matchesPlayed) * 100;

      return DataRow(
        cells: [
          DataCell(
            Text((playerNames.indexOf(name) + 1).toString(),
                style: const TextStyle(color: Colors.white)),
          ),
          DataCell(
            Text(name, style: const TextStyle(color: Colors.white)),
          ),
          DataCell(
            Text(points.toString(),
                style: const TextStyle(color: Colors.white)),
          ),
          DataCell(
            Text(matchesPlayed.toString(),
                style: const TextStyle(color: Colors.white)),
          ),
          DataCell(
            Text(won.toString(), style: const TextStyle(color: Colors.white)),
          ),
          DataCell(
            Text(draw.toString(), style: const TextStyle(color: Colors.white)),
          ),
          DataCell(
            Text(loss.toString(), style: const TextStyle(color: Colors.white)),
          ),
          DataCell(
            Text(goalsScored.toString(),
                style: const TextStyle(color: Colors.white)),
          ),
          DataCell(
            Text(goalsConceded.toString(),
                style: const TextStyle(color: Colors.white)),
          ),
          DataCell(
            Text(goalDifference.toString(),
                style: const TextStyle(color: Colors.white)),
          ),
          DataCell(
            Text(percentage.toStringAsFixed(2) + '%',
                style: const TextStyle(color: Colors.white)),
          ),
        ],
      );
    }).toList();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(
            label: Text('Rank', style: TextStyle(color: Colors.red)),
          ),
          DataColumn(
            label: Text('Player Names', style: TextStyle(color: Colors.red)),
          ),
          DataColumn(
            label: Text('Points', style: TextStyle(color: Colors.red)),
          ),
          DataColumn(
            label: Text('MP', style: TextStyle(color: Colors.red)),
          ),
          DataColumn(
            label: Text('Won', style: TextStyle(color: Colors.red)),
          ),
          DataColumn(
            label: Text('Draw', style: TextStyle(color: Colors.red)),
          ),
          DataColumn(
            label: Text('Loss', style: TextStyle(color: Colors.red)),
          ),
          DataColumn(
            label: Text('GS', style: TextStyle(color: Colors.red)),
          ),
          DataColumn(
            label: Text('GC', style: TextStyle(color: Colors.red)),
          ),
          DataColumn(
            label: Text('GD', style: TextStyle(color: Colors.red)),
          ),
          DataColumn(
            label: Text('Percentage', style: TextStyle(color: Colors.red)),
          ),
        ],
        rows: dataRows,
        // ignore: deprecated_member_use
        dataRowHeight: 40.0,
        headingRowHeight: 50.0,
        headingTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
        decoration: const BoxDecoration(color: Colors.black),
      ),
    );
  }

  TableRow _buildScorecardTableRow(String label, List<String> playerNames) {
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              label,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        ...playerNames.map((name) {
          String data = 'Data'; // Replace with your actual data
          return TableCell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                data,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return _buildBottomSheetContent(context);
      },
    );
  }

  Widget _buildBottomSheetContent(BuildContext context) {
    String placeholder = 'Enter Player Name';

    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.85,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 30),
              const Text('Add Content'),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: placeholder,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      playerName = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Player name is required';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        setState(() {
                          addFunction();
                          clearTextfields();
                        });
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Save'),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
              const SizedBox(height: 20),
              if (grouphomename.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Added Player Names:',
                        style: TextStyle(fontSize: 16)),
                    Text(
                      grouphomename.values.last.playernamegroup,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  void addFunction() {
    // Check if the name already exists
    if (grouphomename.values
        .any((ghn) => ghn.playernamegroup == playerName.trim())) {
      // Show a Snackbar for duplicate name
      showSnackBar('Player name already exists');
      return; // Do not proceed if the name already exists
    }

    setState(() {
      grouphomename.add(
        Grouphomename(
          playernamegroup: playerName.trim(),
        ),
      );
    });

    // Show a Snackbar for successful addition
    showSnackBar('Player added successfully');
  }

  void editFunction(int index) {
    Grouphomename? ghn = grouphomename.getAt(index);
    nameController.text = ghn!.playernamegroup;

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        double screenHeight = MediaQuery.of(context).size.height;

        return Container(
          height: screenHeight * 0.9,
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextFormField(
                          controller: nameController,
                          maxLength: 20,
                          decoration: InputDecoration(
                            hintText: 'Player name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Player name is required';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Close'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          // Check for duplicate name
                          if (isDuplicateName(
                              nameController.text.trim(), index)) {
                            // Show Snackbar for duplicate name
                            showSnackBar('Player name already exists');
                          } else {
                            grouphomename.putAt(
                              index,
                              Grouphomename(
                                playernamegroup: nameController.text.trim(),
                              ),
                            );
                            clearTextfields();
                            Navigator.pop(context);
                            showSnackBar('Player name updated successfully');
                          }
                        }
                      },
                      child: const Text('Update'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  bool isDuplicateName(String newName, int currentIndex) {
    for (int i = 0; i < grouphomename.length; i++) {
      if (i != currentIndex &&
          grouphomename.getAt(i)?.playernamegroup.trim() == newName) {
        return true;
      }
    }
    return false;
  }

  void deleteOneData(BuildContext context, int index) async {
    bool deleteConfirmed = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this name?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (deleteConfirmed == null || !deleteConfirmed) {
      return;
    }

    setState(() {
      grouphomename.deleteAt(index);
    });

    showSnackBar('Player deleted successfully');
  }

  Future<void> deleteAllData() async {
    if (grouphomename.isEmpty) {
      // Show a message if there are no names
      showSnackBar('No names to delete.');
      return;
    }

    bool deleteConfirmed = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete all names?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (deleteConfirmed == null || !deleteConfirmed) {
      return;
    }

    setState(() {
      grouphomename.clear();
    });

    showSnackBar('All names deleted successfully');
  }

  void clearTextfields() {
    setState(() {
      nameController.clear();
    });
  }
}
