import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:travel_app/screens/place/components/star_display.dart';
import 'package:travel_app/utils/constants/colors.dart';

class Reviews extends StatelessWidget {
  const Reviews({
    super.key,
    required this.reviews,
    required this.placeRating,
    required this.ratingCount,
  });

  final List reviews;
  final double placeRating;
  final int ratingCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 45.0, horizontal: 20.0),
      child: reviews.isEmpty
          ? const Center(
              child: Text('There is no reviews yet...'),
            )
          : SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.width * 0.37,
                      child: Column(
                        children: [
                          const Text(
                            'Overall Rating',
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          Text(
                            placeRating.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 52,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: StarDisplay(
                              rating: placeRating,
                              size: 26,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Based on $ratingCount reviews',
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: reviews.length,
                    // shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          children: [
                            ListTile(
                              leading: Container(
                                height: 58,
                                width: 58,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                        reviews[index].authorPhoto,
                                      ),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              title: Text(
                                reviews[index].authorName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                              ),
                              subtitle: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  StarDisplay(
                                    rating: reviews[index].rating,
                                    size: 20,
                                  ),
                                  Text(
                                    reviews[index].publishTime,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ReadMoreText(
                                reviews[index].text,
                                trimMode: TrimMode.Length,
                                trimLength: 200,
                                trimCollapsedText: 'See More',
                                trimExpandedText: ' Hide',
                                moreStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: MyColors.primary),
                                lessStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: MyColors.primary),
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  )
                ],
              ),
            ),
    );
  }
}
