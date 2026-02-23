import 'package:flutter/material.dart';
import '../models/lead.dart';

class LeadCreateScreen extends StatefulWidget {
  const LeadCreateScreen({super.key});

  @override
  State<LeadCreateScreen> createState() => _LeadCreateScreenState();
}

class _LeadCreateScreenState extends State<LeadCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String phone = '';
  String company = '';
  String source = 'Manual Entry';

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.pop(
        context,
        Lead(
          id: 'L-${DateTime.now().millisecondsSinceEpoch}',
          name: name,
          email: email,
          phone: phone,
          company: company,
          source: source,
          status: 'New',
          assignedTo: 'Current User',
          notes: 'Created from mobile app form.',
          lastContactAt: DateTime.now(),
          score: 0.55,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Lead')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                onSaved: (val) => name = val ?? '',
                validator: (val) => val == null || val.isEmpty ? 'Enter name' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                onSaved: (val) => email = val ?? '',
                validator: (val) => val == null || val.isEmpty ? 'Enter email' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Phone'),
                onSaved: (val) => phone = val ?? '',
                validator: (val) => val == null || val.isEmpty ? 'Enter phone' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Company'),
                onSaved: (val) => company = val ?? '',
                validator: (val) => val == null || val.isEmpty ? 'Enter company' : null,
              ),
              DropdownButtonFormField<String>(
                value: source,
                decoration: const InputDecoration(labelText: 'Source'),
                items: const [
                  DropdownMenuItem(value: 'Manual Entry', child: Text('Manual Entry')),
                  DropdownMenuItem(value: 'Website Form', child: Text('Website Form')),
                  DropdownMenuItem(value: 'Google Ads', child: Text('Google Ads')),
                  DropdownMenuItem(value: 'Facebook Campaign', child: Text('Facebook Campaign')),
                  DropdownMenuItem(value: 'Referral', child: Text('Referral')),
                ],
                onChanged: (value) => source = value ?? 'Manual Entry',
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Create'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
