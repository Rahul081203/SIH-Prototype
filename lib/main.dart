import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> main() async{
  await dotenv.load();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    NotificationPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nyaya Saathi'),
        backgroundColor: Colors.amber
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 1.0,
      padding: const EdgeInsets.all(20.0),
      mainAxisSpacing: 20.0,
      crossAxisSpacing: 20.0,
      children: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.red, // Set the button color to blue
            minimumSize: Size(double.infinity, 50),
          ),
          child: Text('Rehabilitation'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.red, // Set the button color to blue
            minimumSize: Size(double.infinity, 50),
          ),
          child: Text('Legal Chatbot'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FindLawyersScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.red, // Set the button color to blue
            minimumSize: Size(double.infinity, 50),
          ),
          child: Text('Find Lawyers'),
        ),
        ElevatedButton(
        onPressed: () {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => CourtProceedingsScreen()),
    );
    },
          style: ElevatedButton.styleFrom(
            primary: Colors.red, // Set the button color to blue
            minimumSize: Size(double.infinity, 50),
          ),
    child: Text('Court Proceedings'), // Button 4 for court proceedings
    ),
      ],
    );
  }
}

class CourtProceedingsScreen extends StatelessWidget {
  final List<CourtProceeding> _courtProceedings = [
    CourtProceeding(
      title: 'Case 1',
      date: '2023-04-15',
      description: 'This is the description for case 1.',
    ),
    CourtProceeding(
      title: 'Case 2',
      date: '2023-04-18',
      description: 'This is the description for case 2.',
    ),
    // Add more dummy court proceedings here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Court Proceedings'),
      ),
      body: ListView.builder(
        itemCount: _courtProceedings.length,
        itemBuilder: (context, index) {
          return CourtProceedingItem(courtProceeding: _courtProceedings[index]);
        },
      ),
    );
  }
}

class CourtProceedingItem extends StatelessWidget {
  final CourtProceeding courtProceeding;

  CourtProceedingItem({required this.courtProceeding});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      child: ListTile(
        title: Text(courtProceeding.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Date: ${courtProceeding.date}'),
            Text('Description: ${courtProceeding.description}'),
          ],
        ),
      ),
    );
  }
}
class Therapist {
  final String t_name;
  final String t_specialization;
  final String t_location;

  Therapist({
    required this.t_name,
    required this.t_specialization,
    required this.t_location,
  });
}

class ConnectWithTherapistScreen extends StatefulWidget {
  @override
  _ConnectWithTherapistScreenState createState() => _ConnectWithTherapistScreenState();
}

class _ConnectWithTherapistScreenState extends State<ConnectWithTherapistScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Therapist> _therapists = [
    Therapist(t_name: 'John Doe', t_specialization: 'Criminal Law', t_location: 'New York'),
    Therapist(t_name: 'Jane Smith', t_specialization: 'Family Law', t_location: 'Los Angeles'),
    Therapist(t_name: 'Michael Johnson', t_specialization: 'Corporate Law', t_location: 'Chicago')
    // Add more lawyer items as needed
  ];

  List<Therapist> _searchResults = [];

  @override
  void initState() {
    _searchResults = List.from(_therapists);
    super.initState();
  }

  void _onSearch() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _searchResults = _therapists
          .where((lawyer) =>
      lawyer.t_name.toLowerCase().contains(query) ||
          lawyer.t_specialization.toLowerCase().contains(query) ||
          lawyer.t_location.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find Therapists'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Search for Lawyers',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Enter your search query',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _onSearch,
                child: Text('Search'),
              ),
              SizedBox(height: 32),
              Text(
                'Available Therapists',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  return TherapistItem(
                    t_name: _searchResults[index].t_name,
                    t_specialization: _searchResults[index].t_specialization,
                    t_location: _searchResults[index].t_location,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
class TherapistItem extends StatelessWidget {
  final String t_name;
  final String t_specialization;
  final String t_location;

  TherapistItem({
    required this.t_name,
    required this.t_specialization,
    required this.t_location,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 16),
      child: ListTile(
        title: Text(t_name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(t_specialization),
            Text(t_location),
          ],
        ),
        // Add more details or actions for each lawyer
      ),
    );
  }
}
class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = [];

  Future<void> _sendMessage(String message) async {
    try {
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${dotenv.env['token']}',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {
              "role": "system",
              "content": "You are a helpful assistant",
            },
            {
              "role": "user",
              "content": "$message",
            },
            {
              "role": "assistant",
              "content": "How may I assist you today?",
            },
          ],
          "temperature": 1,
          "max_tokens": 256,
          "top_p": 1,
          "frequency_penalty": 0,
          "presence_penalty": 0,
        }),
      );
      print(response.body);
      print(message);

      // Use setState to update the UI with the new message
      setState(() {
        _messages.add('User: $message');

        // Extract and add the assistant's response to the _messages list
        final responseJson = jsonDecode(response.body);
        final assistantResponse = responseJson['choices'][0]['message']['content'];
        _messages.add('Assistant: $assistantResponse');
      });
    } catch (e) {
      // Handle exceptions
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Screen'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_messages[index]),
                );
              },
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Type your message',
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    _sendMessage(_controller.text);
                    setState(() {
                      _controller.clear(); // Clear the input field
                    });
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
class Lawyer {
  final String name;
  final String specialization;
  final String location;

  Lawyer({
    required this.name,
    required this.specialization,
    required this.location,
  });
}

class FindLawyersScreen extends StatefulWidget {
  @override
  _FindLawyersScreenState createState() => _FindLawyersScreenState();
}

class _FindLawyersScreenState extends State<FindLawyersScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Lawyer> _lawyers = [
    Lawyer(name: 'John Doe', specialization: 'Criminal Law', location: 'New York'),
    Lawyer(name: 'Jane Smith', specialization: 'Family Law', location: 'Los Angeles'),
    Lawyer(name: 'Michael Johnson', specialization: 'Corporate Law', location: 'Chicago'),
    // Add more lawyer items as needed
  ];

  List<Lawyer> _searchResults = [];

  @override
  void initState() {
    _searchResults = List.from(_lawyers);
    super.initState();
  }

  void _onSearch() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _searchResults = _lawyers
          .where((lawyer) =>
      lawyer.name.toLowerCase().contains(query) ||
          lawyer.specialization.toLowerCase().contains(query) ||
          lawyer.location.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find Lawyers'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Search for Lawyers',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Enter your search query',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _onSearch,
                child: Text('Search'),
              ),
              SizedBox(height: 32),
              Text(
                'Available Lawyers',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            itemCount: _searchResults.length,
            itemBuilder: (context, index) {
              return LawyerItem(
                name: _searchResults[index].name,
                specialization: _searchResults[index].specialization,
                location: _searchResults[index].location,
              );
            },
          )
            ],
          ),
        ),
      ),
    );
  }
}


class CourtProceeding {
  final String title;
  final String date;
  final String description;

  CourtProceeding({
    required this.title,
    required this.date,
    required this.description,
  });
}



class LawyerItem extends StatelessWidget {
  final String name;
  final String specialization;
  final String location;

  LawyerItem({
    required this.name,
    required this.specialization,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 16),
      child: ListTile(
        title: Text(name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(specialization),
            Text(location),
          ],
        ),
        // Add more details or actions for each lawyer
      ),
    );
  }
}


class NewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rehabilitation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ConnectWithTherapistScreen()),
                );
              },
              child: Text('Connect with Therapist'),
              style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Explore other Vocational Programs'),
              style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Your Notifications Will Appear Here',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              // You can set the user's profile picture here
              // backgroundImage: NetworkImage('URL_TO_PROFILE_IMAGE'),
            ),
            SizedBox(height: 20),
            Text(
              'User Name',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'User Email',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle the action to edit profile
              },
              child: Text('Edit Profile'),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle the action to log out
              },
              child: Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}
