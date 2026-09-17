import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// Cards ko phone mein permanently save/load karta hai (app band ho ke bhi rahe).
class CardStorage {
  static const _key = 'saved_cards';

  // Saare saved cards laao
  static Future<List<Map<String, dynamic>>> getCards() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null || raw.isEmpty) return [];
    final List decoded = jsonDecode(raw);
    return decoded.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  // Naya card add karo
  static Future<void> addCard(Map<String, dynamic> card) async {
    final prefs = await SharedPreferences.getInstance();
    final cards = await getCards();
    cards.add(card);
    await prefs.setString(_key, jsonEncode(cards));
  }

  // Ek card hatao (index se)
  static Future<void> removeCard(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final cards = await getCards();
    if (index >= 0 && index < cards.length) {
      cards.removeAt(index);
      await prefs.setString(_key, jsonEncode(cards));
    }
  }
}
