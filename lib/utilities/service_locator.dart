import 'package:get_it/get_it.dart';

import 'call_services.dart';




GetIt locator = GetIt.asNewInstance();

void setupLocator() {
  locator.registerSingleton(CallsAndMessagesService());
}