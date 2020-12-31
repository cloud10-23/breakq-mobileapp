import 'package:flutter/material.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:breakq/widgets/bold_title.dart';
import 'package:breakq/screens/listing/widgets/product_list_item.dart';
import 'package:breakq/widgets/shimmer_box.dart';

/// Carousel style widget for vertical listing of locations.
class LocationsCarousel extends StatefulWidget {
  const LocationsCarousel({
    Key key,
    this.title,
    this.locations,
    this.onNavigate,
  }) : super(key: key);

  final String title;
  final List<ProductModel> locations;
  final VoidCallback onNavigate;

  @override
  _LocationsCarouselState createState() => _LocationsCarouselState();
}

class _LocationsCarouselState extends State<LocationsCarousel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 342,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          BoldTitle(
            title: widget.title,
            onNavigate: widget.onNavigate,
          ),
          Container(
            height: 250,
            child: widget.locations != null
                ? ListView(
                    padding: const EdgeInsets.only(left: kPaddingM),
                    scrollDirection: Axis.horizontal,
                    children: widget.locations.map((ProductModel location) {
                      return Container(
                        width: 340,
                        padding: const EdgeInsets.only(right: kPaddingS),
                        margin:
                            const EdgeInsets.only(bottom: 1), // For card shadow
                        child: ProductListItem(
                          product: location,
                          viewType: ProductListItemViewType.map,
                          showDistance: false,
                        ),
                      );
                    }).toList(),
                  )
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: kPaddingM),
                    itemBuilder: (BuildContext context, int index) =>
                        const ShimmerBox(width: 340, height: 244),
                    itemCount:
                        List<int>.generate(2, (int index) => index).length,
                  ),
          ),
        ],
      ),
    );
  }
}
