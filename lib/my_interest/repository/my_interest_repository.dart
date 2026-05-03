import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// Repository for managing user deal interests.
/// Uses SharedPreferences to persist interested deal IDs as JSON.
class MyInterestRepository {
  /// SharedPreferences key for storing interest data.
  static const String _interestsKey = 'my_interests';

  /// Returns all deal IDs the user has expressed interest in.
  Future<List<String>> getInterestedDealIds() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_interestsKey);
    if (jsonStr != null) {
      final List<dynamic> decoded = jsonDecode(jsonStr);
      return decoded.cast<String>();
    }
    return [];
  }

  /// Adds interest for a deal.
  Future<void> addInterest(String dealId) async {
    final ids = await getInterestedDealIds();
    if (!ids.contains(dealId)) {
      ids.add(dealId);
      await _saveIds(ids);
    }
  }

  /// Removes interest for a deal.
  Future<void> removeInterest(String dealId) async {
    final ids = await getInterestedDealIds();
    ids.remove(dealId);
    await _saveIds(ids);
  }

  /// Checks if the user is interested in a specific deal.
  Future<bool> isInterested(String dealId) async {
    final ids = await getInterestedDealIds();
    return ids.contains(dealId);
  }

  /// Persists the interest IDs list to SharedPreferences.
  Future<void> _saveIds(List<String> ids) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_interestsKey, jsonEncode(ids));
  }
}
