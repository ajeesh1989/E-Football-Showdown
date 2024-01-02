import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:shared_pre_hive_sampleproject/box.dart';
import 'package:shared_pre_hive_sampleproject/details.dart';
import 'package:shared_pre_hive_sampleproject/login.dart';
import 'package:shared_pre_hive_sampleproject/model/task.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class KnockoutHome extends StatefulWidget {
  final String loginName;

  const KnockoutHome({
    Key? key,
    required this.loginName,
  }) : super(key: key);

  @override
  State<KnockoutHome> createState() => _KnockoutHomeState();
}

class _KnockoutHomeState extends State<KnockoutHome> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  bool _isDeleting = false;
  bool _isImageLoaded = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/pics/peakpx (3).jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBar(
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  title: const Text('Knockout Style'),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: boxTasks2.isEmpty
                      ? Center(
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.all(15),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'lib/pics/no-data.png', // Replace with your GIF file
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'No tournaments added yet.',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Click the button below to add a tournament!',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: boxTasks2.length,
                          itemBuilder: (context, index) {
                            Task task = boxTasks2.getAt(index);
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        UniquePage(taskId: task.title),
                                  ),
                                );
                              },
                              child: Slidable(
                                key: const ValueKey(0),
                                endActionPane: ActionPane(
                                  motion: const DrawerMotion(),
                                  children: [
                                    SlidableAction(
                                      autoClose: true,
                                      flex: 1,
                                      onPressed: (value) {
                                        setState(() {
                                          editFunction(index);
                                        });
                                      },
                                      backgroundColor: Colors.grey.shade700,
                                      foregroundColor: Colors.white,
                                      icon: Icons.edit,
                                      label: 'Edit',
                                    ),
                                    SlidableAction(
                                      autoClose: true,
                                      flex: 1,
                                      onPressed: (value) {
                                        setState(() {
                                          deleteOneData(context, index);
                                        });
                                      },
                                      backgroundColor: Colors.grey.shade900,
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    color: Colors.grey.shade900,
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.sports_soccer,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              task.title,
                                              maxLines:
                                                  1, // Set the maximum number of lines to display
                                              overflow: TextOverflow
                                                  .ellipsis, // Use ellipsis (...) for overflow
                                              style: const TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: SpeedDial(
        backgroundColor: Colors.blueGrey.shade900,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: const IconThemeData(
          size: 22.0,
          color: Colors.white,
        ),
        visible: true,
        curve: Curves.bounceInOut,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.add, color: Colors.white),
            backgroundColor: const Color.fromARGB(255, 22, 75, 101),
            label: 'Add Tournament',
            labelStyle: const TextStyle(fontSize: 18.0, color: Colors.black),
            onTap: () {
              openBottomSheet();
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.delete, color: Colors.white),
            backgroundColor: const Color.fromARGB(255, 145, 25, 17),
            label: 'Delete All Tournaments',
            labelStyle: const TextStyle(fontSize: 18.0, color: Colors.black),
            onTap: () {
              deleteAllData();
            },
          ),
        ],
      ),
    );
  }

  double calculateContainerHeight(String content) {
    const defaultHeight = 60.0;
    const multiplier = 0.03;
    return defaultHeight + content.length * multiplier;
  }

  Future<void> LogOut() async {
    bool logoutConfirmed = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );

    if (logoutConfirmed == null || !logoutConfirmed) {
      return;
    }

    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.clear();

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const LoginPage(),
    ));
  }

  Future<void> openBottomSheet() async {
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
                const Text('Enter your tournament name here'),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextFormField(
                          controller: titleController,
                          maxLength: 20,
                          decoration: InputDecoration(
                            hintText: 'Tournament name..',
                            hintStyle: const TextStyle(fontSize: 17),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Name is required';
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
                          addFunction();
                          clearTextfields();
                          Navigator.pop(context);
                          showSnackBar('Tournament added successfully');
                        }
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

  void addFunction() {
    setState(
      () {
        boxTasks2.put(
          'key_${titleController.text}',
          Task(
            title: titleController.text,
          ),
        );
      },
    );
  }

  void editFunction(int index) {
    Task task = boxTasks2.getAt(index);
    titleController.text = task.title;

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
                          controller: titleController,
                          maxLength: 20,
                          decoration: InputDecoration(
                            hintText: 'Tournament name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Name is required';
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
                          boxTasks2.putAt(
                            index,
                            Task(
                              title: titleController.text,
                              // content: contentController.text,
                            ),
                          );
                          clearTextfields();
                          Navigator.pop(context);
                          showSnackBar('Tournament name updated successfully');
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

  void deleteOneData(BuildContext context, int index) async {
    bool deleteConfirmed = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this task?'),
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
      boxTasks2.deleteAt(index);
    });

    showSnackBar('Tournament deleted successfully');
  }

  Future<void> deleteAllData() async {
    if (_isDeleting) return;

    if (boxTasks2.isEmpty) {
      // Show a message if there are no tournaments
      showSnackBar('No tournaments to delete.');
      return;
    }

    bool deleteConfirmed = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content:
              const Text('Are you sure you want to delete all tournaments?'),
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
      await boxTasks2.clear();
      showSnackBar('All tournaments deleted successfully');
    } finally {
      setState(() {
        _isDeleting = false;
      });
    }
  }

  void clearTextfields() {
    setState(() {
      titleController.clear();
      contentController.clear();
    });
  }

  // ------------------------------------------------------

  void showFeedbackDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Provide Feedback'),
          content: const Text('Feel free to share your thoughts with us!'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                sendFeedbackEmail();
                Navigator.of(context).pop();
              },
              child: const Text('Send Email'),
            ),
          ],
        );
      },
    );
  }

  void sendFeedbackEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'ajeeshrko@gmail.com',
      queryParameters: {'subject': 'Feedback'},
    );

    try {
      await launch(emailLaunchUri.toString());
    } catch (e) {
      print('Error launching email: $e');
    }
  }
}
