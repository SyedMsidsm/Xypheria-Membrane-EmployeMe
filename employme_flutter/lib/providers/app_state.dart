import 'package:flutter/material.dart';
import '../services/localization_service.dart';
import '../models/job_posting.dart';
import '../services/demo_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  // ── Auth & User ──
  String _language = 'en';
  String _role = ''; // 'worker' or 'employer'
  String _phone = '';
  bool _isLoggedIn = false;
  final Map<String, dynamic> _chatSubscriptions = {}; // Changed to a dummy map to avoid errors elsewhere if any

  AppState() {
    _loadPersistedState();
  }

  Future<void> _loadPersistedState() async {
    final prefs = await SharedPreferences.getInstance();
    _role = prefs.getString('role') ?? '';
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    _phone = prefs.getString('phone') ?? '';
    
    if (_role == 'employer') {
      _userName = 'Sri Ganesh Store';
    } else if (_role == 'worker') {
      _userName = 'Raju Kumar';
    }
    notifyListeners();
  }

  Future<void> _savePersistedState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('role', _role);
    await prefs.setBool('isLoggedIn', _isLoggedIn);
    await prefs.setString('phone', _phone);
  }

  String get language => _language;
  String get role => _role;
  String get phone => _phone;
  bool get isLoggedIn => _isLoggedIn;
  bool get isWorker => _role == 'worker';
  bool get isEmployer => _role == 'employer';

  void setLanguage(String lang) { _language = lang; notifyListeners(); }
  void setRole(String r) { 
    _role = r; 
    if (r == 'employer') {
      _userName = 'Sri Ganesh Store';
    } else {
      _userName = 'Raju Kumar';
    }
    _savePersistedState();
    notifyListeners(); 
  }
  void login(String phone) { _phone = phone; _isLoggedIn = true; notifyListeners(); }

  // ── User Profile ──
  String? _profileImagePath;
  String _userName = 'Raju Kumar';
  String _aboutMe = 'Hardworking professional with a knack for quick learning and reliable delivery.';
  int _age = 24;
  String _gender = 'Male';
  String _location = 'Kodialbail, Mangalore';
  int _experience = 3;
  int _trustScore = 87;
  double _rating = 4.8;
  int _jobsDone = 12;
  int _totalEarned = 18400;

  String get userName => _userName;
  String get aboutMe => _aboutMe;
  String? get profileImagePath => _profileImagePath;
  int get age => _age;
  String get gender => _gender;
  String get location => _location;
  void setLocation(String loc) { _location = loc; notifyListeners(); }
  int get experience => _experience;
  int get trustScore => _trustScore;
  double get rating => _rating;
  int get jobsDone => _jobsDone;
  int get totalEarned => _totalEarned;

  void updateProfile({String? name, String? aboutMe, int? age, String? gender, int? exp}) {
    if (name != null) _userName = name;
    if (aboutMe != null) _aboutMe = aboutMe;
    if (age != null) _age = age;
    if (gender != null) _gender = gender;
    if (exp != null) _experience = exp;
    notifyListeners();
  }

  void setProfileImage(String path) {
    _profileImagePath = path;
    notifyListeners();
  }

  // ── Skills ──
  final Set<String> _selectedSkills = {'Cooking', 'Cleaning', 'Delivery', 'Shop Helper'};
  Set<String> get selectedSkills => _selectedSkills;

  void toggleSkill(String skill) {
    if (_selectedSkills.contains(skill)) {
      _selectedSkills.remove(skill);
    } else {
      if (_selectedSkills.length >= 5) return;
      _selectedSkills.add(skill);
    }
    notifyListeners();
  }

  // ── Languages spoken ──
  final Set<String> _spokenLanguages = {'Kannada', 'Hindi'};
  Set<String> get spokenLanguages => _spokenLanguages;
  void toggleLanguageSpoken(String lang) {
    if (_spokenLanguages.contains(lang)) _spokenLanguages.remove(lang);
    else _spokenLanguages.add(lang);
    notifyListeners();
  }

  // ── Availability ──
  String _travelDistance = 'walk';
  String _preferredTiming = 'Morning';
  final Set<String> _availableDays = {'Mon', 'Tue', 'Wed', 'Thu', 'Fri'};
  bool _availableNow = true;

  String get travelDistance => _travelDistance;
  String get preferredTiming => _preferredTiming;
  Set<String> get availableDays => _availableDays;
  bool get availableNow => _availableNow;

  void setTravelDistance(String d) { _travelDistance = d; notifyListeners(); }
  void setPreferredTiming(String t) { _preferredTiming = t; notifyListeners(); }
  void toggleDay(String day) {
    if (_availableDays.contains(day)) _availableDays.remove(day);
    else _availableDays.add(day);
    notifyListeners();
  }
  void setAvailableNow(bool v) { _availableNow = v; notifyListeners(); }

  // ── Job Feed State ──
  String _selectedCategory = 'All Jobs';
  String _searchQuery = '';

  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;

  void setCategory(String cat) { _selectedCategory = cat; notifyListeners(); }
  void setSearchQuery(String q) { _searchQuery = q; notifyListeners(); }

  // ── Bookmarks & Applications ──
  final Set<String> _bookmarkedJobs = {};
  final Set<String> _appliedJobs = {};
  final Map<String, String> _applicationStatus = {}; // jobTitle -> 'pending'|'accepted'|'completed'

  Set<String> get bookmarkedJobs => _bookmarkedJobs;
  Set<String> get appliedJobs => _appliedJobs;
  Map<String, String> get applicationStatus => _applicationStatus;

  bool isBookmarked(String jobTitle) => _bookmarkedJobs.contains(jobTitle);
  bool hasApplied(String jobTitle) => _appliedJobs.contains(jobTitle);

  void toggleBookmark(String jobTitle) {
    if (_bookmarkedJobs.contains(jobTitle)) _bookmarkedJobs.remove(jobTitle);
    else _bookmarkedJobs.add(jobTitle);
    notifyListeners();
  }

  void applyToJob(String jobTitle) {
    _appliedJobs.add(jobTitle);
    _applicationStatus[jobTitle] = 'pending';
    notifyListeners();
  }

  void updateApplicationStatus(String jobTitle, String status) {
    _applicationStatus[jobTitle] = status;
    notifyListeners();
  }

  // ── Notifications ──
  int _unreadNotifications = 3;
  int get unreadNotifications => _unreadNotifications;
  void markAllRead() { _unreadNotifications = 0; notifyListeners(); }

  // ── Chat & Messages ──
  String getChatId(String otherPersonName) {
    if (otherPersonName.isEmpty) return _userName;
    final sorted = [_userName, otherPersonName]..sort();
    return sorted.join('_');
  }

  final Map<String, List<Map<String, dynamic>>> _messagesByChatId = {
    'Raju Kumar_Sri Ganesh Store': [
      {'text': 'Hello! I saw your application for Shop Assistant. Are you available to start soon?', 'sender': 'Sri Ganesh Store', 'time': '10:32 AM'},
      {'text': 'Yes, I can start immediately. I have 2 years experience in similar work.', 'sender': 'Raju Kumar', 'time': '10:34 AM'},
      {'text': 'Great! Can you come for a quick meeting tomorrow at the shop?', 'sender': 'Sri Ganesh Store', 'time': '10:35 AM'},
      {'text': "Yes, what time? 🚶 I'm only 6 minutes away!", 'sender': 'Raju Kumar', 'time': '10:36 AM'},
    ],
  };

  List<Map<String, dynamic>> getMessages(String chatId) => _messagesByChatId[chatId] ?? [];

  void sendMessage(String chatId, String text) {
    if (text.trim().isEmpty) return;
    
    final msg = {
      'text': text,
      'sender': _userName,
      'time': 'Just now',
    };

    if (!_messagesByChatId.containsKey(chatId)) {
      _messagesByChatId[chatId] = [];
    }
    _messagesByChatId[chatId]!.add(msg);
    notifyListeners();
  }

  void listenToMessages(String chatId) {
    // Purely local now, no-op
  }

  @override
  void dispose() {
    super.dispose();
  }

  // ── My Jobs & Offers ──
  String _myJobsTab = 'All';
  String get myJobsTab => _myJobsTab;
  void setMyJobsTab(String tab) { _myJobsTab = tab; notifyListeners(); }

  // ── Employer Job Postings ──
  final List<JobPosting> _jobPostings = [];
  List<JobPosting> get jobPostings => _jobPostings;

  void addJobPosting(JobPosting job) {
    _jobPostings.insert(0, job);
    notifyListeners();
  }

  // Combine Employer Job Postings for Feed
  List<Map<String, dynamic>> get workerFeedJobs {
    final postedAsMaps = _jobPostings.map((p) => {
      'emoji': _getEmojiForCategory(p.category),
      'title': p.title,
      'company': _userName.isNotEmpty && isEmployer ? _userName : 'Local Business',
      'type': p.type,
      'location': _location.isNotEmpty ? _location.split(',')[0] : 'Nearby',
      'salary': '₹${p.pay}',
      'period': p.payPeriod == 'per day' ? '/day' : '/mo',
      'distance': 'Just added',
      'verified': true,
      'isUrgent': p.isUrgent,
      'description': p.description,
      'requirements': p.requirements,
      'timing': p.timing,
      'peopleNeeded': p.peopleNeeded,
    }).toList();

    final demoJobs = DemoData.jobs.map((j) => {
      ...j, 
      'isUrgent': false,
    }).toList();
    
    return [...postedAsMaps, ...demoJobs];
  }

  String _getEmojiForCategory(String cat) {
    if (cat.contains('Shop') || cat.contains('Retail')) return '🏪';
    if (cat.contains('Delivery')) return '🚚';
    if (cat.contains('Cook') || cat.contains('Food')) return '🍳';
    return '👷';
  }

  // ── Worker Jobs ──
  final List<Map<String, String>> _jobs = [
    {'emoji': '🏪', 'title': 'Shop Assistant', 'company': 'Sri Ganesh Store', 'salary': '₹12,000/mo', 'status': 'active', 'started': 'Started Aug 1'},
    {'emoji': '🍳', 'title': 'Kitchen Helper', 'company': 'Hotel Udupi', 'salary': '₹500/day', 'status': 'pending', 'started': 'Applied Aug 3'},
    {'emoji': '🚚', 'title': 'Delivery Partner', 'company': 'QuickMart', 'salary': '₹600/day', 'status': 'completed', 'started': 'Jul 15 - Jul 30'},
  ];
  List<Map<String, String>> get jobs => _jobs;

  final Map<String, String> _offerStatusByChatId = {
    'Raju Kumar_Sri Ganesh Store': 'pending',
  };

  String getOfferStatus(String chatId) => _offerStatusByChatId[chatId] ?? 'none';

  void sendJobOffer(String chatId) {
    _offerStatusByChatId[chatId] = 'pending';
    notifyListeners();
  }

  void acceptJobOffer(String chatId) {
    _offerStatusByChatId[chatId] = 'accepted';
    // Add the new job as active
    _jobs.insert(0, {
      'emoji': '🏪',
      'title': 'Shop Assistant',
      'company': 'Sri Ganesh Store',
      'salary': '₹12,000/mo',
      'status': 'active',
      'started': 'Started Today'
    });
    notifyListeners();
  }

  void declineJobOffer(String chatId) {
    _offerStatusByChatId[chatId] = 'declined';
    notifyListeners();
  }

  // ── Applicants ──
  final List<Map<String, dynamic>> _applicants = [
    {
      'name': 'Raju Kumar',
      'initial': 'R',
      'trustScore': 87,
      'skills': ['Shop Helper', 'Cleaning'],
      'distance': '6 min walk',
      'rating': 4.8,
      'jobsDone': 12,
      'showUp': '100%',
      'available': 'Immediately',
      'bestMatch': true,
      'status': 'New',
    },
    {
      'name': 'Suresh Mallya',
      'initial': 'S',
      'trustScore': 72,
      'skills': ['Delivery', 'Shop'],
      'distance': '18 min walk',
      'rating': 4.2,
      'jobsDone': 5,
      'showUp': '90%',
      'available': 'Tomorrow',
      'bestMatch': false,
      'status': 'Shortlisted',
    },
    {
      'name': 'Priya Devi',
      'initial': 'P',
      'trustScore': 65,
      'skills': ['Cook', 'Shop'],
      'distance': '8 min walk',
      'rating': 4.5,
      'jobsDone': 3,
      'showUp': '100%',
      'available': 'Immediately',
      'bestMatch': false,
      'status': 'Contacted',
    },
  ];
  List<Map<String, dynamic>> get applicants => _applicants;

  void shortlistApplicant(String applicantName) {
    // 1. Find applicant and set status
    final index = _applicants.indexWhere((a) => a['name'] == applicantName);
    if (index != -1) {
      _applicants[index] = {
        ..._applicants[index],
        'status': 'Shortlisted',
      };
    }
    
    // 2. Automate a chat message
    final chatId = getChatId(applicantName);
    sendMessage(chatId, "Congratulations! You have been shortlisted for the Shop Assistant role. I will contact you soon.");
    
    notifyListeners();
  }

  // ── Localization ──
  String tr(String key, {Map<String, dynamic>? args}) {
    return LocalizationService.translate(key, language, args: args);
  }
}
