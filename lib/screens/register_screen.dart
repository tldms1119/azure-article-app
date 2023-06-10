import 'package:azure_article/models/article_form_model.dart';
import 'package:azure_article/models/response_model.dart';
import 'package:azure_article/screens/home_screen.dart';
import 'package:azure_article/services/api_service.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  late String _title = '';
  late String _contents = '';
  late String _thumb = '';
  late String _category = 'tab1';
  late String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.black45,
        backgroundColor: Colors.white,
        title: const Text('Register'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Title',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onSaved: (value) {
                  setState(() {
                    _title = value as String;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty || value.trim() == '') {
                    return "제목을 입력하세요";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: '제목을 입력하세요',
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Category',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Radio(
                    value: 'tab1',
                    groupValue: _category,
                    onChanged: (value) {
                      setState(() {
                        _category = 'tab1';
                      });
                    },
                  ),
                  const Text(
                    'Tab1',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Radio(
                    value: 'tab2',
                    groupValue: _category,
                    onChanged: (value) {
                      setState(() {
                        _category = 'tab2';
                      });
                    },
                  ),
                  const Text(
                    'Tab2',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Image URL',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onSaved: (value) {
                  setState(() {
                    _thumb = value as String;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty || value.trim() == '') {
                    return "이미지 주소를 입력하세요";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: '이미지 주소를 입력하세요',
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Contents',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onSaved: (value) {
                  setState(() {
                    _contents = value as String;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty || value.trim() == '') {
                    return "내용을 입력하세요";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: '내용을 입력하세요',
                ),
                maxLines: 8,
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Password',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onSaved: (value) {
                  setState(() {
                    _password = value as String;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty || value.trim() == '') {
                    return "등록용 암호를 입력하세요";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: '등록용 암호를 입력하세요',
                ),
                obscureText: true,
              ),
              ElevatedButton(
                onPressed: () {
                  // validate
                  if (_formKey.currentState!.validate()) {
                    // validation 성공 시 폼 저장
                    _formKey.currentState!.save();
                    // print(_title);
                    // print(_contents);
                    // print(_category);
                    // print(_password);

                    final Future<ResponseModel> result = ApiService.postArticle(
                        ArticleFormModel(
                            _title, _contents, _thumb, _password, _category));

                    // Display a confirmation dialog
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Registration'),
                        content: FutureBuilder(
                          future: result,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(snapshot.data!.message);
                            } else {
                              return const Text('waiting...');
                            }
                          },
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ),
                              );
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
