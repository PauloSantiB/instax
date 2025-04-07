import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(CupertinoIcons.add),
          ),
        appBar: AppBar(
          elevation: 0,
          foregroundColor: Colors.white,
          title: Text(
            'Create a Post !'
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
             // minLines: 10,
              maxLines: 10,
              maxLength: 500,
              decoration: InputDecoration(
                hintText: "Enter Your Post Here...",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey)
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Theme.of(context).colorScheme.primary)
              ),
            ),
            ),
        ),
         ),
      ),
    );
  }
}