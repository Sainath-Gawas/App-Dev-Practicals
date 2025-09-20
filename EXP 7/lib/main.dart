import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

void main() {
  runApp(const RegistrationApp());
}

class RegistrationApp extends StatelessWidget {
  const RegistrationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registration App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const CreateAccountPage(),
    );
  }
}

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  String? _genderValue;
  String? _countryValue;
  String? _designationValue;
  bool _agreedToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0EBE2),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: ListView(
            children: [
              const Text(
                'CREATE ACCOUNT',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Join our community',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 32),
              _buildTextField('Name'),
              const SizedBox(height: 16),
              _buildTextField(
                'Mobile Number',
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                'Email Address',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              _buildTextField('Create Password', isPassword: true),
              const SizedBox(height: 16),
              _buildTextField('Confirm Password', isPassword: true),
              const SizedBox(height: 16),
              _buildGenderRadioButtons(),
              const SizedBox(height: 16),
              _buildDropdown(
                'Country',
                _countryValue,
                [
                  'India',
                  'USA',
                  'UK',
                  'Canada',
                  'Australia',
                  'Japan',
                  'Germany',
                  'France',
                  'Other',
                ],
                (String? newValue) {
                  setState(() {
                    _countryValue = newValue;
                  });
                },
              ),
              const SizedBox(height: 16),
              _buildDropdown(
                'Designation',
                _designationValue,
                ['Student', 'Professional', 'Other'],
                (String? newValue) {
                  setState(() {
                    _designationValue = newValue;
                  });
                },
              ),
              const SizedBox(height: 16),
              _buildTermsAndConditionsCheckbox(),
              const SizedBox(height: 24),
              _buildSignInButton(),
              const SizedBox(height: 16),
              _buildLoginLink(),
            ],
          ),
        ),
      ),
    );
  }

  // The helper methods from the previous response are placed here
  Widget _buildTextField(
    String hintText, {
    TextInputType? keyboardType,
    bool isPassword = false,
  }) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
    );
  }

  Widget _buildDropdown(
    String label,
    String? value,
    List<String> items,
    Function(String?) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            label,
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          value: value,
          items: items.map((String item) {
            return DropdownMenuItem<String>(value: item, child: Text(item));
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildGenderRadioButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Gender',
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildRadioTile('Male'),
            _buildRadioTile('Female'),
            _buildRadioTile('Other'),
          ],
        ),
      ],
    );
  }

  Widget _buildRadioTile(String title) {
    return Expanded(
      child: RadioListTile<String>(
        title: Text(title, style: const TextStyle(fontSize: 14)),
        value: title,
        groupValue: _genderValue,
        onChanged: (String? newValue) {
          setState(() {
            _genderValue = newValue;
          });
        },
        contentPadding: EdgeInsets.zero,
        dense: true,
      ),
    );
  }

  Widget _buildTermsAndConditionsCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: _agreedToTerms,
          onChanged: (bool? newValue) {
            setState(() {
              _agreedToTerms = newValue!;
            });
          },
        ),
        const Text('I agree to the terms and conditions'),
      ],
    );
  }

  Widget _buildSignInButton() {
    return ElevatedButton(
      onPressed: () {
        // Handle button press
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blueAccent,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      child: const Text(
        'SIGN IN',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildLoginLink() {
    return Align(
      alignment: Alignment.center,
      child: Text.rich(
        TextSpan(
          text: 'Already have an account? ',
          style: const TextStyle(color: Colors.black54),
          children: [
            TextSpan(
              text: 'Login',
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  // Handle login link tap
                },
            ),
          ],
        ),
      ),
    );
  }
}
