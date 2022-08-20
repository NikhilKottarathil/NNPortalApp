import 'package:flutter/material.dart';
import 'package:nn_portal/constants/app_colors.dart';
import 'package:nn_portal/models/in_hand_model.dart';
import 'package:intl/intl.dart';

class InHandTile extends StatelessWidget {
  final InHandModel inHandModel;

  const InHandTile({Key? key, required this.inHandModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.tertiary, borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                inHandModel.type == Type.work
                    ? 'assets/work_log.png'
                    : inHandModel.type == Type.site
                        ? 'assets/site_log.png'
                        : inHandModel.type == Type.vehicle
                            ? 'assets/vehicle_log.png'
                            : 'assets/tool_log.png',
                height: 62,
                width: 62,
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (inHandModel.type == Type.vehicle)
                      Text(
                        inHandModel.vehicleNo!,
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                      ),
                    if (inHandModel.type == Type.tool)
                      Text(
                        inHandModel.toolName!,
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                      ),
                   const  SizedBox(height: 8,),
                    Row(
                      children: [
                        Image.asset(
                          'assets/check_in.png',
                          height: 21,
                          width: 21,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Flexible(
                          child: Text(
                              'Check In   :  ${DateFormat('hh:mm a').format(inHandModel.checkInTime!)}',
                              style: Theme.of(context).textTheme.titleSmall),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (inHandModel.type != Type.work) const Divider(),
          const SizedBox(
            height: 6,
          ),
          if (inHandModel.type != Type.work)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/site_icon.png',
                  height: 21,
                  width: 21,
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        inHandModel.locationName!,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        inHandModel.clientName!,
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
