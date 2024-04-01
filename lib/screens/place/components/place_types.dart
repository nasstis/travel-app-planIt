import 'package:flutter/material.dart';

class PlaceTypesElement extends StatelessWidget {
  const PlaceTypesElement({
    super.key,
    required this.seeAllTypesRequired,
    required this.types,
    required this.seeAll,
  });

  final bool seeAllTypesRequired;
  final List types;
  final void Function() seeAll;

  @override
  Widget build(BuildContext context) {
    return Wrap(children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          types.length > 2 ? 2 : types.length,
          (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Chip(
                label: Text(types[index]),
              ),
            );
          },
        ),
      ),
      if (seeAllTypesRequired)
        Wrap(
          children: List.generate(
            types.length - 2,
            (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Chip(
                  label: Text(types[index + 2]),
                ),
              );
            },
          ),
        ),
      if (types.length > 2)
        TextButton(
          onPressed: seeAll,
          child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Icon(seeAllTypesRequired
                ? Icons.arrow_drop_up
                : Icons.arrow_drop_down),
            const SizedBox(width: 2),
            Text(
              seeAllTypesRequired ? 'Hide' : 'See all',
            ),
          ]),
        ),
    ]);
  }
}
