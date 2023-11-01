import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smart_rent/core/values/app_colors.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: primary40,
        foregroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.favorite_outline,
                color: Colors.white,
              ))
        ],
        title: Text(
          "Chi tiết phòng",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            imageCollection(context),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Expanded(
                            child: Text(
                          "Căn hộ",
                          style: TextStyle(color: secondary40),
                        )),
                        Text('3 Nam/Nữ', style: TextStyle(color: secondary40))
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: primary98),
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: const Row(
                        children: [
                          Expanded(
                              child: Column(
                            children: [
                              Text(
                                'CÒN PHÒNG',
                                style: TextStyle(color: secondary20),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Còn',
                                style: TextStyle(
                                    color: primary40,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                          Expanded(
                              child: Column(
                            children: [
                              Text(
                                'DIỆN TÍCH',
                                style: TextStyle(color: secondary20),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                '35m2',
                                style: TextStyle(
                                    color: primary40,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                          Expanded(
                              child: Column(
                            children: [
                              Text(
                                'ĐẶT CỌC',
                                style: TextStyle(color: secondary20),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                '11tr',
                                style: TextStyle(
                                    color: primary40,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'CHDV Cao cấp chuyên nghiệp Nguyễn Văn Linh Quận 7',
                      style: TextStyle(
                          color: secondary20,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: secondary40,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Flexible(
                            child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text:
                                  "520 Nguyễn Văn Linh, Phường Bình Thuận, Quận 7, Hồ Chí Minh ",
                              style: TextStyle(color: secondary40),
                            ),
                            TextSpan(
                                text: " Chỉ đường",
                                style: TextStyle(
                                    color: primary40,
                                    fontWeight: FontWeight.bold),
                                recognizer: TapGestureRecognizer()),
                          ]),
                        ))
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    const Row(
                      children: [
                        Icon(
                          Icons.phone_outlined,
                          color: secondary40,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "Số điện thoại: 0987654321",
                          style: TextStyle(color: secondary40),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: primary60, width: 1)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: const Row(
                        children: [
                          Expanded(
                              child: Column(
                            children: [
                              Icon(
                                Icons.emoji_objects_outlined,
                                size: 24,
                                color: primary60,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                '3.8k',
                                style: TextStyle(
                                  color: primary60,
                                ),
                              ),
                            ],
                          )),
                          Expanded(
                              child: Column(
                            children: [
                              Icon(
                                Icons.water_drop_outlined,
                                size: 24,
                                color: primary60,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                '25k',
                                style: TextStyle(
                                  color: primary60,
                                ),
                              ),
                            ],
                          )),
                          Expanded(
                              child: Column(
                            children: [
                              Icon(
                                Icons.two_wheeler_outlined,
                                size: 24,
                                color: primary60,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                '120k',
                                style: TextStyle(
                                  color: primary60,
                                ),
                              ),
                            ],
                          )),
                          Expanded(
                              child: Column(
                            children: [
                              Icon(
                                Icons.wifi,
                                size: 24,
                                color: primary60,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Miễn phí',
                                style: TextStyle(
                                  color: primary60,
                                ),
                              ),
                            ],
                          )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Mô tả',
                      style: TextStyle(
                          color: secondary20,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    ExpandableText(
                      'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.',
                      expandText: 'Xem thêm',
                      collapseText: 'Rút gọn',
                      maxLines: 2,
                      linkColor: primary40,
                      linkStyle: TextStyle(fontWeight: FontWeight.bold),
                      style: TextStyle(color: secondary40),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Ngày đăng',
                      style: TextStyle(
                          color: secondary20,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    const Row(
                      children: [
                        Icon(
                          Icons.calendar_month_outlined,
                          color: secondary40,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "25/03/2023",
                          style: TextStyle(color: secondary40),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Tiện ích',
                      style: TextStyle(
                          color: secondary20,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Đánh giá',
                      style: TextStyle(
                          color: secondary20,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: primary40,
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            children: [
                              Text(
                                '4.2',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Icon(
                                Icons.star,
                                color: Color(0xFFFFD21D),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tốt',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: primary40,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                '14 đánh giá',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: secondary40,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Ink(
                          child: Text(
                            'Xem mọi bài đánh giá',
                            style: TextStyle(
                                color: primary40,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    InkWell(
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: primary98),
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 16),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 24,
                                backgroundImage: NetworkImage(
                                    "https://media.pinatafarm.com/protected/13C23573-190B-4CD5-8692-28D5AEE4DC73/5dd78ce7-d484-4c34-9f73-527d561d1d44-1665444004997-pfarm.webp"),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Lê Văn A',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: secondary20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      '9 phòng',
                                      style: TextStyle(
                                        color: primary60,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 18,
                                color: secondary20,
                              )
                            ],
                          )),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Đề xuất',
                      style: TextStyle(
                          color: secondary20,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget imageCollection(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: Stack(
          children: [
            Image.network(
              "https://www.thespruce.com/thmb/iMt63n8NGCojUETr6-T8oj-5-ns=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/PAinteriors-7-cafe9c2bd6be4823b9345e591e4f367f.jpg",
              height: MediaQuery.sizeOf(context).width + 50,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Positioned(
              child: Container(
                padding: EdgeInsets.only(top: 2),
                color: Colors.white,
                height: 90,
                width: MediaQuery.sizeOf(context).width,
                child: Row(
                  children: [
                    Expanded(
                      child: Image.network(
                          "https://www.thespruce.com/thmb/iMt63n8NGCojUETr6-T8oj-5-ns=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/PAinteriors-7-cafe9c2bd6be4823b9345e591e4f367f.jpg",
                          fit: BoxFit.cover,
                          height: 90,
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          colorBlendMode: BlendMode.multiply),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Expanded(
                      child: Image.network(
                        "https://www.thespruce.com/thmb/iMt63n8NGCojUETr6-T8oj-5-ns=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/PAinteriors-7-cafe9c2bd6be4823b9345e591e4f367f.jpg",
                        fit: BoxFit.cover,
                        height: 90,
                      ),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Expanded(
                      child: Image.network(
                        "https://www.thespruce.com/thmb/iMt63n8NGCojUETr6-T8oj-5-ns=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/PAinteriors-7-cafe9c2bd6be4823b9345e591e4f367f.jpg",
                        fit: BoxFit.cover,
                        height: 90,
                      ),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Expanded(
                      child: Image.network(
                        "https://www.thespruce.com/thmb/iMt63n8NGCojUETr6-T8oj-5-ns=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/PAinteriors-7-cafe9c2bd6be4823b9345e591e4f367f.jpg",
                        fit: BoxFit.cover,
                        height: 90,
                      ),
                    ),
                  ],
                ),
              ),
              bottom: 0,
            )
          ],
        ));
  }
}
