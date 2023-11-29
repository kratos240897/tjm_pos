import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/di/injection_container.dart';
import '../../features/presentation/pages/add_job.dart';
import '../../features/presentation/cubit/add_job_cubit.dart';
import '../../features/presentation/pages/home.dart';
import '../../features/presentation/cubit/home_cubit.dart';

final router = GoRouter(initialLocation: Home.route, routes: [
  GoRoute(
    path: Home.route,
    name: Home.routeName,
    pageBuilder: (context, state) => MaterialPage(
        child: BlocProvider<HomeCubit>(
      create: (context) => sl<HomeCubit>(),
      child: const Home(),
    )),
  ),
  GoRoute(
    path: AddJob.route,
    name: AddJob.routeName,
    pageBuilder: (context, state) => MaterialPage(
        child: BlocProvider.value(
      value: sl<AddJobCubit>(),
      child: const AddJob(),
    )),
  )
]);
