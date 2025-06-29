import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({super.key, required this.userCode});
  final String userCode;
  @override
  Widget build(BuildContext context) {
    final ProfileListProv listProv = context.read<ProfileListProv>();
    if (listProv.exist(userCode)) {
      return ChangeNotifierProvider.value(
        value: listProv.getProfileProd(userCode),
        builder: (context, child) => Consumer<ProfileProv>(
          builder: (context, value, child) => Column(
            children: [
              Text("Not Created but utilized $userCode"),
              Text(listProv.getProfileProd(userCode).count.toString()),
              ElevatedButton(
                onPressed: () {
                  listProv.getProfileProd(userCode).count++;
                },
                child: const Text("Add value"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Profile(
                        userCode: userCode == "kaushal" ? "vinay" : "kaushal",
                      ),
                    ),
                  );
                },
                child: const Text("Navigate"),
              )
            ],
          ),
        ),
      );
    }
    return ChangeNotifierProvider(
      lazy: false,
      create: (context) => ProfileProv(
        userCode: userCode,
        refCallback: (profileProv) {
          print("add callback ${profileProv.runtimeType}");
          listProv.addProfile(profileProv);
        },
        onDispose: (profileProv) {
          listProv.removeProfile(profileProv);
        },
      ),
      child: NewlyCreatedProfile(userCode: userCode, listProv: listProv),
    );
  }
}

class NewlyCreatedProfile extends StatelessWidget {
  const NewlyCreatedProfile({
    super.key,
    required this.userCode,
    required this.listProv,
  });

  final String userCode;
  final ProfileListProv listProv;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProv>(
      builder: (context, value, child) => Column(
        children: [
          Text("Newly created profile prov $userCode"),
          Text(listProv.getProfileProd(userCode).count.toString()),
          ElevatedButton(
            onPressed: () {
              listProv.getProfileProd(userCode).count++;
            },
            child: const Text("Add value"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Profile(
                    userCode: userCode == "kaushal" ? "vinay" : "kaushal",
                  ),
                ),
              );
            },
            child: const Text("Navigate"),
          )
        ],
      ),
    );
  }
}

class ProfileProv extends ChangeNotifier {
  final String userCode;
  void Function(ProfileProv) refCallback;
  void Function(ProfileProv) onDispose;
  ProfileProv({
    required this.userCode,
    required this.refCallback,
    required this.onDispose,
  }) {
    refCallback.call(this);
  }

  int _count = 0;

  int get count => _count;

  set count(int value) {
    _count = value;
    notifyListeners();
  }

  void getInstance() {
    refCallback.call(this);
  }

  @override
  void dispose() {
    onDispose.call(this);
    super.dispose();
  }
}

class ProfileListProv extends ChangeNotifier {
  final Map<String, ProfileProv> _userList = {};

  void addProfile(ProfileProv prof) {
    print("Inside add");
    _userList[prof.userCode] = prof;
  }

  bool removeProfile(ProfileProv prof) {
    return _userList.remove(prof.userCode) != null;
  }

  ProfileProv getProfileProd(String userCode) {
    return _userList[userCode]!;
  }

  bool exist(String userCode) {
    print(_userList);
    print(_userList.containsKey(userCode));
    return _userList.containsKey(userCode);
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileListProv(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Profile(userCode: "vinay"),
      ),
    );
  }
}
