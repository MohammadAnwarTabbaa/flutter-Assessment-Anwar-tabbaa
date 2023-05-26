import 'package:flutter/material.dart';

class CommentSection extends StatefulWidget {
  @override
  _CommentSectionState createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  final _commentController = TextEditingController();
  List<String> comments = [];

  @override
  void dispose() {
    _commentController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
        controller: _commentController,
          decoration: const InputDecoration(
            hintText: 'Enter your comment',
          ),
        ),
        ElevatedButton(
          // not working for no reason ! 
          onPressed: _commentController.text.trim().isEmpty
              ? null
              : () {
                  setState(() {
                    comments.add(_commentController.text);
                    _commentController.clear();
                  });
                },
          child:const  Text('Submit'),
        ),
        SizedBox(height: 16),
        const Text(
          'Comments:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: comments.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(comments[index]),
            );
          },
        ),
      ],
    );
  }
}
