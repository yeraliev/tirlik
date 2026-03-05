import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleCubit extends Cubit<Locale> {
  static const String _localeKey = 'selected_locale';
  late SharedPreferences _prefs;

  LocaleCubit() : super(const Locale('en'));

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    final savedLocaleCode = _prefs.getString(_localeKey) ?? 'en';
    emit(Locale(savedLocaleCode));
  }

  Future<void> setLocale(Locale locale) async {
    await _prefs.setString(_localeKey, locale.languageCode);
    emit(locale);
  }
}
