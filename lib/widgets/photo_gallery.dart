import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/image_model.dart';
import 'package:breakq/data/models/photo_model.dart';

class PhotoGalleryScreen extends StatefulWidget {
  const PhotoGalleryScreen({Key key, this.params}) : super(key: key);

  final Map<String, dynamic> params;

  @override
  _PhotoGalleryScreenState createState() {
    return _PhotoGalleryScreenState();
  }
}

class _PhotoGalleryScreenState extends State<PhotoGalleryScreen> {
  final SwiperController _controller = SwiperController();
  final ScrollController _listController = ScrollController();

  List<PhotoModel> _photos;
  String _partnerName;

  int _index = 0;

  @override
  void initState() {
    _photos = widget.params['photos'] as List<PhotoModel> ?? <PhotoModel>[];
    _partnerName = widget.params['name'] as String ?? '';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: kBlack,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0, systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Swiper(
                controller: _controller,
                onIndexChanged: (int index) {
                  setState(() {
                    _index = index;
                  });
                },
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {},
                    child: CachedNetworkImage(
                      // cacheManager: AppCacheManager.instance,
                      imageUrl: _photos[index].getImageURL(ImageSize.view),
                      imageBuilder:
                          (BuildContext context, ImageProvider imageProvider) =>
                              Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.contain,
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
                  builder:
                      DotSwiperPaginationBuilder(activeColor: kPrimaryColor),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(kPaddingM),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    _partnerName,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(color: kWhite),
                  ),
                  Text(
                    '${_index + 1}/${_photos.length}',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(color: kWhite),
                  )
                ],
              ),
            ),
            Container(
              height: 70,
              margin: const EdgeInsets.only(bottom: kPaddingM),
              child: ListView.builder(
                controller: _listController,
                padding: const EdgeInsets.only(right: kPaddingM),
                scrollDirection: Axis.horizontal,
                itemCount: _photos.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => _controller.move(index),
                    child: Container(
                      width: 70,
                      margin: const EdgeInsets.only(left: kPaddingM),
                      child: CachedNetworkImage(
                        // cacheManager: AppCacheManager.instance,
                        imageUrl: _photos[index].getImageURL(ImageSize.view),
                        imageBuilder: (BuildContext context,
                                ImageProvider imageProvider) =>
                            Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: index == _index
                                  ? Theme.of(context).colorScheme.secondary
                                  : Theme.of(context).dividerColor,
                              width: 2,
                            ),
                            borderRadius: const BorderRadius.all(
                                Radius.circular(kBoxDecorationRadius)),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (BuildContext context, String url) =>
                            const CircularProgressIndicator(),
                        errorWidget:
                            (BuildContext context, String url, Object error) =>
                                const Icon(Icons.error),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
