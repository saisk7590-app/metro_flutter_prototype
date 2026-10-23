import 'package:flutter/material.dart';
import 'app_sidebar.dart';
import '../screens/service_request/service_request_list_screen.dart';
import '../screens/service_request/new_service_request_screen.dart';
import '../screens/service_request/service_request_history_screen.dart';

class ServiceRequestNavigationScreen extends StatefulWidget {
  const ServiceRequestNavigationScreen({super.key});

  @override
  State<ServiceRequestNavigationScreen> createState() =>
      _ServiceRequestNavigationScreenState();
}

class _ServiceRequestNavigationScreenState
    extends State<ServiceRequestNavigationScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      ServiceRequestListScreen(
        onSwitchToReport: () => setState(() => _currentIndex = 1),
      ),
      NewServiceRequestScreen(
        onCompleted: () => setState(() => _currentIndex = 0),
      ),
      const ServiceRequestHistoryScreen(),
    ];

    return Scaffold(
      drawer: const AppSidebar(currentModule: 'service_requests'),
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: Colors.amber.shade900,
        unselectedItemColor: Colors.grey.shade600,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_late_outlined),
            activeIcon: Icon(Icons.assignment_late),
            label: 'Active SRs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_alert_outlined),
            activeIcon: Icon(Icons.add_alert),
            label: 'Report Fault',
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
