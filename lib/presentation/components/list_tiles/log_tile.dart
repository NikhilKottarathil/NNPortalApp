import 'package:flutter/material.dart';
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
    return Card(
      child: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  widget.logModel.logType == LogType.workLog
                      ? Icons.work
                      : widget.logModel.logType == LogType.siteLog
                          ? Icons.maps_home_work
                          : widget.logModel.logType == LogType.vehicleLog
                              ? Icons.car_repair
                              : Icons.shopping_bag_outlined,
                  size: 42,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Check In    :  ${DateFormat('hh:mm a').format(widget.logModel.checkIn)}',style:Theme.of(context).textTheme.subtitle2),
                    Text(
                        'Check Out :  ${DateFormat('hh:mm a').format(widget.logModel.checkOut!)}',style:Theme.of(context).textTheme.subtitle2),
                  ],
                )),
              ],
            ),
            if (widget.logModel.logType != LogType.workLog) Divider(),
            if (widget.logModel.logType == LogType.vehicleLog)
              Text(widget.logModel.vehicleLogModel!.vehicleNo!,style: Theme.of(context).textTheme.bodyMedium,),

            if (widget.logModel.logType != LogType.workLog)
              Text(widget.logModel.locationName!,style: Theme.of(context).textTheme.bodyMedium,),
            if (widget.logModel.logType != LogType.workLog)
              Text(widget.logModel.clientName!,style: Theme.of(context).textTheme.bodySmall,)
          ],
        ),
      ),
    );
  }
}
