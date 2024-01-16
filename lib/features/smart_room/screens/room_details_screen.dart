import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:smart_home_animation/core/shared/domain/entities/smart_room.dart';
import 'package:smart_home_animation/core/shared/presentation/widgets/parallax_image_card.dart';
import 'package:smart_home_animation/core/shared/presentation/widgets/sh_app_bar.dart';
import 'package:ui_common/ui_common.dart';

import '../widgets/room_details_page_view.dart';

class RoomDetailScreen extends StatelessWidget {
  const RoomDetailScreen({
    required this.room,
    super.key,
  });

  final SmartRoom room;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const ShAppBar(),
      body: RoomDetailItems(
        topPadding: context.mediaQuery.padding.top,
        room: room,
      ),
    );
  }
}

class RoomDetailItems extends StatelessWidget {
  const RoomDetailItems({
    required this.room,
    required this.topPadding,
    super.key,
    this.animation = const AlwaysStoppedAnimation<double>(1),
  });

  final double topPadding;
  final SmartRoom room;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final sigma = 10 * animation.value;
    return Material(
      type: MaterialType.transparency,
      child: Hero(
        tag: room.id,
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            ParallaxImageCard(imageUrl: room.imageUrl),
            ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaY: sigma, sigmaX: sigma),
                child: const ColoredBox(color: Colors.transparent),
              ),
            ),
            // --------------------------------------------
            // Animated output elements
            // --------------------------------------------
            // Stack(
            //   children: [
            //     VerticalRoomTitle(room: room),
            //     const CameraIconButton(),
            //     const AnimatedUpwardArrows(),
            //   ],
            // ),
            // --------------------------------------------
            // Room controls
            // --------------------------------------------
            Container(
              padding: EdgeInsets.only(top: topPadding + 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    room.name.replaceAll(' ', '\n'),
                    textAlign: TextAlign.center,
                    style: context.displaySmall.copyWith(height: .9),
                  ),
                  const Text('SETTINGS', textAlign: TextAlign.center),
                  Expanded(
                    child: RoomDetailsPageView(
                      room: room,
                      animation: animation,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
