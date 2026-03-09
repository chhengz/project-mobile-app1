import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shoes_app/models/app_user.dart';
import 'package:shoes_app/services/auth_service.dart';
import 'package:shoes_app/services/profile_service.dart';

class AuthController extends GetxController{
  final _storage = GetStorage();
  final AuthService _authService = AuthService();
  final ProfileService _profileService = ProfileService();

  final RxBool _isFirstTime = true.obs;
  final RxBool _isLoggedIn = false.obs;
  final RxBool _isLoading = false.obs;
  final Rxn<AppUser> _currentUser = Rxn<AppUser>();
  final RxString _token = ''.obs;

  bool get isFirstTime => _isFirstTime.value;
  bool get isLoggedIn => _isLoggedIn.value;
  bool get isLoading => _isLoading.value;
  AppUser? get currentUser => _currentUser.value;
  String get token => _token.value;

  @override
  void onInit(){
    super.onInit();
    _loadInitialState();
  }

  Future<void> _loadInitialState() async {
    _isFirstTime.value = _storage.read('isFirstTime')?? true;
    _isLoggedIn.value = _storage.read('isLoggedIn') ?? false;
    _token.value = _storage.read('token') ?? '';

    final rawUser = _storage.read('user');
    if (rawUser is Map) {
      _currentUser.value = AppUser.fromJson(Map<String, dynamic>.from(rawUser));
    }

    if (_isLoggedIn.value && _token.value.isNotEmpty) {
      await fetchCurrentUser();
    }
  }

  void setFirstTimeDone(){
    _isFirstTime.value = false;
    _storage.write('isFirstTime', false);
  }

  Future<bool> login({required String email, required String password}) async {
    _isLoading.value = true;

    try {
      final data = await _authService.login(email: email, password: password);
      final user = AppUser.fromJson(Map<String, dynamic>.from(data['user'] as Map));
      final authToken = data['token']?.toString() ?? '';

      _token.value = authToken;
      _currentUser.value = user;
      _isLoggedIn.value = true;

      _storage.write('token', authToken);
      _storage.write('user', user.toJson());
      _storage.write('isLoggedIn', true);
      return true;
    } catch (_) {
      return false;
    } finally {
      _isLoading.value = false;
    }
  }

  Future<bool> register({
    required String fullName,
    required String email,
    required String password,
    required String phone,
  }) async {
    _isLoading.value = true;

    try {
      final data = await _authService.register(
        fullName: fullName,
        email: email,
        password: password,
        phone: phone,
      );

      final user = AppUser.fromJson(Map<String, dynamic>.from(data['user'] as Map));
      final authToken = data['token']?.toString() ?? '';

      _token.value = authToken;
      _currentUser.value = user;
      _isLoggedIn.value = true;

      _storage.write('token', authToken);
      _storage.write('user', user.toJson());
      _storage.write('isLoggedIn', true);
      return true;
    } catch (_) {
      return false;
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> fetchCurrentUser() async {
    if (_token.value.isEmpty) {
      return;
    }

    try {
      final data = await _authService.me(_token.value);
      final user = AppUser.fromJson(Map<String, dynamic>.from(data['user'] as Map));
      _currentUser.value = user;
      _storage.write('user', user.toJson());
    } catch (_) {
      await logout();
    }
  }

  Future<bool> updateProfile({
    required String fullName,
    required String phone,
  }) async {
    if (_token.value.isEmpty) {
      return false;
    }

    _isLoading.value = true;
    try {
      final data = await _profileService.updateProfile(
        token: _token.value,
        fullName: fullName,
        phone: phone,
        avatarUrl: _currentUser.value?.avatarUrl ?? '',
      );

      final user = AppUser.fromJson(Map<String, dynamic>.from(data['profile'] as Map));
      _currentUser.value = user;
      _storage.write('user', user.toJson());
      return true;
    } catch (_) {
      return false;
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> logout() async {
    if (_token.value.isNotEmpty) {
      try {
        await _authService.logout(_token.value);
      } catch (_) {
        // Ignore API logout failures and clear local session anyway.
      }
    }

    _isLoggedIn.value = false;
    _storage.write('isLoggedIn', false);
    _storage.remove('token');
    _storage.remove('user');
    _token.value = '';
    _currentUser.value = null;
  }
}