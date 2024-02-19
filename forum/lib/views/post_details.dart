import 'package:flutter/material.dart';
import 'package:forum/controllers/post_controller.dart';
import 'package:forum/models/post_model.dart';
import 'package:forum/views/widgets/input_widget.dart';
import 'package:forum/views/widgets/post_data.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PostDetails extends StatefulWidget {
  const PostDetails({super.key, required this.post});
  final PostModel post;

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  final TextEditingController _commentContriller = TextEditingController();
  final PostController _postController = Get.put(PostController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _postController.getComments(widget.post.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.post.user!.name!,
          style: GoogleFonts.podkova(
            fontSize: 28,
            color: Colors.amber,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              PostData(post: widget.post),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 300,
                child: Obx(() {
                  return _postController.isLoading.value
                      ? Center(
                          child: CircularProgressIndicator(
                              color: Colors.blueAccent),
                        )
                      : ListView.builder(
                          itemCount: _postController.comments.value.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                _postController
                                    .comments.value[index].user!.name!,
                              ),
                              subtitle: Text(
                                _postController.comments.value[index].body!,
                              ),
                            );
                          });
                }),
              ),
              InputWidget(
                  hintText: 'Write a comment ...',
                  controller: _commentContriller,
                  obscureText: false),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 10,
                    )),
                onPressed: () async {
                  await _postController.createComment(
                    widget.post.id,
                    _commentContriller.text.trim(),
                  );
                  _commentContriller.clear();
                  _postController.getComments(widget.post.id);
                },
                child: Text('Comment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
