import 'package:flutter/material.dart';

class AppForm extends StatefulWidget {
  const AppForm({Key? key}) : super(key: key);

  @override
  _AppFormState createState() => _AppFormState();
}

class _AppFormState extends State<AppForm> {
  final _formKey = GlobalKey<FormState>();
  final _enteController = TextEditingController();
  final _passController = TextEditingController();

  @override
  void dispose() {
    _enteController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TITLE AH')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _enteController,
                // Posisikan validator di luar InputDecoration
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'BACA MASS JANGAN boolBOOL AJH';
                  } else if (!value.contains('@')) {
                    return 'FORMAT NYA MASSS KLO NGETIK DI PIKIR MASS';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Masukkan Email',
                  errorStyle: const TextStyle(
                    color: Colors.red, // Mengubah warna teks error (misal jadi orange)
                    fontSize: 25.0, // Mengubah ukuran font
                    fontWeight: FontWeight.bold, // Membuat teks jadi tebal
                    fontStyle: FontStyle.italic, // Membuat teks jadi miring
                  ),
                ),
              ),

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Validasi Sukses'),
                          content: Text(
                            'Email yang Anda masukkan:\n${_enteController.text}',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: const Text('Daftar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
