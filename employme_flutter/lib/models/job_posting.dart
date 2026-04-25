class JobPosting {
  final String title;
  final String category;
  final String pay;
  final String payPeriod;
  final String timing;
  final int peopleNeeded;
  final String type;
  final String description;
  final List<String> requirements;
  final bool isUrgent;
  final DateTime postedAt;

  JobPosting({
    required this.title,
    required this.category,
    required this.pay,
    required this.payPeriod,
    required this.timing,
    required this.peopleNeeded,
    required this.type,
    required this.description,
    required this.requirements,
    this.isUrgent = false,
    required this.postedAt,
  });
}
