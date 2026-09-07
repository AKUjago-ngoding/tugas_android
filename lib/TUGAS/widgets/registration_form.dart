import 'package:flutter/material.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key, this.onSubmit});
  final void Function(Map<String, String> values)? onSubmit;

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _key = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _pass = TextEditingController();
  final _confirm = TextEditingController();
  bool _obscure1 = true;
  bool _obscure2 = true;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    _pass.dispose();
    _confirm.dispose();
    super.dispose();
  }

  String? _req(String? v, String label) =>
      (v == null || v.trim().isEmpty) ? '$label wajib diisi' : null;

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: 12);
    return Form(
      key: _key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _name,
            textInputAction: TextInputAction.next,
            validator: (v) => _req(v, 'Nama'),
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.person_outline),
              labelText: 'Nama Pengguna',
              border: OutlineInputBorder(),
            ),
          ),
          gap,
          TextFormField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: (v) {
              if (_req(v, 'Email') != null) return _req(v, 'Email');
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v!.trim())) {
                return 'Format email tidak valid';
              }
              return null;
            },
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.email_outlined),
              labelText: 'Email Pengguna',
              border: OutlineInputBorder(),
            ),
          ),
          gap,
          TextFormField(
            controller: _phone,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            validator: (v) => _req(v, 'Telepon'),
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.phone_outlined),
              labelText: 'Telepon Pengguna',
              border: OutlineInputBorder(),
            ),
          ),
          gap,
          TextFormField(
            controller: _pass,
            obscureText: _obscure1,
            enableSuggestions: false,
            autocorrect: false,
            validator: (v) {
              if (_req(v, 'Password') != null) return _req(v, 'Password');
              if (v!.length < 6) return 'Minimal 6 karakter';
              return null;
            },
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock_outline),
              labelText: 'Password',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: Icon(_obscure1 ? Icons.visibility_off : Icons.visibility),
                onPressed: () => setState(() => _obscure1 = !_obscure1),
              ),
            ),
          ),
          gap,
          TextFormField(
            controller: _confirm,
            obscureText: _obscure2,
            enableSuggestions: false,
            autocorrect: false,
            validator: (v) {
              if (_req(v, 'Konfirmasi password') != null) return _req(v, 'Konfirmasi password');
              if (v != _pass.text) return 'Password tidak cocok';
              return null;
            },
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock),
              labelText: 'Konfirmasi Password',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: Icon(_obscure2 ? Icons.visibility_off : Icons.visibility),
                onPressed: () => setState(() => _obscure2 = !_obscure2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () {
              if (_key.currentState!.validate()) {
                final values = {
                  'name': _name.text.trim(),
                  'email': _email.text.trim(),
                  'phone': _phone.text.trim(),
                };
                widget.onSubmit?.call(values);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Registrasi valid — siap kirim ke API')),
                );
              }
            },
            child: const Text('Daftar'),
          ),
          // ponytail: no API call / loading state — add when connect to backend (use async + isLoading)
        ],
      ),
    );
  }
}
