import 'package:breakq/configs/routes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/image_model.dart';
import 'package:breakq/data/models/photo_model.dart';

class PhotoGalleryScreenHeader extends StatefulWidget {
  const PhotoGalleryScreenHeader({
    Key key,
    this.photos,
    this.name,
  }) : super(key: key);

  final List<PhotoModel> photos;
  final String name;

  @override
  _PhotoGalleryScreenHeaderState createState() {
    return _PhotoGalleryScreenHeaderState();
  }
}

class _PhotoGalleryScreenHeaderState extends State<PhotoGalleryScreenHeader> {
  final SwiperController _controller = SwiperController();

  List<PhotoModel> _photos;

  void _openPhotoGallery(BuildContext context) {
    Navigator.pushNamed(
      context,
      Routes.locationGallery,
      arguments: <String, dynamic>{
        'photos': widget.photos,
        'name': widget.name,
      },
    );
  }

  @override
  void initState() {
    _photos = widget.photos ?? <PhotoModel>[];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Swiper(
              controller: _controller,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    _openPhotoGallery(context);
                  },
                  child: CachedNetworkImage(
                    // cacheManager: AppCacheManager.instance,
                    imageUrl: _photos[index].getImageURL(ImageSize.view),
                    imageBuilder:
                        (BuildContext context, ImageProvider imageProvider) =>
                            Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    errorWidget:
                        (BuildContext context, String url, Object error) =>
                            const Icon(Icons.error),
                  ),
                );
              },
              itemCount: _photos.length,
              pagination: const SwiperPagination(
                alignment: Alignment(0.0, 0.9),
                builder: DotSwiperPaginationBuilder(activeColor: kPrimaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
