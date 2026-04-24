import 'package:flutter/material.dart';
import '../services/localization_service.dart';

class AppState extends ChangeNotifier {
  // ── Auth & User ──
  String _language = 'en';
  String _role = ''; // 'worker' or 'employer'
  String _phone = '';
  bool _isLoggedIn = false;

  String get language => _language;
  String get role => _role;
  String get phone => _phone;
  bool get isLoggedIn => _isLoggedIn;
  bool get isWorker => _role == 'worker';
  bool get isEmployer => _role == 'employer';

  void setLanguage(String lang) { _language = lang; notifyListeners(); }
  void setRole(String r) { _role = r; notifyListeners(); }
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

  // ── My Jobs Tab ──
  String _myJobsTab = 'All';
  String get myJobsTab => _myJobsTab;
  void setMyJobsTab(String tab) { _myJobsTab = tab; notifyListeners(); }

  // ── Localization ──
  String tr(String key, {Map<String, String>? args}) {
    return LocalizationService.translate(key, _language, args: args);
  }
}
