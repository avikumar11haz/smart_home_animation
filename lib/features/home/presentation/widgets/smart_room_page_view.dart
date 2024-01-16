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

  double _getoffsetX(double percent) => percent.isNegative ? 30 : -30;
  Matrix4 _getOutTranslate(
      {required double percent,
      required int selectedRoom,
      required int index}) {
    final double x =
        selectedRoom != index && selectedRoom != -1 ? _getoffsetX(percent) : 0;
    return Matrix4.translationValues(x, 0, 0);
  }

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
                      transform: _getOutTranslate(
                        percent: percent,
                        selectedRoom: selected,
                        index: index,
                      ),
                      child: RoomCard(
                        percent: percent,
                        expand: selected == index,
                        room: room,
                        onSwipeUp: () => roomSelectorNotifier.value = index,
                        onSwipeDown: () => roomSelectorNotifier.value = -1,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  RoomDetailScreen(room: room),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              });
        });
  }
}
