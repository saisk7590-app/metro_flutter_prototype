import 'package:flutter/material.dart';
import 'app_sidebar.dart';
import '../screens/ptw/ptw_list_screen.dart';
import '../screens/ptw/new_ptw_screen.dart';
import '../screens/ptw/ptw_history_screen.dart';

class PtwNavigationScreen extends StatefulWidget {
  const PtwNavigationScreen({super.key});

  @override
  State<PtwNavigationScreen> createState() => _PtwNavigationScreenState();
}

class _PtwNavigationScreenState extends State<PtwNavigationScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      PtwListScreen(
        onSwitchToRequest: () => setState(() => _currentIndex = 1),
      ),
      NewPtwScreen(
        onCompleted: () => setState(() => _currentIndex = 0),
      ),
      const PtwHistoryScreen(),
    ];

    return Scaffold(
      drawer: const AppSidebar(currentModule: 'ptw'),
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: Colors.teal.shade800,
        unselectedItemColor: Colors.grey.shade600,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.security_outlined),
            activeIcon: Icon(Icons.security),
            label: 'Active Permits',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_moderator_outlined),
            activeIcon: Icon(Icons.add_moderator),
            label: 'Request PTW',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_outlined),
            activeIcon: Icon(Icons.history),
            label: 'History',
          ),
        ],
      ),
    );
  }
}
