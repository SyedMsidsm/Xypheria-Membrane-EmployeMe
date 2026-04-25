import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../providers/app_state.dart';
import '../../models/job_posting.dart';

class ViewAllJobs extends StatelessWidget {
  const ViewAllJobs({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final jobs = state.jobPostings;

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        title: const Text('All Job Postings'),
        centerTitle: true,
      ),
      body: jobs.isEmpty 
        ? const Center(child: Text('No job postings yet.'))
        : ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: jobs.length,
            itemBuilder: (context, index) => _jobCard(context, state, jobs[index]),
          ),
    );
  }

  Widget _jobCard(BuildContext context, AppState state, JobPosting job) {
    final bool highInterest = job.isUrgent;
    final applicants = highInterest ? 47 : 12;
    final expires = highInterest ? '3' : '7';
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppShadows.card,
        border: Border.all(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned(
            left: 0, top: 0, bottom: 0,
            child: Container(width: 4, color: highInterest ? AppColors.alert : AppColors.primary),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Expanded(child: Text(job.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(8)),
                  child: Text(job.type, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.primaryDark)),
                ),
              ]),
              const SizedBox(height: 8),
              Row(children: [
                const Icon(Icons.category_outlined, size: 14, color: AppColors.textSecondary),
                const SizedBox(width: 6),
                Text(job.category, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                const SizedBox(width: 16),
                const Icon(Icons.payments_outlined, size: 14, color: AppColors.textSecondary),
                const SizedBox(width: 6),
                Text('₹${job.pay}/${job.payPeriod}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              ]),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: AppColors.bg, borderRadius: BorderRadius.circular(12)),
                child: Row(children: [
                  const Icon(Icons.people, size: 16, color: AppColors.primary),
                  const SizedBox(width: 6),
                  Text('$applicants applicants', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                  const Spacer(),
                  Text('Expires in $expires days', style: TextStyle(fontSize: 12, color: highInterest ? AppColors.alert : AppColors.textSecondary, fontWeight: FontWeight.w600)),
                ]),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
