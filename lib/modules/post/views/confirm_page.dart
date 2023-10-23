import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_rent/core/values/app_colors.dart';

class ConfirmPage extends StatefulWidget {
  const ConfirmPage({super.key});

  @override
  State<ConfirmPage> createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: ListView(children: [
              Text(
                'Xác nhận',
                style: TextStyle(
                    color: primary40,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 20,
              ),
              //---------------------Title-------------------------
              Text(
                'TIÊU ĐỀ BÀI ĐĂNG',
                style: TextStyle(
                    color: secondary40,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                maxLength: 5,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Nhập tiêu đề bài đăng',
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primary40, width: 2)),
                ),
              ),
              SizedBox(
                height: 16,
              ),

              //---------------------Title-------------------------
              Text(
                'MÔ TẢ',
                style: TextStyle(
                    color: secondary40,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Môi trường sống sạch, khu phố an ninh,...',
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primary40, width: 2)),
                ),
              ),
              SizedBox(
                height: 16,
              ),
            ])));
  }
}