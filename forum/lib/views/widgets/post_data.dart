import 'package:flutter/material.dart';
import 'package:forum/controllers/post_controller.dart';
import 'package:forum/models/post_model.dart';
import 'package:forum/views/post_details.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PostData extends StatefulWidget {
  const PostData({
    super.key,
    required this.post,
  });

  final PostModel post;

  @override
  State<PostData> createState() => _PostDataState();
}

class _PostDataState extends State<PostData> {
  final PostController _postController = Get.put(PostController());
  bool likedPost = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.amber[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.post.user!.name!,
            style: GoogleFonts.aBeeZee(
              fontSize: 18,
            ),
          ),
          Text(
            widget.post.user!.email!,
            style: GoogleFonts.aBeeZee(
              fontSize: 10,
            ),
          ),
          SizedBox(height: 10),
          Text(
            widget.post.content!,
          ),
          Row(
            children: [
              IconButton(
                onPressed: () async {
                  await _postController.likeAndDislike(widget.post.id);
                  _postController.getAllPosts();
                },
                icon: Icon(
                  Icons.thumb_up,
                  color: widget.post.liked! ? Colors.blue : Colors.black,
                ),
              ),
              IconButton(
                onPressed: () {
                  Get.to(
                    () => PostDetails(
                      post: widget.post,
                    ),
                  );
                },
                icon: Icon(
                  Icons.message,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
