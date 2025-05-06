import 'package:coffe_front/features/auth/presentation/viewmodels/auth_view_model.dart';
import 'package:coffe_front/utils/color_manager.dart';
import 'package:coffe_front/utils/string_manager.dart';
import 'package:coffe_front/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterForm extends ConsumerStatefulWidget {
  const RegisterForm({super.key});

  @override
  ConsumerState<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  bool _isObsecure = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _obsecure() {
    setState(() {
      _isObsecure = !_isObsecure;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prov = ref.watch(authProvider);
    final provRead = ref.read(authProvider.notifier);
    void register() {
      if (_formKey.currentState!.validate()) {
        provRead.register(
          _usernameController.text,
          _emailController.text,
          _passwordController.text,
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: AlignmentDirectional.topStart,
              child: TextStyles.poppins_16_400(StringManager.pleaseEnter),
            ),
            const SizedBox(height: 60),
            TextStyles.poppins_16_400(StringManager.email),
            const SizedBox(height: 13),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(33),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                hintText: StringManager.emailHint,
                hintStyle: GoogleFonts.poppins(fontWeight: FontWeight.w300),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!RegExp(
                  r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$',
                ).hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextStyles.poppins_16_400(StringManager.userName),
            const SizedBox(height: 13),
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(33),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                hintText: StringManager.userHint,
                hintStyle: GoogleFonts.poppins(fontWeight: FontWeight.w300),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your username';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextStyles.poppins_16_400(StringManager.password),
            const SizedBox(height: 13),
            TextFormField(
              controller: _passwordController,
              obscureText: _isObsecure,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: _obsecure,
                  icon: Icon(
                    _isObsecure ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(33),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                hintText: StringManager.passHint,
                hintStyle: GoogleFonts.poppins(fontWeight: FontWeight.w300),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 30),
            Center(
              child:
                  prov is LoadingState
                      ? Center(child: CircularProgressIndicator())
                      : SizedBox(
                        width: 230,
                        height: 49,
                        child: ElevatedButton(
                          onPressed: register,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorManager.navy,
                          ),
                          child: TextStyles.poppins_16_400(
                            "Register",
                            color: Colors.white,
                          ),
                        ),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
