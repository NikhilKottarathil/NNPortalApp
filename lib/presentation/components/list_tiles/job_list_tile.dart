import 'package:flutter/material.dart';
import 'package:nn_portal/constants/app_colors.dart';
import 'package:nn_portal/models/job_model.dart';

class JobListTile extends StatelessWidget {
  final JobModel jobModel;
  final showTrailingIcon;

  const JobListTile(
      {Key? key, required this.jobModel, this.showTrailingIcon = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      elevation: .5,
      child: ListTile(
        tileColor: AppColors.tertiary,
        leading: Image.asset(
          jobModel.code!.substring(0, 1).toLowerCase() == 'p'
              ? 'assets/project_job.png'
              : 'assets/site_job.png',
          color: Colors.black,
          height:62,
          width:62,
        ),
        title: Text(jobModel.locationName!),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(jobModel.clientName!,style: Theme.of(context).textTheme.titleSmall!.copyWith(height: 1.5),),
            if(jobModel.openOn!=null)
            Row(
              children: [
                Text('Open On       :',style:Theme.of(context).textTheme.bodySmall!.copyWith(height: 1.5),),
                Text(jobModel.openOn!.length>10?jobModel.openOn!.substring(0,10):jobModel.openOn!,style:Theme.of(context).textTheme.bodySmall!.copyWith(height: 1.5),),
              ],
            ),
            if(jobModel.assignedFor!=null)

              Row(
              children: [
                Text('Scheduled Date :',style:Theme.of(context).textTheme.bodySmall!.copyWith(height: 1.5),),
                Text(jobModel.assignedFor!.length>10?jobModel.assignedFor!.substring(0,10):jobModel.assignedFor!,style:Theme.of(context).textTheme.bodySmall!.copyWith(height: 1.5),),
              ],
            ),
          ],
        ),
        // trailing: showTrailingIcon ? const Icon(Icons.arrow_forward_ios) : null,
      ),
    );
  }
}
