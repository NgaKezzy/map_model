import 'package:flutter/material.dart';
import 'package:test/cover_flow_list.dart';
import 'package:test/entity/user.dart';
import 'package:test/model/user_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MayHomePage(),
    );
  }
}

class MayHomePage extends StatefulWidget {
  const MayHomePage({super.key});

  @override
  State<MayHomePage> createState() => _MayHomePageState();
}

class _MayHomePageState extends State<MayHomePage> {
  User? user;

  @override
  void initState() {
    super.initState();

    // Tạo UserModel instance trước, rồi mới gọi toEntity()
    final userModel = UserModel(
      name: 'John Doe',
      id: '123',
      birthday: '1990-01-01',
    );
    user = userModel.toEntity();

    // Hoặc chain luôn:
    // user = UserModel(name: 'name', id: 'id', birthday: 'birthday').toEntity();

    // Hoặc từ JSON:
    // user = UserModel.fromJson({'name': 'John', 'id': '123', 'birth_day': '1990-01-01'}).toEntity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(user?.name ?? 'No user'),
            Text(user?.id ?? 'No user'),
            Text(user?.birthday ?? 'No user'),
          ],
        ),
      ),
    );
  }
}
