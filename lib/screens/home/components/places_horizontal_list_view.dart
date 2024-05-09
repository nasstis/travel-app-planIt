import 'package:flutter/material.dart';

class PlacesHorizontalListView extends StatelessWidget {
  const PlacesHorizontalListView({
    super.key,
    required this.recentlyViewed,
  });

  final List<String> recentlyViewed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Recently viewed',
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: ListView.builder(
              itemCount: recentlyViewed.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Container(
                      height: 95,
                      width: 95,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage('assets/images/1.jpg'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    const Text('Australia'),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
