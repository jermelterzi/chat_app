import 'dart:async';
import 'dart:math';

import 'package:chat/models/chat_user.dart';
import 'dart:io';

import 'package:chat/services/auth/auth_service.dart';

class AuthMockService implements AuthService {
  static final _defaultaUser = ChatUser(
    id: '1',
    name: 'Teste',
    email: 'teste@afixcode.com.br',
    imageUrl: 'assets/images/avatar.png',
  );
  static Map<String, ChatUser> _users = {
    _defaultaUser.email: _defaultaUser,
  };
  static ChatUser? _currentUser;
  static MultiStreamController<ChatUser?>? _controller;
  static final _userStream = Stream<ChatUser?>.multi((controller) {
    _controller = controller;
    _updateUser(_defaultaUser);
  });

  @override
  ChatUser? get currentUser => _currentUser;

  @override
  Stream<ChatUser?> get userChanges => _userStream;

  @override
  Future<void> login(String email, String password) async {
    _updateUser(_users[email]);
  }

  @override
  Future<void> logout() async {
    _updateUser(null);
  }

  @override
  Future<void> signup(
    String name,
    String email,
    String password,
    File? image,
  ) async {
    final newUser = ChatUser(
      id: Random().nextDouble().toString(),
      name: name,
      email: email,
      imageUrl: image?.path ?? 'assets\images\avatar.png',
    );

    _users.putIfAbsent(email, () => newUser);
    _updateUser(newUser);
  }

  static void _updateUser(ChatUser? user) {
    _currentUser = user;
    _controller?.add(_currentUser);
  }
}
