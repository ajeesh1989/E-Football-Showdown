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

  List<String> playerNames = [];
  String playerName = '';
  final nameController = TextEditingController();
  bool _isDeleting = false;
  bool _isEditing = true;
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
            _buildScorecardTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerNamesTab() {
    return Container(
      color: Colors.grey.shade900,
      // decoration: const BoxDecoration(
      //   image: DecorationImage(
      //     image: AssetImage('lib/pics/peakpx (3).jpg'),
      //     fit: BoxFit.cover,
      //   ),
      // ),
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
                  backgroundColor: Colors.blue, // Set your desired text color
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8), // Adjust padding
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10), // Adjust border radius
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
                  backgroundColor: Colors.red, // Set your desired text color
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8), // Adjust padding
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10), // Adjust border radius
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
                    itemExtent: 30.0, // Adjust the height as needed
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
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('lib/pics/peakpx (3).jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Card(
          color: Colors.grey.shade900,
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Matches Content',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScorecardTab() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('lib/pics/peakpx (3).jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Card(
          color: Colors.grey.shade900,
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Scorecard Content',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
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
          key: _formKey, // Add this line
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
              if (playerNames.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Added Player Names:',
                        style: TextStyle(fontSize: 16)),
                    Text(playerNames.last,
                        style: const TextStyle(fontSize: 14)),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  // functions
  void addFunction() {
    setState(
      () {
        grouphomename.put(
          'key_${nameController.text}',
          Grouphomename(
            playernamegroup: nameController.text,
          ),
        );
      },
    );
  }

  void editFunction(int index) {
    Grouphomename? ghn = grouphomename.getAt(index);
    nameController.text = ghn!.playernamegroup;
    setState(() {
      _isEditing = true;
      nameController.text = playerName;
    });

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return _buildBottomSheetContent(context);
      },
    );
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

    showSnackBar('Tournament deleted successfully');
  }

  Future<void> deleteAllData() async {
    if (_isDeleting) return;

    if (grouphomename.isEmpty) {
      // Show a message if there are no tournaments
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
      _isDeleting = true;
    });

    try {
      await grouphomename.clear();
      showSnackBar('All names deleted successfully');
    } finally {
      setState(() {
        _isDeleting = false;
      });
    }
  }

  void clearTextfields() {
    setState(() {
      nameController.clear();
    });
  }
}
