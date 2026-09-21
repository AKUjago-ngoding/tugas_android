import 'package:flutter/material.dart';
import '../../../../core/services/preference_handler.dart';
import 'tugas_session_profile_screen.dart';

class TugasSessionLoginScreen extends StatefulWidget {
  const TugasSessionLoginScreen({super.key});

  @override
  State<TugasSessionLoginScreen> createState() => _TugasSessionLoginScreenState();
}

class _TugasSessionLoginScreenState extends State<TugasSessionLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: 'rinaldi@flutter.dev');
  final _passwordController = TextEditingController(text: 'secret123');
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      // Tampilkan AlertDialog konfirmasi seperti pada materi Day 15
      showDialog(
        context: context,
        builder: (dialogContext) => AlertDialog(
          icon: const Icon(Icons.security, size: 40, color: Colors.blueAccent),
          title: const Text('Konfirmasi Login & Token'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Akun berhasil divalidasi. Sesi login dan Bearer Auth Token akan disimpan ke SharedPreferences:',
                style: TextStyle(fontSize: 13, color: Colors.black87),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email: ${_emailController.text}',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Token: eyJhbGciOi... (Auto Generated)',
                      style: TextStyle(fontSize: 12, color: Colors.blueGrey),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext), // Tutup dialog
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () async {
                // 1. Tutup pop-up dialog
                Navigator.pop(dialogContext);

                // 2. Simpan status login & Token ke SharedPreferences
                final dummyToken =
                    'jwt_token_ppkd_${DateTime.now().millisecondsSinceEpoch}';
                final loginTimestamp =
                    '${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}:${DateTime.now().second.toString().padLeft(2, '0')} WIB';

                await PreferenceHandler.setLogin(true);
                await PreferenceHandler.setUserEmail(_emailController.text);
                await PreferenceHandler.setAuthToken(dummyToken);
                await PreferenceHandler.setLoginTime(loginTimestamp);

                if (!mounted) return;

                // 3. Pindah ke halaman profil / konfirmasi sukses
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const TugasSessionProfileScreen(),
                  ),
                );
              },
              child: const Text('Lanjutkan Login'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tugas Day 15: Login Session'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 12),
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.lock_clock, size: 56, color: Colors.blue),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Autentikasi Sesi & Token',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Masukkan email & password untuk membuat token aktif.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
                const SizedBox(height: 28),

                // Email Field
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Alamat Email',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Email wajib diisi';
                    }
                    if (!value.contains('@')) {
                      return 'Format email tidak valid';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Password Field
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password wajib diisi';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Submit Button
                ElevatedButton.icon(
                  onPressed: _handleLogin,
                  icon: const Icon(Icons.login),
                  label: const Text('Masuk & Terbitkan Token'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

