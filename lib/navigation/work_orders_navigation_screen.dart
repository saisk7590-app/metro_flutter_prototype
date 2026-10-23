import 'package:flutter/material.dart';

import 'app_sidebar.dart';
import '../screens/checklist/work_orders_screen.dart';
import '../screens/checklist/work_order_history_screen.dart';

class WorkOrdersNavigationScreen extends StatefulWidget {
  const WorkOrdersNavigationScreen({super.key});

  @override
  State<WorkOrdersNavigationScreen> createState() =>
      _WorkOrdersNavigationScreenState();
}

class _WorkOrdersNavigationScreenState
    extends State<WorkOrdersNavigationScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const WorkOrdersScreen(),
      const WorkOrderHistoryScreen(),
    ];

    return Scaffold(
      drawer: const AppSidebar(currentModule: 'work_orders'),
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: Colors.purple.shade800,
        unselectedItemColor: Colors.grey.shade600,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_turned_in_outlined),
            activeIcon: Icon(Icons.assignment_turned_in),
            label: 'Job Cards / WOs',
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
