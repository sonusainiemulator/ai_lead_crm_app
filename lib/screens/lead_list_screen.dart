import 'package:flutter/material.dart';
import '../models/lead.dart';
import '../services/lead_service.dart';

import 'lead_detail_screen.dart';
import 'lead_create_screen.dart';
import 'call_recording_screen.dart';

class LeadListScreen extends StatefulWidget {
  final String role;
  final String userName;
  final String userEmail;

  const LeadListScreen({
    super.key,
    this.role = 'Employee',
    this.userName = 'Demo User',
    this.userEmail = 'demo@crm.com',
  });

  @override
  State<LeadListScreen> createState() => _LeadListScreenState();
}

class _LeadListScreenState extends State<LeadListScreen> {
  final LeadService _leadService = LeadService();
  List<Lead> leads = [];
  bool _loading = true;

  int get _highPriorityCount => leads.where((lead) => lead.score >= 0.8).length;
  int get _newLeadCount => leads.where((lead) => lead.status == 'New').length;

  @override
  void initState() {
    super.initState();
    _loadLeads();
  }

  Future<void> _loadLeads() async {
    setState(() {
      _loading = true;
    });
    final fetched = await _leadService.fetchLeads();
    if (!mounted) return;
    setState(() {
      leads = fetched;
      _loading = false;
    });
  }

  void _openLeadDetail(Lead lead) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => LeadDetailScreen(lead: lead)),
    );
  }

  void _createLead() async {
    final newLead = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const LeadCreateScreen()),
    );
    if (newLead != null && newLead is Lead) {
      final created = await _leadService.createLead(newLead);
      if (!mounted) return;
      setState(() {
        leads.add(created);
      });
    }
  }

  void _showModuleMessage(String moduleName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$moduleName module demo is ready for API wiring.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue.shade100),
              child: const Text('Perfex Lead Modules', style: TextStyle(fontSize: 20)),
            ),
            ListTile(
              leading: const Icon(Icons.web),
              title: const Text('Web to Lead'),
              onTap: () => _showModuleMessage('Web to Lead'),
            ),
            ListTile(
              leading: const Icon(Icons.campaign),
              title: const Text('Campaign Leads'),
              onTap: () => _showModuleMessage('Campaign Leads'),
            ),
            ListTile(
              leading: const Icon(Icons.file_upload),
              title: const Text('Imported Leads'),
              onTap: () => _showModuleMessage('Imported Leads'),
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Referral Leads'),
              onTap: () => _showModuleMessage('Referral Leads'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Leads • ${widget.role}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.mic),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CallRecordingScreen()),
              );
            },
            tooltip: 'Call Recording',
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _createLead,
            tooltip: 'Create Lead',
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            color: Colors.blue.shade50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Logged in as ${widget.userName} (${widget.userEmail})',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                Text('Total Leads: ${leads.length}   •   High Priority: $_highPriorityCount   •   New: $_newLeadCount'),
              ],
            ),
          ),
          if (_loading)
            const Expanded(child: Center(child: CircularProgressIndicator()))
          else
            Expanded(
              child: RefreshIndicator(
                onRefresh: _loadLeads,
                child: ListView.builder(
                  itemCount: leads.length,
                  itemBuilder: (context, index) {
                    final lead = leads[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: ListTile(
                        title: Text(lead.name),
                        subtitle: Text('${lead.company} • ${lead.source} • ${lead.status}'),
                        trailing: Chip(
                          label: Text('${(lead.score * 100).toStringAsFixed(0)}%'),
                          backgroundColor: lead.score > 0.8 ? Colors.green[100] : Colors.grey[200],
                        ),
                        onTap: () => _openLeadDetail(lead),
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
