import 'package:flutter/material.dart';
import 'package:shared_pre_hive_sampleproject/grouphome/group_home.dart';
import 'package:shared_pre_hive_sampleproject/knockouthome/knockout_home.dart';
import 'package:shared_pre_hive_sampleproject/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class LobbyPage extends StatefulWidget {
  final String loginName;

  const LobbyPage({
    Key? key,
    required this.loginName,
  }) : super(key: key);

  @override
  State<LobbyPage> createState() => _LobbyPageState();
}

class _LobbyPageState extends State<LobbyPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isDeleting = false;
  String userName = '';

  @override
  void initState() {
    super.initState();
    userName = widget.loginName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        backgroundColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(
                  ' ${widget.loginName}',
                  style: const TextStyle(color: Colors.white),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    widget.loginName[0],
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
                    ),
                  ),
                ),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(
                    255,
                    26,
                    27,
                    28,
                  ),
                ),
                accountEmail: null,
              ),
              ListTile(
                leading: const Icon(Icons.info, color: Colors.white),
                title: const Text(
                  'About',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  // Handle 'About' action
                },
              ),
              ListTile(
                leading: const Icon(Icons.home, color: Colors.white),
                title: const Text(
                  'Back to App',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              const Divider(color: Colors.white),
              ListTile(
                leading: const Icon(Icons.feedback, color: Colors.white),
                title: const Text(
                  'Feedback',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  showFeedbackDialog(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.white),
                title: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  LogOut();
                },
              ),
              const Spacer(),
              const Column(
                children: [
                  Text(
                    'E-Football Showdown',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Version: 1.0.0',
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/pics/peakpx.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: ListView(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  automaticallyImplyLeading: false,
                  title: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          _scaffoldKey.currentState?.openDrawer();
                        },
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Hello, ${widget.loginName}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Please select your tournament type',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => GroupHome(loginName: userName),
                    ));
                  },
                  child: buildMatchCard(
                    'Group Match',
                    'lib/pics/peakpx (4).jpg',
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => KnockoutHome(loginName: userName),
                    ));
                  },
                  child: buildMatchCard(
                    'Knockout Match',
                    'lib/pics/football-pc-xnjfj0wmijikmjwd.jpg',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMatchCard(String matchTitle, String imagePath) {
    return Card(
      color: Colors.grey.shade900,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                  matchTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

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
              onPressed: () async {
                await sendFeedbackEmail();
                Navigator.of(context).pop();
              },
              child: const Text('Send Email'),
            ),
          ],
        );
      },
    );
  }

  Future<void> sendFeedbackEmail() async {
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
}
