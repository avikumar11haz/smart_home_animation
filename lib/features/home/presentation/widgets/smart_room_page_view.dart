import 'package:flutter/material.dart';

import '../../../../core/shared/domain/entities/smart_room.dart';
import '../../../../core/shared/presentation/widgets/room_card.dart';
import '../../../smart_room/screens/room_details_screen.dart';

class SmartRoomsPageView extends StatelessWidget {
  const SmartRoomsPageView({
    super.key,
    required this.controller,
    required this.pageNotifier,
    required this.roomSelectorNotifier,
  });

  final PageController controller;
  final ValueNotifier pageNotifier;
  final ValueNotifier roomSelectorNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: pageNotifier,
        builder: (_, page, __) {
          return ValueListenableBuilder(
            valueListenable: roomSelectorNotifier,
            builder: (_, selected, __) {
              return PageView.builder(
                controller: controller,
                clipBehavior: Clip.none,
                itemCount: SmartRoom.fakeValues.length,
                itemBuilder: (_, index) {
                  final room = SmartRoom.fakeValues[index];
                  double percent = page - index;
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: RoomCard(
                      percent: percent,
                      expand: selected != -1,
                      room: room,
                      onSwipeUp: () {},
                      onSwipeDown: () {},
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RoomDetailScreen(room: room),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }
          );
        });
  }
}
