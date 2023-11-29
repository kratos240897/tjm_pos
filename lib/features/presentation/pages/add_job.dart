import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../config/constants/enum/job_status.dart';
import '../../../config/constants/enum/job_type.dart';
import '../../../main.dart';
import '../../data/dto/job.dart';
import '../cubit/add_job_cubit.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_radio.dart';
import '../widgets/custom_textfield.dart';
import '../../../config/extension/enum_to_strings.dart';

AddJobCubit? _cubit;

class AddJob extends HookWidget {
  const AddJob({super.key});

  static const route = '/add_job';
  static const routeName = 'add_job_route';

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      final cubit = _cubit ??= BlocProvider.of<AddJobCubit>(context);

      final subscription = cubit.stream.listen((state) {
        if (state is AddJobSuccess) {
          context.pop(state.job);
        }
      });

      return () {
        subscription.cancel(); 
      };
    }, [_cubit]);

    final nameController = useTextEditingController();
    final weightController = useTextEditingController();
    final selectedJobType = useState(JobType.order);
    final selectedJobStatus = useState(JobStatus.notYetStarted);

    bool validate() {
      if (nameController.text.isEmpty) return false;
      if (weightController.text.isEmpty) return false;
      return true;
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: greenAccent,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsets.only(bottom: 6.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomElevatedButton(
                  icon: Icons.close,
                  onTap: () => context.pop(),
                  elevation: 4.sp,
                ),
                Text(
                  'New Job',
                  style: styles.f14Bold(),
                ),
                CustomElevatedButton(
                  icon: Icons.done,
                  onTap: () async {
                    if (validate()) {
                      final job = Job(
                          id: const Uuid().v6(),
                          name: nameController.text.trim(),
                          dueDate: DateTime.now(),
                          startDate: DateTime.now(),
                          endDate: DateTime.now(),
                          billedDate: DateTime.now(),
                          paymentReceivedDate: DateTime.now(),
                          status: selectedJobStatus.value,
                          type: selectedJobType.value,
                          weight: double.parse(weightController.text.trim()));
                      await _cubit?.addJob(job);
                    }
                  },
                  elevation: 4.sp,
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.sp),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomRadio(
                  label: 'Type',
                  choices:
                      JobType.values.map((e) => e.name.toUpperCase()).toList(),
                  onSelected: (index) {
                    selectedJobType.value = JobType.values[index];
                  },
                ),
                16.verticalSpace,
                CustomTextField(
                  label: 'Name',
                  inputType: TextInputType.name,
                  controller: nameController,
                ),
                16.verticalSpace,
                CustomTextField(
                  label: 'Weight',
                  inputType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: weightController,
                ),
                16.verticalSpace,
                CustomRadio(
                  label: 'Status',
                  choices: JobStatus.values
                      .map((e) => e.name.getFormattedValue().toUpperCase())
                      .toList(),
                  onSelected: (index) {
                    selectedJobStatus.value = JobStatus.values[index];
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
