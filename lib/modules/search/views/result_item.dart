import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/values/app_colors.dart';

class ResultItem extends StatelessWidget {
  const ResultItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 160,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: CachedNetworkImage(
                  height: 120,
                  width: 120,
                  fit: BoxFit.fitHeight,
                  imageUrl:
                      'https://a.pinatafarm.com/1092x612/d47afa3656/coughing-cat-dcbc3e50b235f7aa3793bfa07959fb7a-meme.jpeg')),
          const SizedBox(
            width: 16,
          ),
          const Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SỐ NGƯỜI',
                  style: TextStyle(fontSize: 10, color: secondary60),
                ),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18,
                    color: secondary20,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                ),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 10, color: secondary20),
                  maxLines: 2,
                ),
                Text(
                  '2.000.000đ/phòng',
                  style: TextStyle(
                    fontSize: 18,
                    color: primary60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
