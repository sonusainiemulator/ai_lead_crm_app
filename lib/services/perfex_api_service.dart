// Placeholder for Perfex CRM REST API integration
// Replace baseUrl and endpoints as needed

import '../models/lead.dart';

class PerfexApiService {
  final String baseUrl;
  PerfexApiService({required this.baseUrl});

  Future<List<Lead>> fetchLeads() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return List<Lead>.from(mockLeads);
  }

  Future<Lead> createLead(Lead lead) async {
    await Future.delayed(const Duration(milliseconds: 450));
    return lead;
  }

  Future<List<String>> fetchLeadModules() async {
    await Future.delayed(const Duration(milliseconds: 350));
    return [
      'Leads',
      'Web to Lead',
      'Campaign Leads',
      'Imported Leads',
      'Referral Leads',
    ];
  }

  Future<Map<String, dynamic>> uploadCallRecording({
    required String filePath,
    required String leadId,
    required String module,
  }) async {
    await Future.delayed(const Duration(milliseconds: 700));
    return {
      'success': true,
      'recording_file': filePath,
      'lead_id': leadId,
      'module': module,
      'message': 'Uploaded to Perfex CRM (mock)',
    };
  }
}
