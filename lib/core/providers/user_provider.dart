// import 'package:elevate_ecommerce/features/auth/logged_user_data/data/models/user_response/user.dart';
// import 'package:flutter/foundation.dart';
// import 'package:injectable/injectable.dart';

// @injectable
// class UserProvider with ChangeNotifier {
//   static final UserProvider _instance = UserProvider._internal();
//   factory UserProvider() => _instance;

//   UserProvider._internal();

//   UserData? _userData;

//   UserData? get userData => _userData;

//   Future<void> setUserData(UserData data) async {
//     _userData = data;
//     print('Setting user data: ${data.toJson()}');
//     notifyListeners();
//   }

//   void clearUserData() {
//     _userData = null;
//     notifyListeners();
//   }

//   void updateUserData(Map<String, dynamic> updatedFields) {
//     if (_userData != null) {
//       _userData = UserData(
//         id: updatedFields['_id'] ?? _userData!.id,
//         firstName: updatedFields['firstName'] ?? _userData!.firstName,
//         lastName: updatedFields['lastName'] ?? _userData!.lastName,
//         email: updatedFields['email'] ?? _userData!.email,
//         gender: updatedFields['gender'] ?? _userData!.gender,
//         phone: updatedFields['phone'] ?? _userData!.phone,
//         photo: updatedFields['photo'] ?? _userData!.photo,
//         role: updatedFields['role'] ?? _userData!.role,
//         createdAt: updatedFields['createdAt'] ?? _userData!.createdAt,
//         passwordChangedAt:
//             updatedFields['passwordChangedAt'] ?? _userData!.passwordChangedAt,
//         wishlist: updatedFields['wishlist'] ?? _userData!.wishlist,
//         addresses: updatedFields['addresses'] ?? _userData!.addresses,
//         passwordResetCode:
//             updatedFields['passwordResetCode'] ?? _userData!.passwordResetCode,
//         passwordResetExpires: updatedFields['passwordResetExpires'] ??
//             _userData!.passwordResetExpires,
//         resetCodeVerified:
//             updatedFields['resetCodeVerified'] ?? _userData!.resetCodeVerified,
//       );
//       notifyListeners();
//     }
//   }
// }
