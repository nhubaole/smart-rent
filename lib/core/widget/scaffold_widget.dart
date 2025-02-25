import 'package:flutter/material.dart';
import 'package:smart_rent/core/config/app_colors.dart';

class ScaffoldWidget extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Color? backgroundColor;
  final bool? resizeToAvoidBottomInset;
  final bool? extendBodyBehindAppBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool enabelSafeArea;
  const ScaffoldWidget({
    super.key,
    this.appBar,
    this.body,
    this.backgroundColor = AppColors.white,
    this.resizeToAvoidBottomInset = true,
    this.extendBodyBehindAppBar = false,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.enabelSafeArea = false,
  });

  @override
  Widget build(BuildContext context) {
    if (enabelSafeArea) {
      return SafeArea(
        child: _buildScaffold(),
      );
    }
    return _buildScaffold();
  }

  Scaffold _buildScaffold() {
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: appBar,
      body: body,
      backgroundColor: backgroundColor,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      extendBodyBehindAppBar: extendBodyBehindAppBar!,
    );
  }
}
