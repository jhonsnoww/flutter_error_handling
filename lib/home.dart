import 'package:demo_error_handling/post_change_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo Error Handling'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Consumer<PostChangeNotifier>(
            builder: (_, notifier, w) {
              if (notifier.state == NotifierState.initial) {
                return Text("Press button!");
              } else if (notifier.state == NotifierState.loading) {
                return CircularProgressIndicator();
              } else {
                return notifier.post
                    .fold((l) => Text(l.message), (r) => Text(r.body));
                // if (notifier.failure != null) {
                //   final error = notifier.failure.toString();
                //   print("Error ::: $error");
                //   return Text(error);
                // } else {
                //   return Text(notifier.post.body);
                // }
              }
            },
          ),
          ElevatedButton(
              onPressed: () {
                Provider.of<PostChangeNotifier>(context, listen: false)
                    .getOnePost();
              },
              child: Text("get Post"))
        ],
      )),
    );
  }
}
