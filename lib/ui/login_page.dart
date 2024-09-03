import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/provider/auth_provider.dart';
import 'package:to_do_list/ui/register_page.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login_page';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var txtEditUsername = TextEditingController();
  var txtEditPass = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    txtEditUsername.dispose();
    txtEditPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Text(
                  "Masuk Akun",
                  style: Theme.of(context).textTheme.titleLarge,
                )),
                const SizedBox(height: 8),
                const Text(
                  "Masukkan nomor handphone atau email & password kamu untuk masuk ke aplikasi",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                const Text("Nomor HP atau email"),
                TextFormField(
                  controller: txtEditUsername,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email tidak boleh kosong";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      hintText: "Masukkan email",
                      hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                      prefixIcon: Icon(
                        Icons.email_rounded,
                        color: Color(0xffEF6A37),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffEF6A37))),
                      contentPadding: EdgeInsets.symmetric(vertical: 16)),
                ),
                const SizedBox(height: 24),
                const Text("Password"),
                TextFormField(
                  obscureText: true,
                  controller: txtEditPass,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password tidak boleh kosong";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      hintText: "Masukkan password",
                      hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                      prefixIcon: Icon(
                        Icons.lock_outline_rounded,
                        color: Color(0xffEF6A37),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffEF6A37))),
                      contentPadding: EdgeInsets.symmetric(vertical: 16)),
                ),
                const SizedBox(height: 24),
                const Row(
                  children: [
                    Spacer(),
                    Text("Lupa password?"),
                  ],
                ),
                const SizedBox(height: 24),
                context.watch<AuthProvider>().isLoadingLogin
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final scaffoldMessenger =
                                ScaffoldMessenger.of(context);

                            final authRead = context.read<AuthProvider>();

                            await authRead.login(
                                txtEditUsername.text, txtEditPass.text);
                            final result = authRead.loginResponse;
                            if (result?.statusCode == 2110) {
                              Navigator.pushNamed(context, LoginPage.routeName);
                            } else {
                              if (context.mounted) {
                                final loginError = context
                                    .read<AuthProvider>()
                                    .errorMessageLogin;
                                scaffoldMessenger.showSnackBar(
                                  SnackBar(
                                    content: Text(loginError!),
                                  ),
                                );
                              }
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(
                            MediaQuery.of(context).size.width,
                            50,
                          ),
                          backgroundColor: const Color(0xffEF6A37),
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () async {
                    Navigator.pushNamed(context, RegisterPage.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(
                      MediaQuery.of(context).size.width,
                      50,
                    ),
                    backgroundColor: const Color(0xffEF6A37),
                  ),
                  child: const Text(
                    "Register",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
