import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AddPlaceItinerary extends StatefulWidget {
  const AddPlaceItinerary({super.key, required this.places});

  final List places;

  @override
  State<AddPlaceItinerary> createState() => _AddPlaceItineraryState();
}

class _AddPlaceItineraryState extends State<AddPlaceItinerary> {
  late List<bool> selectedCheckboxes;
  @override
  void initState() {
    selectedCheckboxes = List.generate(widget.places.length, (index) => false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: selectedCheckboxes.length,
              itemBuilder: (context, index) => Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                          title: Text(
                            widget.places[index].name,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          leading: Container(
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.black,
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                    widget.places[index].photos[0]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          subtitle: widget.places[index].description != null
                              ? Text(
                                  widget.places[index].description,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 12),
                                )
                              : null,
                          isThreeLine: true,
                          visualDensity: const VisualDensity(vertical: 3),
                        ),
                      ),
                    ),
                    Checkbox(
                      value: selectedCheckboxes[index],
                      onChanged: (status) {
                        setState(() {
                          selectedCheckboxes[index] = status!;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Add places to Itinerary'),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
