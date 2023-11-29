import 'package:evolvex_lib/evolvex_lib.dart';
import 'package:flutter/material.dart';
import 'package:tjm_pos/features/data/source/job_local_data_source.dart';

import 'core/app/my_app.dart';
import 'core/di/injection_container.dart';

const orangeAccent = Color(0xfffef0f2);
const orange = Color(0xffff6801);
const greenAccent = Color(0xffc1eacd);
const green = Color(0xff3e6a4d);
final yellowAccent = Colors.amber.shade100;
final purpleAccent = Colors.purpleAccent.withOpacity(0.1);
const purple = Colors.purple;

final styles = Styles.textStyles;

void main() async {
  EvolveX.init();
  await initializeDependencies();
  await sl<JobLocalDataSource>().initDB();
  runApp(const MyApp());
}
