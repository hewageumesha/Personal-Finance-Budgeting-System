import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget? tabletBody;
  final Widget? desktopBody;

  const ResponsiveLayout({
    Key? key,
    required this.mobileBody,
    this.tabletBody,
    this.desktopBody,
  }) : super(key: key);

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1000 &&
      MediaQuery.of(context).size.width >= 650;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1000;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 650) {
          return mobileBody;
        } else if (constraints.maxWidth < 1000) {
          return tabletBody ?? mobileBody;
        } else {
          return desktopBody ?? mobileBody;
        }
      },
    );
  }
}
