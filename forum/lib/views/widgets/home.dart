import 'package:flutter/material.dart';
import 'package:forum/controllers/post_controller.dart';
import 'package:forum/views/widgets/post_data.dart';
import 'package:forum/views/widgets/post_filed.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PostController _postController = Get.put(PostController());
  final TextEditingController _textController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Forum',
          style: GoogleFonts.podkova(
            fontSize: 28,
            color: Colors.amber,
          ),
        ),
        backgroundColor: Colors.blueGrey,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              PostField(
                hintText: 'What do you to ask?',
                controller: _textController,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 10,
                  ),
                ),
                onPressed: () async {
                  await _postController.createPost(
                      content: _textController.text.trim());
                  _textController.clear();
                  _postController.getAllPosts();
                },
                child: Text('Post'),
              ),
              SizedBox(height: 30),
              Obx(() {
                return _postController.isLoading.value
                    ? CircularProgressIndicator(
                        color: Colors.green,
                      )
                    : Text('Posts');
              }),
              SizedBox(height: 20),
              Obx(() {
                return _postController.isLoading.value
                    ? Center(
                        child: CircularProgressIndicator(color: Colors.red),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _postController.posts.value.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: PostData(
                              post: _postController.posts.value[index],
                            ),
                          );
                        },
                      );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
