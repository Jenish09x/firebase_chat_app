import 'dart:async';
import 'dart:io';

import 'package:firebase_chat_app/components/alert_message.dart';
import 'package:firebase_chat_app/components/loading_indicator.dart';
import 'package:firebase_chat_app/data/prefrences/prefrences.dart';
import 'package:firebase_chat_app/resources/resources.dart';
import 'package:firebase_chat_app/routes/routes_management.dart';
import 'package:firebase_chat_app/ui/auth/sign_in/sign_in.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:network/network.dart';
import 'package:permission_handler/permission_handler.dart';

part 'base/base_provider.dart';
part 'extensions/build_context_ext.dart';
part 'extensions/color_ext.dart';
part 'extensions/double_ext.dart';
part 'extensions/int_ext.dart';
part 'extensions/list_ext.dart';
part 'extensions/string_ext.dart';
part 'helper/alerts_helper.dart';
part 'helper/loading_handler.dart';
part 'helper/notification_helper.dart';
part 'helper/subscription_helper.dart';
