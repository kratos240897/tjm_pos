import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tjm_pos/config/constants/app/app_images.dart';
import 'package:tjm_pos/config/constants/enum/job_status.dart';
import 'package:tjm_pos/core/utils/utils.dart';
import 'package:badges/badges.dart' as badges;

import '../../../main.dart';
import '../../data/dto/job.dart';
import '../cubit/home_cubit.dart';
import '../widgets/custom_button.dart';
import '../../../config/extension/color_extension.dart';
import '../../../config/extension/enum_to_strings.dart';

import '../widgets/custom_circular_button.dart';
import '../widgets/custom_timeline.dart';
import 'add_job.dart';

HomeCubit? _cubit;

final _options = [
  'All',
  'Not Yet Started',
  'At Work',
  'At Testing',
  'Delivered',
  'Yet to be Delivered',
  'Billed',
  'Yet to be Billed',
  'Recieved',
  'Yet to be Recieved',
];

class Home extends HookWidget {
  const Home({super.key});

  static const route = '/home';
  static const routeName = 'home_route';

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      Future.microtask(() async {
        _cubit ??= BlocProvider.of<HomeCubit>(context);
        await _cubit?.getAllJobs();
      });
      return null;
    }, []);
    return const Scaffold(
      body: Stack(
        children: [BackgroundLayer(), ForegroundLayer()],
      ),
    );
  }
}

class BackgroundLayer extends StatelessWidget {
  const BackgroundLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(color: greenAccent),
        )),
        Expanded(child: Container())
      ],
    );
  }
}

class ForegroundLayer extends StatelessWidget {
  const ForegroundLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.sp),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [TopSection(), BottomSection()],
        ),
      ),
    );
  }
}

class BottomSection extends HookWidget {
  const BottomSection({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController(
      initialPage: 0,
    );
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activity',
          style: styles.f14Bold(),
        ),
        12.verticalSpace,
        RecentActivityGroupHeader(
          options: _options,
          onSelected: (index) {
            pageController.animateToPage(index,
                duration: const Duration(milliseconds: 200),
                curve: Curves.linear);
          },
        ),
        12.verticalSpace,
        RecentActivityTabViews(pageController: pageController)
      ],
    ));
  }
}

class RecentActivityTabViews extends HookWidget {
  const RecentActivityTabViews({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    final pageList = useState(<List<Job>>[]);

    useEffect(() {
      Future.microtask(() {
        _cubit?.stream.listen((state) {
          if (state is HomeLoadedState) {
            List<List<Job>> updatedPageList = [];
            updatedPageList.add(state.jobs);
            for (JobStatus status in JobStatus.values) {
              updatedPageList.add(
                state.jobs.where((job) => job.status == status).toList(),
              );
            }
            pageList.value = updatedPageList;
          }
        });
      });

      return null;
    });
    return Expanded(
      child: PageView.builder(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          itemCount: pageList.value.length,
          itemBuilder: (_, pageIndex) {
            final jobs =
                pageList.value.isNotEmpty ? pageList.value[pageIndex] : [];
            return jobs.isNotEmpty
                ? RecentActivityList(jobs: jobs)
                : const InfoWidget(info: 'No Activity found');
          }),
    );
  }
}

class RecentActivityList extends StatelessWidget {
  const RecentActivityList({
    super.key,
    required this.jobs,
  });

  final List jobs;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        final job = jobs[index];
        return RecentActivityItem(
            job: job, onDismissed: () => _cubit?.removeJob(job));
      },
    );
  }
}

class InfoWidget extends StatelessWidget {
  const InfoWidget({
    super.key,
    required this.info,
  });
  final String info;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          FontAwesomeIcons.boxesPacking,
          color: orange,
          size: 26.sp,
        ),
        8.verticalSpace,
        Text(info, style: styles.f14SemiBold(color: orange)),
      ],
    );
  }
}

class RecentActivityItem extends HookWidget {
  const RecentActivityItem({
    super.key,
    required this.job,
    required this.onDismissed,
  });
  final Job job;
  final GestureTapCallback onDismissed;

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(false);
    final (bgColor, textColor) = job.status.color;
    return Slidable(
      key: ValueKey(job.id),
      endActionPane: ActionPane(
          motion: const DrawerMotion(),
          dismissible: DismissiblePane(onDismissed: onDismissed),
          children: [
            CustomSlidableAction(
              backgroundColor: greenAccent,
              foregroundColor: green,
              icon: Icons.edit,
              label: 'Edit',
              margin: EdgeInsets.only(left: 6.w, bottom: 8.h),
              onPressed: () {},
            ),
            CustomSlidableAction(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
              margin: EdgeInsets.only(left: 6.w, bottom: 8.h),
              onPressed: onDismissed,
            ),
          ]),
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.all(10.sp),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: Colors.grey.shade200),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24.1.r,
                  backgroundColor: Colors.black,
                  child: CircleAvatar(
                    radius: 24.r,
                    backgroundImage: const NetworkImage(
                        'https://i.pinimg.com/474x/c9/b2/56/c9b25648b56a4fc34eca507e47c20c72.jpg'),
                  ),
                ),
                12.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ItemInfoLabel(
                              backgroundColor: bgColor,
                              label: job.status.name.getFormattedValue(),
                              textColor: textColor),
                          4.horizontalSpace,
                          ItemInfoLabel(
                              backgroundColor: purpleAccent,
                              label: job.type.name.toUpperCase(),
                              textColor: purple),
                          4.horizontalSpace,
                          GestureDetector(
                            onTap: () => isExpanded.value = !isExpanded.value,
                            child: Icon(
                              isExpanded.value
                                  ? Icons.expand_less
                                  : Icons.expand_more,
                              size: 22.sp,
                              color: orange,
                            ),
                          )
                        ],
                      ),
                      4.verticalSpace,
                      listTileInfo('Name :', job.name.toUpperCase()),
                      4.verticalSpace,
                      listTileInfo('Weight :', '${job.weight} gm'),
                      4.verticalSpace,
                      listTileInfo(
                          'Due Date :', Utils.getFormattedDate(job.dueDate)),
                    ],
                  ),
                ),
              ],
            ),
            12.verticalSpace,
            JobStatusInfoGraphic(
              isExpanded: isExpanded.value,
            )
          ],
        ),
      ),
    );
  }

  Row listTileInfo(String label, String value) {
    return Row(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.topRight,
            child: Text(
              label,
              style: styles.f12Bold(color: Colors.grey.shade700),
            ),
          ),
        ),
        8.horizontalSpace,
        Expanded(
          flex: 2,
          child: Text(
            value,
            style: styles.f12Bold(),
          ),
        ),
      ],
    );
  }
}

class JobStatusInfoGraphic extends StatelessWidget {
  const JobStatusInfoGraphic({
    super.key,
    required this.isExpanded,
  });
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    final Map<String, Widget> data = {
      'Started': AppImages.notStartedIcon(color: orange),
      'At Work': AppImages.atWorkIcon(color: orange),
      'At Testing': AppImages.atTestingIcon(color: orange),
      'Delivered': AppImages.deliveredIcon(color: orange),
      'Received': AppImages.receivedIcon(color: orange)
    };
    final items = data.entries.toList();
    return AnimatedSwitcher(
      switchInCurve: Curves.easeInCubic,
      switchOutCurve: Curves.easeOutCubic,
      duration: const Duration(milliseconds: 300),
      child: isExpanded
          ? CustomTimeline(
              indicatorSize: 30.sp,
              gutterSpacing: 12.w,
              lineColor: orange,
              lineGap: 4.sp,
              itemGap: 16.sp,
              indicators: List.generate(items.length, (index) {
                final widget = items.elementAt(index).value;
                return _infoItem(widget);
              }).toList(),
              children: List.generate(items.length, (index) {
                final status = items.elementAt(index).key;
                return Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                      border: Border.all(color: orange, width: 0.5.sp),
                      borderRadius: BorderRadius.circular(12.r),
                      color: Colors.white70),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            status,
                            style: styles.f12Bold(color: Colors.black),
                          ),
                          4.horizontalSpace,
                          CircleAvatar(
                            radius: 7.r,
                            backgroundColor: Colors.green,
                            child: Icon(
                              Icons.done,
                              color: Colors.white,
                              size: 10.sp,
                            ),
                          ),
                        ],
                      ),
                      8.verticalSpace,
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.clock,
                            color: Colors.black,
                            size: 16.sp,
                          ),
                          8.horizontalSpace,
                          Text(
                            '7 Nov 2023 at 06:45 PM',
                            style: styles.f12Regular(color: Colors.black),
                          )
                        ],
                      )
                    ],
                  ),
                );
              }).toList(),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(items.length * 2 - 1, (index) {
                if (index.isEven) {
                  final itemIndex = index ~/ 2;
                  return badges.Badge(
                      position:
                          badges.BadgePosition.custom(top: -5.0, end: -5.0),
                      badgeStyle:
                          const badges.BadgeStyle(badgeColor: Colors.green),
                      badgeContent: Icon(
                        Icons.done,
                        color: Colors.white,
                        size: 8.sp,
                      ),
                      child: _infoItem(items[itemIndex].value));
                } else {
                  return Expanded(
                    child: Container(
                      height: 0.3.h,
                      color: orange,
                    ), // Empty container to act as the divider
                  );
                }
              }),
            ),
    );
  }

  Widget _infoItem(Widget child) {
    return CustomCircularButton(
      backgroundColor: orangeAccent,
      borderColor: orange,
      child: child,
    );
  }
}

class CustomSlidableAction extends StatelessWidget {
  const CustomSlidableAction({
    super.key,
    required this.onPressed,
    required this.margin,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.icon,
    required this.label,
  });
  final GestureTapCallback onPressed;
  final EdgeInsets margin;
  final Color backgroundColor;
  final Color foregroundColor;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          margin: margin,
          decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(12.r)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20.sp,
                color: foregroundColor,
              ),
              6.verticalSpace,
              Text(
                label,
                style: styles.f12SemiBold(color: foregroundColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ItemInfoLabel extends StatelessWidget {
  const ItemInfoLabel({
    super.key,
    required this.label,
    required this.backgroundColor,
    required this.textColor,
  });

  final String label;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: textColor, width: 0.2.sp),
        color: backgroundColor,
      ),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      child: Text(
        label,
        style: styles.f12Bold(color: textColor),
      ),
    );
  }
}

class RecentActivityGroupHeader extends HookWidget {
  const RecentActivityGroupHeader({
    super.key,
    required this.onSelected,
    required this.options,
  });
  final List<String> options;
  final Function(int) onSelected;

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(0);
    return SizedBox(
      height: 0.04.sh,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: options.length,
          itemBuilder: (_, index) {
            final isSelected = index == selectedIndex.value;
            return GestureDetector(
              onTap: () async {
                selectedIndex.value = index;
                onSelected(index);
              },
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(right: 8.w),
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    border: isSelected
                        ? null
                        : Border.all(color: Colors.grey.shade400),
                    color: isSelected ? Colors.black : Colors.white),
                child: Text(
                  options[index],
                  style: styles.f12Bold(
                      color: isSelected ? Colors.white : Colors.grey.shade400),
                ),
              ),
            );
          }),
    );
  }
}

class TopSection extends StatelessWidget {
  const TopSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          header(),
          12.verticalSpace,
          dashBoardInfo(constraints, context)
        ],
      );
    }));
  }

  Widget dashBoardTopSection() {
    return Expanded(
        flex: 1,
        child: Container(
          padding: EdgeInsets.all(16.sp),
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.4)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'This Month',
                    style: styles.f12SemiBold(color: Colors.grey.shade700),
                  ),
                  4.verticalSpace,
                  Text(
                    '300.150 gm',
                    style: styles.f14Bold(),
                  )
                ],
              ),
              Icon(
                Icons.bar_chart_rounded,
                color: orange,
                size: 24.sp,
              )
            ],
          ),
        ));
  }

  Row dashBoardStatus(String title, String value, IconData icon) {
    return Row(
      children: [
        CustomCircularButton(icon: icon),
        12.horizontalSpace,
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: styles.f12SemiBold(color: Colors.grey.shade700),
            ),
            4.verticalSpace,
            Text(
              value,
              style: styles.f12SemiBold(),
            )
          ],
        ),
      ],
    );
  }

  Expanded dashBoardBottomSection(BuildContext context) {
    return Expanded(
        flex: 2,
        child: Container(
          padding: EdgeInsets.all(16.sp),
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                dashBoardStatus('Waiting', '17.100 gm', Icons.pending_actions),
                dashBoardStatus('Paid', '150.080 gm', Icons.done),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    child: CustomButton(
                  label: 'New Invoice',
                  onPressed: () {},
                )),
                8.horizontalSpace,
                Expanded(
                  child: CustomButton(
                    label: 'New Job',
                    onPressed: () async {
                      final res = await context.pushNamed(AddJob.routeName);
                      if (res != null) {
                        await _cubit?.addJobToHomeList(res as Job);
                      }
                    },
                  ),
                ),
              ],
            )
          ]),
        ));
  }

  Widget dashBoardInfo(BoxConstraints constraints, BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22.r),
      child: SizedBox(
        height: constraints.maxHeight * 0.7,
        child: Column(
          children: [dashBoardTopSection(), dashBoardBottomSection(context)],
        ),
      ),
    );
  }

  Widget header() {
    return Row(
      children: [
        CircleAvatar(
          radius: 24.1.r,
          backgroundColor: Colors.black,
          child: CircleAvatar(
            radius: 24.r,
            backgroundImage: const NetworkImage(
                'https://i.pinimg.com/474x/c9/b2/56/c9b25648b56a4fc34eca507e47c20c72.jpg'),
          ),
        ),
        8.horizontalSpace,
        Column(
          children: [
            Text(
              'Surya',
              style: styles.f16Bold().copyWith(letterSpacing: 1.2),
            ),
            Text(
              'Admin',
              style: styles.f14Regular(color: Colors.grey.shade700),
            )
          ],
        ),
        const Spacer(),
        Icon(
          FontAwesomeIcons.bell,
          size: 20.sp,
        )
      ],
    );
  }
}
