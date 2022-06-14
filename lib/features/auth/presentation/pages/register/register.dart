import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/core/theme/color_theme.dart';
import 'package:notes/core/theme/text_theme.dart';
import 'package:notes/features/todo/presentation/widgets/custom_button.dart';
import 'package:notes/features/todo/presentation/widgets/custom_dialog.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  bool isObscurePassword = true;

  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool isObscureConfirmPassword = true;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/hero.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                color: Colors.white),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Daftar",
                    style: ThemeText.heroStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _emailController,
                    enableSuggestions: true,
                    autofillHints: const [AutofillHints.email],
                    decoration: InputDecoration(
                      hintText: "Email",
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(200),
                          borderSide: BorderSide(color: ThemeColor.typography)),
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Email tidak boleh kosong";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: isObscurePassword,
                    enableSuggestions: true,
                    autofillHints: const [AutofillHints.newPassword],
                    decoration: InputDecoration(
                      hintText: "Password",
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(200),
                          borderSide: BorderSide(color: ThemeColor.typography)),
                      suffixIcon: IconButton(
                        icon: isObscurePassword
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off_outlined),
                        onPressed: () {
                          setState(
                              () => isObscurePassword = !isObscurePassword);
                        },
                      ),
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Password tidak boleh kosong";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: isObscureConfirmPassword,
                    autofillHints: const [AutofillHints.newPassword],
                    decoration: InputDecoration(
                      hintText: "Confirm Password",
                      suffixIcon: IconButton(
                        icon: isObscureConfirmPassword
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off_outlined),
                        onPressed: () {
                          setState(() {
                            isObscureConfirmPassword =
                                !isObscureConfirmPassword;
                          });
                        },
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(200),
                          borderSide: BorderSide(color: ThemeColor.typography)),
                    ),
                    validator: (val) {
                      if (val != _passwordController.text) {
                        return "Password tidak sama";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    child: CustomButton(
                      text: "Daftar",
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            await _auth.createUserWithEmailAndPassword(
                                email: _emailController.text,
                                password: _passwordController.text);
                            await showCustomDialog(
                                    context,
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.check_circle,
                                          color: ThemeColor.greenish,
                                          size: 48,
                                        ),
                                        const SizedBox(height: 20),
                                        Text(
                                          "Pendaftaran Berhasil",
                                          style: ThemeText.titleStyle.copyWith(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ))
                                .then((value) => value
                                    ? GoRouter.of(context).go('/login')
                                    : null);
                          } on FirebaseAuthException catch (e) {
                            await showCustomDialog(
                                context,
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.warning,
                                      color: ThemeColor.primaryColor,
                                      size: 48,
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      e.code == 'weak-password'
                                          ? 'Password terlalu lemah'
                                          : e.code == 'email-already-in-use'
                                              ? 'Email sudah terdaftar'
                                              : 'Terjadi kesalahan',
                                      style: ThemeText.titleStyle.copyWith(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ));
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
