# CoreData save performance test

- MAIN DIRECT - use context of `NSMainQueueConcurrencyType`
- BACK DIRECT - use context of `NSPrivateQueueConcurrencyType`
- Dual - use context of `NSPrivateQueueConcurrencyType` and child context of `NSMainQueueConcurrencyType`


## Result

> Saving time of 10000 managedObjects include relationship.

> with Xcode6 + iPhone5s(iOS8)

|   | MAIN DIRECT | BACK DIRECT | Dual |
|---|---|---|---|
|1st|1.442632s|1.442632s|1.539822s + 1.428477s|
|2nd|1.459849s|1.467284s|1.274695s + 1.391884s|
|3rd|1.483292s|1.485757s|1.534019s + 1.453961s|


>2015-02-16 23:31:42.235 savetest[2743:1609920] MAIN DIRECT : Start Create Object
2015-02-16 23:31:42.991 savetest[2743:1609920] MAIN DIRECT : End Create Object
2015-02-16 23:31:42.992 savetest[2743:1609920] MAIN DIRECT : Start Save
2015-02-16 23:31:44.410 savetest[2743:1609920] MAIN DIRECT : End Save
2015-02-16 23:31:44.410 savetest[2743:1609920] MAIN DIRECT : 1.417892
2015-02-16 23:31:48.988 savetest[2743:1609957] BACK DIRECT : Start Create Object
2015-02-16 23:31:49.829 savetest[2743:1609957] BACK DIRECT : End Create Object
2015-02-16 23:31:49.830 savetest[2743:1609957] BACK DIRECT : Start Save
2015-02-16 23:31:51.273 savetest[2743:1609957] BACK DIRECT : End Save
2015-02-16 23:31:51.273 savetest[2743:1609957] BACK DIRECT : 1.442632
2015-02-16 23:31:53.944 savetest[2743:1609920] Dual : Start Create Object
2015-02-16 23:31:54.786 savetest[2743:1609920] Dual : End Create Object
2015-02-16 23:31:54.786 savetest[2743:1609920] Dual : Start Save
2015-02-16 23:31:57.755 savetest[2743:1609920] Dual : End Save
2015-02-16 23:31:57.755 savetest[2743:1609920] Dual : 1.539822 : 1.428477

>2015-02-16 23:35:16.713 savetest[2774:1611899] Dual : Start Create Object
2015-02-16 23:35:17.463 savetest[2774:1611899] Dual : End Create Object
2015-02-16 23:35:17.464 savetest[2774:1611899] Dual : Start Save
2015-02-16 23:35:20.130 savetest[2774:1611899] Dual : End Save
2015-02-16 23:35:20.131 savetest[2774:1611899] Dual : 1.274695 : 1.391884
2015-02-16 23:35:22.677 savetest[2774:1611914] BACK DIRECT : Start Create Object
2015-02-16 23:35:23.504 savetest[2774:1611914] BACK DIRECT : End Create Object
2015-02-16 23:35:23.504 savetest[2774:1611914] BACK DIRECT : Start Save
2015-02-16 23:35:24.972 savetest[2774:1611914] BACK DIRECT : End Save
2015-02-16 23:35:24.972 savetest[2774:1611914] BACK DIRECT : 1.467284
2015-02-16 23:35:26.740 savetest[2774:1611899] MAIN DIRECT : Start Create Object
2015-02-16 23:35:27.581 savetest[2774:1611899] MAIN DIRECT : End Create Object
2015-02-16 23:35:27.582 savetest[2774:1611899] MAIN DIRECT : Start Save
2015-02-16 23:35:29.042 savetest[2774:1611899] MAIN DIRECT : End Save
2015-02-16 23:35:29.042 savetest[2774:1611899] MAIN DIRECT : 1.459849

>2015-02-16 23:35:31.216 savetest[2774:1611899] Dual : Start Create Object
2015-02-16 23:35:32.049 savetest[2774:1611899] Dual : End Create Object
2015-02-16 23:35:32.050 savetest[2774:1611899] Dual : Start Save
2015-02-16 23:35:35.038 savetest[2774:1611899] Dual : End Save
2015-02-16 23:35:35.038 savetest[2774:1611899] Dual : 1.534019 : 1.453961
2015-02-16 23:35:37.848 savetest[2774:1611991] BACK DIRECT : Start Create Object
2015-02-16 23:35:38.687 savetest[2774:1611991] BACK DIRECT : End Create Object
2015-02-16 23:35:38.687 savetest[2774:1611991] BACK DIRECT : Start Save
2015-02-16 23:35:40.173 savetest[2774:1611991] BACK DIRECT : End Save
2015-02-16 23:35:40.173 savetest[2774:1611991] BACK DIRECT : 1.485757
2015-02-16 23:35:41.465 savetest[2774:1611899] MAIN DIRECT : Start Create Object
2015-02-16 23:35:42.291 savetest[2774:1611899] MAIN DIRECT : End Create Object
2015-02-16 23:35:42.292 savetest[2774:1611899] MAIN DIRECT : Start Save
2015-02-16 23:35:43.775 savetest[2774:1611899] MAIN DIRECT : End Save
2015-02-16 23:35:43.776 savetest[2774:1611899] MAIN DIRECT : 1.483292
