

import 'package:flutter/material.dart';
import 'package:uis_task/core/theming/colors.dart';

import '../../features/map/data/models/directions_model.dart';



class DistanceAndTime extends StatelessWidget {
  final PlaceDirections? placeDirections;
  final bool isDistanceAndTimeVisible;

  const DistanceAndTime(
      {Key? key, this.placeDirections, required this.isDistanceAndTimeVisible})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isDistanceAndTimeVisible,
      child: Positioned(
        top: 0,
        bottom: 550,
        left: 0,
        right: 0,
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                margin: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                color: Colors.white,
                child: ListTile(
                  dense: true,
                  horizontalTitleGap: 0.0,
                  leading: const Icon(
                    Icons.access_time_filled,
                    color: AppColors.mainBlue,
                    size: 30,
                  ),
                  title: Text(
                    placeDirections!.totalDuration,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 0,
            ),
            Flexible(
              flex: 1,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                margin: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                color: Colors.white,
                child: ListTile(
                  dense: true,
                  horizontalTitleGap: 0.0,
                  leading: const Icon(
                    Icons.directions_car_filled,
                    color: AppColors.mainBlue,
                    size: 30,
                  ),
                  title: Text(
                    placeDirections!.totalDistance,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}