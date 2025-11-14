import 'dart:core';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class User {
  final String username;
  final String password;
  final int userBalance;
  final int userDebt;

  User(this.username, this.password, this.userBalance, this.userDebt);
}

class UserDatabase extends Notifier<List<User>> {

  @override
  List<User> build() => [];

  void addUser (User user) => state = [...state, user];

  void removeUser(User user) => state = state.where(
    (u) => u.username != user.username
  ).toList();
}

final usersNotifierProvider = NotifierProvider<UserDatabase, List<User>>(
  UserDatabase.new,
);

class CurrentUser extends Notifier<User> {

  @override
  User build() => User('Guest', 'password', 0, 0);

  void newCurrentUser (User user) => state = user;

  void clearCurrentUser() => state = User('Guest', 'password', 0, 0);

  void updateCurrentUser(User currentUser) {
    ref.read(usersNotifierProvider.notifier).removeUser(currentUser);
    ref.read(usersNotifierProvider.notifier).addUser(currentUser);
  }
}

final currentUserNotifierProvider = NotifierProvider<CurrentUser, User>(
  CurrentUser.new,
);