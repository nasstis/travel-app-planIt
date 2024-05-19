import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/screens/user/components/background_shapes.dart';
import 'package:travel_app/utils/constants/colors.dart';
import 'package:travel_app/utils/constants/rank.dart';
import 'package:user_repository/user_repository.dart';

class UserProfileTop extends StatelessWidget {
  const UserProfileTop({super.key, required this.user});

  final MyUser user;

  @override
  Widget build(BuildContext context) {
    return BackgroundShapes(
      child: Column(children: [
        const SizedBox(height: 50),
        Stack(
          alignment: Alignment.centerRight,
          children: [
            Container(
              height: 50,
            ),
            Positioned(
              right: 10,
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(25),
                child: Container(
                  height: 30,
                  width: MediaQuery.of(context).size.width * 0.42,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 231, 231, 231),
                        Colors.white,
                      ],
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        Rank.rankNames[user.rank],
                        style: const TextStyle(
                          color: MyColors.darkGrey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 4,
              right: 1,
              child: Image.asset(
                Rank.ranks[user.rank],
                height: 45,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
            ),
            Positioned(
              top: 20,
              child: Container(
                height: MediaQuery.of(context).size.width * 0.28,
                width: MediaQuery.of(context).size.width * 0.28,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(user.photo),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              top: -3,
              child: Container(
                height: MediaQuery.of(context).size.width * 0.39,
                width: MediaQuery.of(context).size.width * 0.39,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(
                    Rank.frames[user.rank],
                  ),
                  fit: BoxFit.cover,
                )),
              ),
            ),
            Positioned(
              top: 150,
              child: Column(
                children: [
                  Text(
                    user.name,
                    style: const TextStyle(
                      color: MyColors.light,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    user.email,
                    style: const TextStyle(
                      color: MyColors.light,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 50),
      ]),
    );
  }
}
