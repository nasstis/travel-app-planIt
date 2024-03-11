import 'package:flutter/material.dart';
import 'package:travel_app/screens/place/components/full_screen_image.dart';

class Gallery extends StatelessWidget {
  const Gallery({super.key, required this.images});

  final List<dynamic> images;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 45.0, horizontal: 10.0),
      child: GridView.builder(
        itemCount: images.length,
        padding: EdgeInsets.zero,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return FullScreenImage(
                images: images,
                initialIndex: index,
              );
            }));
          },
          child: Hero(
            tag: images[index],
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        image: NetworkImage(
                          images[index],
                        ),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
