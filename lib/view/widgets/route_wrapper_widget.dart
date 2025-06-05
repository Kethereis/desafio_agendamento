import 'package:flutter/material.dart';

import '../../app_route.dart';
import '../../utils/constants.dart';

class RouteWrapper extends StatefulWidget {
  const RouteWrapper({
    super.key,
    required this.child,
    required this.showFloating,
    this.padding = const EdgeInsets.all(16),
    this.title,
  });
  final Widget child;
  final EdgeInsetsGeometry padding;
  final String? title;
  final bool showFloating;


  @override
  State<RouteWrapper> createState() => _RouteWrapperState();
}

class _RouteWrapperState extends State<RouteWrapper> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: widget.showFloating ? FloatingActionButton(
          onPressed: () {
            appRouter.go("/scheduling");
          },
          backgroundColor: ColorConstants.primaryColor,
          shape: const CircleBorder(),
          child: const Icon(Icons.add, color: Colors.white,),
        ): null,
        bottomNavigationBar: Container(
          height: 50,
          color: ColorConstants.primaryColor,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Text(
                  widget.title!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: widget.padding,
                    physics: const BouncingScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: constraints.maxHeight),
                      child: IntrinsicHeight(
                        child: widget.child,
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
