//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"
#import <barcode_scan/BarcodeScanPlugin.h>
#import <flutter_android_pip/FlutterAndroidPipPlugin.h>
#import <flutter_webrtc/FlutterWebRTCPlugin.h>
#import <path_provider/PathProviderPlugin.h>
#import <sqflite/SqflitePlugin.h>
#import <video_player/VideoPlayerPlugin.h>

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [BarcodeScanPlugin registerWithRegistrar:[registry registrarForPlugin:@"BarcodeScanPlugin"]];
  [FlutterAndroidPipPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterAndroidPipPlugin"]];
  [FlutterWebRTCPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterWebRTCPlugin"]];
  [FLTPathProviderPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTPathProviderPlugin"]];
  [SqflitePlugin registerWithRegistrar:[registry registrarForPlugin:@"SqflitePlugin"]];
  [FLTVideoPlayerPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTVideoPlayerPlugin"]];
}

@end
