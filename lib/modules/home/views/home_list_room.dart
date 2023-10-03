import 'package:flutter/material.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeListRoomWidget extends StatelessWidget {
  const HomeListRoomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 1.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 20,
              ),
              Text(
                'Phòng nổi bật',
                style: TextStyle(
                  fontSize: 20,
                  color: secondary20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 10,
                  itemBuilder: (context, index) => Card(
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 6,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 2,
                      clipBehavior: Clip.hardEdge,
                      child: InkWell(
                        onTap: () {},
                        child: Stack(
                          children: [
                            Hero(
                              tag: 'meal.id',
                              child: FadeInImage(
                                placeholder: MemoryImage(kTransparentImage),
                                image: const NetworkImage(
                                    'https://images.unsplash.com/photo-1695425173758-37e9c23b962a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2574&q=80'),
                                fit: BoxFit.cover,
                                height: 145,
                                width: 112,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                color: Colors.transparent,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 0,
                                  horizontal: 44,
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      index.toString(),
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: secondary20,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
