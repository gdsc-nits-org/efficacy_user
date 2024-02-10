import 'package:cached_network_image/cached_network_image.dart';
import 'package:efficacy_user/config/config.dart';
import 'package:efficacy_user/utils/local_database/local_database.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter/cupertino.dart';

class CustomNetworkImage extends StatelessWidget {
  final String url;
  const CustomNetworkImage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      errorWidget: (BuildContext context, _, __) {
        return Image.asset(Assets.mediaImgPath);
      },
      cacheManager: CacheManager(
        Config(
          url,
          stalePeriod: LocalDatabase.stalePeriod,
        ),
      ),
    );
  }
}
