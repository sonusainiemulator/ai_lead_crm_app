import 'package:flutter/material.dart';
import '../models/lead.dart';

class LeadDetailScreen extends StatelessWidget {
  final Lead lead;
  const LeadDetailScreen({super.key, required this.lead});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lead.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Lead ID: ${lead.id}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text('Email: ${lead.email}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Phone: ${lead.phone}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Company: ${lead.company}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Source: ${lead.source}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Status: ${lead.status}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            Text('Assigned To: ${lead.assignedTo}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('AI Score: ${(lead.score * 100).toStringAsFixed(0)}%', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Notes: ${lead.notes}', style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
