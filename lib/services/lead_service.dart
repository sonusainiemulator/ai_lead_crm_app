import '../models/lead.dart';
import 'ai_scoring_service.dart';
import 'perfex_api_service.dart';

class LeadService {
  final AiScoringService _aiScoringService = AiScoringService();
  final PerfexApiService _perfexApiService = PerfexApiService(baseUrl: 'https://demo.perfexcrm.local');

  Future<List<Lead>> fetchLeads() async {
    final leads = await _perfexApiService.fetchLeads();
    return leads
        .map(
          (lead) => lead.copyWith(
            score: lead.score > 0 ? lead.score : _aiScoringService.scoreLead(lead),
          ),
        )
        .toList();
  }

  Future<Lead> createLead(Lead lead) async {
    final scoredLead = lead.copyWith(score: _aiScoringService.scoreLead(lead));
    return _perfexApiService.createLead(scoredLead);
  }
}
