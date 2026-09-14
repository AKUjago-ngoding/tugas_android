import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

// PENERAPAN STATEFUL WIDGET PADA FLUTTER

class UserInputScreen extends StatefulWidget {
  const UserInputScreen({super.key});

  @override
  State<UserInputScreen> createState() => _UserInputScreenState();
}

class _UserInputScreenState extends State<UserInputScreen> {
  final _formkey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String _submitedData = '';

  void _handleSubmit() {
    if (_formkey.currentState!.validate()) {
      setState(() {
        _submitedData =
            'Name: ${_nameController.text}\nEmail: ${_emailController.text}';
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Data submitted: $_submitedData')));
    }
  }

  void _handleReset() {
    _nameController.clear();
    _emailController.clear();

    _formkey.currentState?.reset();

    setState(() {
      _submitedData = '';
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
        title: const Text('User Input Form'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Information'),
                    content: const Text(
                      'This is a simple user input form using StatefulWidget.',
                    ),
                    actions: [
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(16.0),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                // autovalidateMode: AutovalidateMode.always,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: 'Please enter your Email',
                  ),
                  FormBuilderValidators.email(errorText: 'Format email salah'),
                ]),
                onFieldSubmitted: (_) => _handleSubmit(),
              ),
              const SizedBox(height: 16.0),
              Divider(color: Colors.grey, thickness: 1.0),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _handleSubmit,
                  label: const Text('KIRIM DATA YAH'),
                  icon: const Icon(Icons.send),
                ),
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _handleReset,
                  child: Text('Langsung Saja reset'),
                ),
              ),

              const SizedBox(height: 32),
              Divider(color: Colors.grey, thickness: 1.0),

              if (_submitedData.isNotEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      'Submitted Data:\n$_submitedData',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ),
                ),
              const SizedBox(height: 16.0),
              Text('Hasil Submited Data di tampilkan: '),
              Text(_submitedData),
            ],
          ),
        ),
      ),
    );
  }
}
