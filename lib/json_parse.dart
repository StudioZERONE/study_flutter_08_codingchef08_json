import 'package:flutter/material.dart';
import 'user.dart';
import 'services.dart';

class JsonParse extends StatefulWidget {
  const JsonParse({super.key});

  @override
  State<JsonParse> createState() => _JsonParseState();
}

class _JsonParseState extends State<JsonParse> {
  List<User> _user = <User>[];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    Services.getInfo().then((value) {
      setState(() {
        _user = value;
        loading = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(loading ? 'User' : 'loading...'),
      ),
      body: ListView.builder(
          itemCount: _user.length,
          itemBuilder: (context, index) {
            User user = _user[index];
            return ListTile(
              leading: const Icon(
                Icons.account_circle_rounded,
                color: Colors.blue,
              ),
              trailing: IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(user.name),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(user.phone),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Close'),
                              ),
                            ],
                          ),
                        );
                      });
                },
                icon: const Icon(
                  Icons.phone_android_rounded,
                  color: Colors.red,
                ),
              ),
              title: Text(user.name),
              subtitle: Text(user.email),
            );
          }),
    );
  }
}
