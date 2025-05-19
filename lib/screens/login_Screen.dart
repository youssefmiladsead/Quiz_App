import 'package:flutter/material.dart';
import 'category_screen.dart';
import '../globals.dart' as globals;

final _formkey = GlobalKey<FormState>();

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  final nameRegex = RegExp(r'^(?=.*[A-Z])(?=.*\d)[A-Za-z\d]+$');
  final passwordRegex = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$',
  );

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool rememberMe = false;
  final TextEditingController _usernameController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 63, 86, 128),
        ),
        width: double.infinity,
        child: Column(
          children: [
            const SizedBox(height: 150),
            Image.asset(
              'assets/images/1.png',
              width: 150,
            ),
            const SizedBox(height: 50),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(40),
                    ),
                  ),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        const SizedBox(height: 25),
                        const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 350,
                          child: TextFormField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Colors.grey,
                                size: 20,
                              ),
                              contentPadding: const EdgeInsets.only(top: 12),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                                borderSide: const BorderSide(
                                  width: 2,
                                  color: Colors.grey,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                                borderSide: const BorderSide(
                                  width: 2,
                                  color: Colors.grey,
                                ),
                              ),
                              hintText: 'Username',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Username is required';
                              }
                              if (!widget.nameRegex.hasMatch(value)) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Username must start with a capital letter and include at least one number.',
                                      ),
                                      backgroundColor: Colors.redAccent,
                                    ),
                                  );
                                });
                                return '';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 350,
                          child: TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: Colors.grey,
                                size: 20,
                              ),
                              suffixIcon: const Icon(Icons.visibility_off),
                              contentPadding: const EdgeInsets.only(
                                left: 8,
                                top: 12,
                                bottom: 12,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                                borderSide: const BorderSide(
                                  width: 2,
                                  color: Colors.grey,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                                borderSide: const BorderSide(
                                  width: 2,
                                  color: Colors.grey,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                                borderSide: const BorderSide(
                                  width: 2,
                                  color: Colors.grey,
                                ),
                              ),
                              hintText: 'Password',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              }
                              if (!widget.passwordRegex.hasMatch(value)) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Password must contain: uppercase, lowercase, number, special character, and be at least 8 characters long.',
                                      ),
                                      backgroundColor: Colors.redAccent,
                                    ),
                                  );
                                });
                                return '';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(right: 50),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              width: 200,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Text("New to quizz app?"),
                                  TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      'Register',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 25, 74, 101),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 60),
                        ElevatedButton(
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              // تخزين اسم المستخدم في global variable عشان نستخدمه في صفحات تانية
                              globals.username = _usernameController.text;

                              // الانتقال لصفحة اختيار الكاتيجوري (الامتحانات)
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CategoryScreen(),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(180, 50),
                            backgroundColor:
                                const Color.fromARGB(255, 25, 74, 101),
                            foregroundColor: Colors.white,
                            shape: const StadiumBorder(),
                            shadowColor: Colors.black,
                            elevation: 5,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 15,
                            ),
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: const Text('Login'),
                        ),
                        const SizedBox(height: 25),
                        Icon(
                          Icons.fingerprint,
                          size: 75,
                          color: Colors.lightBlue[400],
                        ),
                        const SizedBox(height: 7),
                        Text(
                          'Use Touch ID',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: rememberMe,
                                  onChanged: (v) {
                                    setState(() {
                                      rememberMe = v!;
                                    });
                                  },
                                  activeColor:
                                      const Color.fromARGB(255, 25, 100, 186),
                                ),
                                const Text(
                                  'Remember Me',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 25, 74, 101),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
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
