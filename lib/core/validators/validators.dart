import 'package:flutter/material.dart';
import 'package:secure_task/l10n/app_localizations.dart';

class Validators {
  final AppLocalizations _l10n;

  Validators(this._l10n);

  static Validators of(BuildContext context) {
    return Validators(AppLocalizations.of(context)!);
  }

  String? name(String? value) {
    if (value == null || value.trim().isEmpty) return _l10n.validatorNameRequired;
    if (value.trim().length < 2) return _l10n.validatorNameMinLength;
    return null;
  }

  String? age(String? value) {
    if (value == null || value.trim().isEmpty) return _l10n.validatorAgeRequired;
    final age = int.tryParse(value.trim());
    if (age == null) return _l10n.validatorAgeInvalidNumber;
    if (age < 1 || age > 150) return _l10n.validatorAgeInvalid;
    return null;
  }

  String? job(String? value) {
    if (value == null || value.trim().isEmpty) return _l10n.validatorJobRequired;
    if (value.trim().length < 2) return _l10n.validatorJobMinLength;
    return null;
  }

  String? sex(String? value) {
    if (value == null || value.isEmpty) return _l10n.validatorSexRequired;
    return null;
  }

  String? title(String? value) {
    if (value == null || value.trim().isEmpty) return _l10n.validatorTitleRequired;
    if (value.trim().length < 3) return _l10n.validatorTitleMinLength;
    return null;
  }

  String? description(String? value) {
    if (value == null || value.trim().isEmpty) return _l10n.validatorDescriptionRequired;
    if (value.trim().length < 5) return _l10n.validatorDescriptionMinLength;
    return null;
  }

  String? taskGroup(int? value) {
    if (value == null) return _l10n.validatorTaskGroupRequired;
    return null;
  }

  String? priority(int? value) {
    if (value == null) return _l10n.validatorPriorityRequired;
    if (value < 0 || value > 2) return _l10n.validatorPriorityInvalid;
    return null;
  }

  String? dueDate(DateTime? value) {
    if (value != null && value.isBefore(DateTime.now())) return _l10n.validatorDueDatePast;
    return null;
  }
}
