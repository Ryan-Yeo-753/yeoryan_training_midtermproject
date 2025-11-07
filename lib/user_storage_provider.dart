import 'dart:core';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class User {
  final String username;
  final String password;
  final int userBalance;
  final int userNumber;

  User(this.username, this.password, this.userBalance, this.userNumber);
}

final usersNotifierProvider = NotifierProvider<UserDatabase, List<User>>(
  UserDatabase.new,
);

class UserDatabase extends Notifier<List<User>> {

  @override
  List<User> build() {
    return [];
  }

  void addUser (User user) {
    state = [...state, user];
  }
}
