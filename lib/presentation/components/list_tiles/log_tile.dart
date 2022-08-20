import 'package:flutter/material.dart';
import 'package:nn_portal/constants/app_colors.dart';
import 'package:nn_portal/models/log_model.dart';
import 'package:intl/intl.dart';

class LogTile extends StatefulWidget {
  final LogModel logModel;

  const LogTile({Key? key, required this.logModel}) : super(key: key);

  @override
  State<LogTile> createState() => _LogTileState();
}

class _LogTileState extends State<LogTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.tertiary,
          borderRadius: BorderRadius.circular(8)),
      padding:const  EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                widget.logModel.logType == LogType.workLog
                    ? 'assets/work_log.png'
                    : widget.logModel.logType == LogType.siteLog
                        ? 'assets/site_log.png'
                        : widget.logModel.logType == LogType.vehicleLog
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
                  // Text(
                  //     widget.logModel.logType == LogType.workLog
                  //         ? 'Staff'
                  //         : widget.logModel.logType == LogType.siteLog
                  //         ? 'Staff Job'
                  //         : widget.logModel.logType == LogType.vehicleLog
                  //         ? 'Vehicle'
                  //         : 'Tool',
                  //     style: Theme.of(context).textTheme.titleMedium),
                  // const SizedBox(height: 4,),
                  Row(
                    children: [
                       Image.asset('assets/check_in.png',height: 21,width: 21,),
                      const SizedBox(width: 8,),
                      Flexible(
                        child: Text(
                            'Check In    :  ${DateFormat('hh:mm a').format(widget.logModel.checkIn)}',
                            style: Theme.of(context).textTheme.titleSmall),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4,),

                  Row(
                    children: [
                      Image.asset('assets/check_out.png',height: 21,width: 21,),
                      const SizedBox(width: 8,),
                      Flexible(
                        child: Text(
                            'Check Out :  ${(widget.logModel.checkOut!=null && widget.logModel.checkOut != '')?DateFormat('hh:mm a').format(widget.logModel.checkOut!):''}',
                            style: Theme.of(context).textTheme.titleSmall),
                      ),
                    ],
                  ),
                ],
              )),
            ],
          ),
          if (widget.logModel.logType != LogType.workLog)
            const Divider(),
          if (widget.logModel.logType == LogType.vehicleLog)
            Row(
              children: [
                Image.asset('assets/vehicle_icon.png',height: 21,width: 21,),
                const   SizedBox(width: 8,),
                Text(
                  widget.logModel.vehicleLogModel!.vehicleNo!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          if (widget.logModel.logType == LogType.toolLog)
            Row(
              children: [
                Image.asset('assets/tool_icon.png',height: 21,width: 21,),
                const   SizedBox(width: 8,),
                Text(
                  widget.logModel.toolLogModel!.toolName!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          if (widget.logModel.logType == LogType.toolLog || widget.logModel.logType == LogType.vehicleLog )
            SizedBox(height: 6,),
          if (widget.logModel.logType != LogType.workLog)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/site_icon.png',height: 21,width: 21,),
              const   SizedBox(width: 8,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.logModel.locationName!,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        widget.logModel.clientName!,
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
