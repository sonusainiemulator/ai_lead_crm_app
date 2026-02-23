import 'package:flutter/material.dart';
import '../models/lead.dart';

class DashboardScreen extends StatelessWidget {
  final String role;
  final String userName;

  const DashboardScreen({
    super.key,
    required this.role,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    final int totalLeads = mockLeads.length;
    final int highScoreLeads = mockLeads.where((lead) => lead.score >= 0.8).length;
    final int newLeads = mockLeads.where((lead) => lead.status == 'New').length;

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Welcome $userName',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text('Role: $role'),
          const SizedBox(height: 18),
          Card(
            child: ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Total Leads'),
              trailing: Text('$totalLeads'),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.auto_graph),
              title: const Text('High Priority Leads'),
              trailing: Text('$highScoreLeads'),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.fiber_new),
              title: const Text('New Leads'),
              trailing: Text('$newLeads'),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Recent Leads',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          ...mockLeads.take(3).map(
                (lead) => Card(
                  child: ListTile(
                    title: Text(lead.name),
                    subtitle: Text('${lead.company} • ${lead.status}'),
                    trailing: Text('${(lead.score * 100).toStringAsFixed(0)}%'),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
