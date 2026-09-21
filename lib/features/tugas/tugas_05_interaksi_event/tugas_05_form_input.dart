import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class Tugas05FormInputWidget extends StatefulWidget {
  const Tugas05FormInputWidget({super.key});

  @override
  State<Tugas05FormInputWidget> createState() => _Tugas05FormInputWidgetState();
}

class _Tugas05FormInputWidgetState extends State<Tugas05FormInputWidget> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String _submittedData = '';

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _submittedData =
            'Nama: ${_nameController.text}\nEmail: ${_emailController.text}';
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data Terkirim: ${_nameController.text}'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _handleReset() {
    _nameController.clear();
    _emailController.clear();
    _formKey.currentState?.reset();

    setState(() {
      _submittedData = '';
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tugas 5: Form Input Pengguna'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext ctx) {
                  return AlertDialog(
                    title: const Text('Informasi Modul'),
                    content: const Text(
                      'Form input interaktif dengan validasi menggunakan StatefulWidget dan FormBuilderValidators.',
                    ),
                    actions: [
                      TextButton(
                        child: const Text('Tutup'),
                        onPressed: () => Navigator.of(ctx).pop(),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Nama Lengkap',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Silakan masukkan nama Anda';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Alamat Email',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                            errorText: 'Email tidak boleh kosong',
                          ),
                          FormBuilderValidators.email(
                            errorText: 'Format alamat email tidak valid',
                          ),
                        ]),
                        onFieldSubmitted: (_) => _handleSubmit(),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: _handleSubmit,
                              icon: const Icon(Icons.send),
                              label: const Text('Kirim Data'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          OutlinedButton(
                            onPressed: _handleReset,
                            child: const Text('Reset Form'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              if (_submittedData.isNotEmpty)
                Card(
                  color: Colors.blue.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.check_circle, color: Colors.green),
                            SizedBox(width: 8),
                            Text(
                              'Hasil Data yang Disubmit:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 16),
                        Text(
                          _submittedData,
                          style: const TextStyle(fontSize: 15, height: 1.4),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

