import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../../models/auth/login_model.dart';
import '../base_api_service.dart';

/// Service handling authentication, sessions, CAPTCHA, and password recovery.
/// Configured for 100% offline standalone prototype operation.
class AuthApiService extends BaseApiService {
  /// Authenticate user credentials and return mock JWT token & session
  Future<LoginModel> login({
    required String userName,
    required String password,
    required String timeStamp,
    String captchaId = '',
    String captchaValue = '',
  }) async {
    debugPrint('Prototype Login: authenticating $userName');
    await Future.delayed(const Duration(milliseconds: 300));

    final resolvedUser = userName.trim().isNotEmpty ? userName.trim() : 'admin';
    final mockToken = 'mock_jwt_token_ams_prototype_${DateTime.now().millisecondsSinceEpoch}';
    final mockSession = base64Encode(utf8.encode('{"user":"$resolvedUser","prototype":true}'));

    BaseApiService.currentToken = mockToken;
    BaseApiService.currentUserSession = mockSession;
    BaseApiService.currentRoleId = '1';

    return LoginModel(
      id: 1,
      userName: resolvedUser,
      staffId: 1001,
      staffName: 'Metro Technical Staff',
      userSession: mockSession,
      userSessionId: 101,
      lastLogin: DateTime.now().toIso8601String(),
      unitId: 1,
      unitName: 'Rolling Stock',
      roleIds: '1,2',
      roleNames: 'Super Admin,Depot Engineer',
      assetCategoryId: 1,
      unitAccessScopes: 'ALL',
      loginResult: 1,
      loginMessage: 'Login successful (Offline Prototype Mode)',
      resetpwd: 0,
      locationName: 'Miyapur Depot',
      isMFARequired: 0,
      captchaId: 'captcha_ok',
      captchaImage: '',
      token: mockToken,
      rawBody: '{"status":1,"message":"Success"}',
    );
  }

  /// Invalidate user session and clear local auth tokens
  Future<bool> logout({
    String userSession = '',
    String userSessionId = '',
    String remarks = 'User Logout',
  }) async {
    BaseApiService.currentToken = null;
    BaseApiService.currentUserSession = null;
    BaseApiService.currentRoleId = null;
    return true;
  }

  /// Generate a mock CAPTCHA image and ID for authentication
  Future<Map<String, dynamic>> generateCaptcha() async {
    return {
      'captchaId': 'mock_captcha_123',
      'captchaImage': '',
    };
  }

  /// Validate user entered CAPTCHA value against captchaId
  Future<bool> validateCaptcha({
    required String captchaId,
    required String captchaValue,
  }) async {
    return true;
  }

  /// Request password reset via username and registered mobile number
  Future<Map<String, dynamic>> requestPasswordReset({
    required String username,
    required String mobileNumber,
  }) async {
    return {
      'status': 1,
      'message': 'OTP sent successfully to registered mobile',
      'userId': 1,
      'mfaReference': 'MFA-REF-9876',
    };
  }

  /// Validate OTP entered during MFA or password reset
  Future<Map<String, dynamic>> validateOtp({
    required int userId,
    required String mfaReference,
    required String otp,
  }) async {
    return {
      'status': 1,
      'isValid': true,
      'message': 'OTP validated successfully',
    };
  }

  /// Resend OTP to user's registered contact
  Future<Map<String, dynamic>> resendOtp({required int userId}) async {
    return {
      'status': 1,
      'message': 'New OTP resent successfully',
    };
  }

  /// Update password following OTP verification in forgot password workflow
  Future<Map<String, dynamic>> updateForgottenPassword({
    required int userId,
    required String otpReference,
    required String otp,
    required String newPassword,
  }) async {
    return {
      'status': 1,
      'message': 'Password has been updated successfully',
    };
  }

  /// Reset password directly for an authenticated or admin user
  Future<Map<String, dynamic>> resetPassword({
    required int userId,
    required String newPassword,
    required int updatedBy,
  }) async {
    return {
      'status': 1,
      'message': 'Password reset successfully',
    };
  }
}

