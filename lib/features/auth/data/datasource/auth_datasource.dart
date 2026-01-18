import 'package:secure_task/core/database/app_database/app_database.dart';
import 'package:secure_task/core/security/pin_hasher.dart';

class AuthDatasource {
  final AppDatabase _database;

  AuthDatasource(this._database);

  Future<UserData> register({
    required String name,
    required int age,
    required String job,
    required String sex,
    required String pinCodeHash,
  }) async {
    final hashedPin = PinHasher.hashPin(pinCodeHash);

    final userId = await _database
        .into(_database.user)
        .insert(
          UserCompanion.insert(
            name: name,
            age: age,
            job: job,
            sex: sex,
            pinCodeHash: hashedPin,
          ),
        );

    return await (_database.select(
      _database.user,
    )..where((u) => u.id.equals(userId))).getSingle();
  }

  Future<UserData?> login({required String pinCode}) async {
    final user = await getCurrentUser();

    if (user == null) return null;

    final isValid = PinHasher.verifyPin(pinCode, user.pinCodeHash);
    return isValid ? user : null;
  }

  Future<UserData?> getCurrentUser() async {
    return await _database.select(_database.user).getSingleOrNull();
  }

  Future<void> logout() async {
    await _database.delete(_database.user).go();
    await _database.delete(_database.taskGroups).go();
    await _database.delete(_database.tasks).go();
    await _database.delete(_database.notes).go();
  }
}
