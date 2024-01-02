import 'package:flutter/material.dart';

class UniquePage extends StatelessWidget {
  final String taskId;

  UniquePage({required this.taskId});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Builder(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(taskId),
              bottom: const TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.sports_soccer)),
                  Tab(icon: Icon(Icons.people)),
                  Tab(icon: Icon(Icons.sports_football)),
                  Tab(icon: Icon(Icons.timer)),
                  Tab(icon: Icon(Icons.score)),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                buildTabContent('Type of Tournament Content'),
                buildTabContent('Players Content'),
                buildTabContent('Matches Content'),
                buildTabContent('Pending Matches Content'),
                buildTabContent('Scorecard Content'),
              ],
            ),
            floatingActionButton: _buildFloatingActionButton(context),
          );
        },
      ),
    );
  }

  Widget? _buildFloatingActionButton(BuildContext context) {
    final int currentTabIndex = DefaultTabController.of(context)!.index;

    if (currentTabIndex == 0 || currentTabIndex == 1) {
      return FloatingActionButton(
        onPressed: () {
          showBottomSheet(context);
        },
        child: const Icon(Icons.add),
      );
    } else {
      return null; // Return null to indicate no FloatingActionButton for other tabs
    }
  }

  Widget buildTabContent(String content) {
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              content,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }

  void showBottomSheet(BuildContext context) {
    String placeholder = '';

    switch (DefaultTabController.of(context)!.index) {
      case 0:
        placeholder = 'Enter Tournament Name';
        break;
      case 1:
        placeholder = 'Enter Player Names';
        break;
      // Handle other cases for different tabs...
    }

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 30),
                const Text('Add Content'),
                const SizedBox(height: 20),
                Form(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: placeholder,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
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
                        // Handle adding content based on the current tab
                        // You can access the entered text using the controller of the TextFormField
                        Navigator.pop(context);
                      },
                      child: const Text('Save'),
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
}
