//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<permission_handler_apple/PermissionHandlerPlugin.h>)
#import <permission_handler_apple/PermissionHandlerPlugin.h>
#else
@import permission_handler_apple;
#endif

#if __has_include(<torch_controller/TorchControllerPlugin.h>)
#import <torch_controller/TorchControllerPlugin.h>
#else
@import torch_controller;
#endif

#if __has_include(<torch_light/TorchLightPlugin.h>)
#import <torch_light/TorchLightPlugin.h>
#else
@import torch_light;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [PermissionHandlerPlugin registerWithRegistrar:[registry registrarForPlugin:@"PermissionHandlerPlugin"]];
  [TorchControllerPlugin registerWithRegistrar:[registry registrarForPlugin:@"TorchControllerPlugin"]];
  [TorchLightPlugin registerWithRegistrar:[registry registrarForPlugin:@"TorchLightPlugin"]];
}

@end
