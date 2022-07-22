import 'dart:io';

import 'package:chat/models/auth_form_data.dart';
import 'package:chat/widgets/user_image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({required this.onSubmit, Key? key}) : super(key: key);

  final void Function(AuthFormData) onSubmit;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formData = AuthFormData();
  final _formKey = GlobalKey<FormState>();

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Theme.of(context).errorColor,
      ),
    );
  }

  void _handleImagePick(File image) {
    _formData.image = image;
  }

  void _submitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    if (_formData.image == null && _formData.isSignup) {
      return _showError('Imagem não selecionada.');
    }

    widget.onSubmit(_formData);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(24),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_formData.isSignup)
                UserImagePicker(onImagePick: _handleImagePick),
              if (_formData.isSignup)
                TextFormField(
                  key: const ValueKey('name'),
                  initialValue: _formData.name,
                  onChanged: (name) => _formData.name = name,
                  validator: (name) {
                    final _name = name ?? '';
                    if (_name.trim().length < 5) {
                      return 'Nome deve ter no mínimo 4 caracteres.';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                  ),
                ),
              TextFormField(
                key: const ValueKey('email'),
                initialValue: _formData.email,
                onChanged: (email) => _formData.email = email,
                validator: (email) {
                  final _email = email ?? '';
                  if (!_email.contains('@')) return 'Insira um e-mail válido.';
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                ),
              ),
              TextFormField(
                key: const ValueKey('password'),
                initialValue: _formData.password,
                onChanged: (password) => _formData.password = password,
                obscureText: true,
                validator: (password) {
                  final _password = password ?? '';
                  if (_password.length < 6) {
                    return 'A senha deve ter no mínimo 6 caracteres.';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Senha',
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(_formData.isLogin ? 'Entrar' : 'Cadastrar'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _formData.toggleMode();
                  });
                },
                child: Text(
                  _formData.isLogin
                      ? 'Criar uma nova conta?'
                      : 'Já possui conta?',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
