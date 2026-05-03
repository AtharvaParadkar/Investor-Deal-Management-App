import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// Persists user deal interests as a JSON list of IDs in SharedPreferences.
class MyInterestRepository {
  static const String _interestsKey = 'my_interests';

  Future<List<String>> getInterestedDealIds() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_interestsKey);
    if (jsonStr != null) {
      final List<dynamic> decoded = jsonDecode(jsonStr);
      return decoded.cast<String>();
    }
    return [];
  }

  Future<void> addInterest(String dealId) async {
    final ids = await getInterestedDealIds();
    if (!ids.contains(dealId)) {
      ids.add(dealId);
      await _saveIds(ids);
    }
  }

  Future<void> removeInterest(String dealId) async {
    final ids = await getInterestedDealIds();
    ids.remove(dealId);
    await _saveIds(ids);
  }

  Future<bool> isInterested(String dealId) async {
    final ids = await getInterestedDealIds();
    return ids.contains(dealId);
  }

  Future<void> _saveIds(List<String> ids) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_interestsKey, jsonEncode(ids));
  }
}
