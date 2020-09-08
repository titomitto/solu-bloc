import 'dart:async';

import 'package:solu_bloc/helpers/connection_manager.dart';
import 'package:solu_bloc/helpers/notification_manager.dart';
import 'package:solu_bloc/tools/manager.dart';

class SyncManager extends Manager {
  static SyncManager instance;
  factory SyncManager() => instance ??= SyncManager._instance();
  SyncManager._instance();
  bool _syncing = false;
  Timer _timer;
  Future<bool> get shouldSync async => await hasSyncRecords && !syncing;
  Future<bool> get hasSyncRecords async {
    List<bool> completedSyncs = [
      /*...(await db.customerBean.findWhere(db.customerBean.synced.iss(false)))
          .map<bool>((shop) => shop.synced)
          .toList(),*/
    ];
    return completedSyncs.contains(false);
  }

  void schedulePeriodicSync() {
    _timer = Timer.periodic(
        Duration(
          seconds: 180,
        ), (Timer timer) async {
      if (await hasSyncRecords) {
        sync();
      }
    });
  }

  void cancelPeriodicSync() {
    _timer?.cancel();
  }

  bool get syncing {
    return _syncing;
  }

  set syncing(bool syncing) {
    _syncing = syncing;
    notifyChanges();
    print(syncing ? "Started syncing" : "Finished syncing");
  }

  Future sync() async {
    if (syncing) return;
    syncing = true;
    if (await hasSyncRecords && connectionManager.isConnected) {
      cancelPeriodicSync();
      await notificationManager.showRecordsSyncingNotification();
      try {
        await Future.wait<dynamic>([
          // List all the methods from managers for syncing here
          //routePlansManager.syncCustomers(),
        ]);
        if (!await hasSyncRecords) {
          await notificationManager.showRecordsSyncedNotification();
        } else {
          await notificationManager.showRecordsSyncFailedNotification(
            "Some records where not synced.",
          );
        }
        schedulePeriodicSync();
      } catch (e) {
        await notificationManager.showRecordsSyncFailedNotification(
          "Records failed to sync.",
        );
        syncing = false;
        schedulePeriodicSync();
      }
    }
    syncing = false;
  }

  @override
  void init() {
    super.init();
  }
}

var syncManager = SyncManager();
