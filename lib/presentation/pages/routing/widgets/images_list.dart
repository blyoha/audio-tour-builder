import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../theme/theme_constants.dart';
import 'resize_indicator.dart';

class ImagesList extends StatelessWidget {
  final List<String> images;

  const ImagesList({Key? key, required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.0,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        separatorBuilder: (context, index) => const Gap(4.0),
        itemBuilder: (context, index) => GestureDetector(
          child: _buildImage(context, images[index]),
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context, String uri) {
    return GestureDetector(
      onTap: () => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
        ),
        builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.9,
          snapSizes: const [0.9],
          snap: true,
          expand: false,
          builder: (context, scrollController) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              children: [
                const ResizeIndicator(),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Expanded(
                    child: Image.network(uri, fit: BoxFit.fitWidth),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: primaryTextColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Image.network(
            uri,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return SizedBox(
                width: 150,
                child: Icon(
                  Icons.access_time,
                  color: Colors.black.withOpacity(0.5),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
