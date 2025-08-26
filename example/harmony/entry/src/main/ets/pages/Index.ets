/*
 * Copyright (c) 2024 Huawei Device Co., Ltd. All rights reserved
 * Use of this source code is governed by a MIT license that can be
 * found in the LICENSE file.
 */

import {
  AnyJSBundleProvider,
  ComponentBuilderContext,
  FileJSBundleProvider,
  MetroJSBundleProvider,
  ResourceJSBundleProvider,
  RNApp,
  RNOHErrorDialog,
  RNOHLogger,
  TraceJSBundleProviderDecorator,
  RNOHCoreContext
} from '@rnoh/react-native-openharmony';
import font from '@ohos.font';
import { createRNPackages } from '../RNPackagesFactory';
import { AIRMap, AIR_MAP_TYPE, AIRMapMarker, AIR_MAP_MARKER_TYPE, AIRMapPolyline, AIR_MAP_POLYLINE_TYPE, AIRMapPolygon,
 AIR_MAP_POLYGON_TYPE, AIRMapCircle, AIR_MAP_CIRCLE_TYPE, AIR_MAP_CALLOUT_SUBVIEW_TYPE, AIR_MAP_CALLOUT_TYPE,
 AIRMapCallout,
 AIRMapCalloutSubview,
 Geojson,
 AIR_GEOJSON_TYPE,
 AIRMapUrlTile,
 AIR_URLTILE_TYPE,
 AIRMapWMSTile,
 AIR_WMSTILE_TYPE,
 AIR_OVERLAY_TYPE,
 AIRMapOverlay,
 AIR_MAP_CLUSTER_TYPE,
 AIRMapCluster,
} from "@react-native-ohos/react-native-maps"
const arkTsComponentNames: Array<string> = [
AIR_MAP_TYPE, 
AIR_MAP_MARKER_TYPE, 
AIR_MAP_POLYLINE_TYPE, 
AIR_MAP_POLYGON_TYPE, 
AIR_MAP_CIRCLE_TYPE, 
AIR_MAP_CALLOUT_TYPE, 
AIR_GEOJSON_TYPE, 
AIR_URLTILE_TYPE, 
AIR_WMSTILE_TYPE, 
AIR_OVERLAY_TYPE,
AIR_MAP_CLUSTER_TYPE,
];

@Builder
export function buildCustomRNComponent(ctx: ComponentBuilderContext) {
  // There seems to be a problem with the placement of ArkTS components in mixed mode. Nested Stack temporarily avoided.
  Stack() {
 if (ctx.componentName === AIR_MAP_TYPE) {
   AIRMap({
     ctx: ctx.rnComponentContext,
     tag: ctx.tag,
   })
 }else if (ctx.componentName === AIR_MAP_MARKER_TYPE) {
   AIRMapMarker({
     ctx: ctx.rnComponentContext,
     tag: ctx.tag,
   })
 }else if (ctx.componentName === AIR_MAP_POLYLINE_TYPE) {
   AIRMapPolyline({
     ctx: ctx.rnComponentContext,
     tag: ctx.tag,
   })
 }else if (ctx.componentName === AIR_MAP_POLYGON_TYPE) {
   AIRMapPolygon({
     ctx: ctx.rnComponentContext,
     tag: ctx.tag,
   })
 }else if (ctx.componentName === AIR_MAP_CIRCLE_TYPE) {
   AIRMapCircle({
     ctx: ctx.rnComponentContext,
     tag: ctx.tag,
   })
 }else if (ctx.componentName === AIR_MAP_CALLOUT_TYPE) {
   AIRMapCallout({
     ctx: ctx.rnComponentContext,
     tag: ctx.tag,
   })
 }else if (ctx.componentName === AIR_MAP_CALLOUT_SUBVIEW_TYPE) {
   AIRMapCalloutSubview({
     ctx: ctx.rnComponentContext,
     tag: ctx.tag,
   })
 }else if (ctx.componentName === AIR_MAP_CALLOUT_SUBVIEW_TYPE) {
   AIRMapCalloutSubview({
     ctx: ctx.rnComponentContext,
     tag: ctx.tag,
   })
 }else if (ctx.componentName === AIR_GEOJSON_TYPE) {
   Geojson({
     ctx: ctx.rnComponentContext,
     tag: ctx.tag,
   })
 }else if (ctx.componentName === AIR_URLTILE_TYPE) {
   AIRMapUrlTile({
     ctx: ctx.rnComponentContext,
     tag: ctx.tag,
   })
 }else if (ctx.componentName === AIR_WMSTILE_TYPE) {
   AIRMapWMSTile({
     ctx: ctx.rnComponentContext,
     tag: ctx.tag,
   })
 }else if (ctx.componentName === AIR_OVERLAY_TYPE) {
   AIRMapOverlay({
     ctx: ctx.rnComponentContext,
     tag: ctx.tag,
   })
 } else if (ctx.componentName === AIR_MAP_CLUSTER_TYPE) {
    AIRMapCluster({
      ctx: ctx.rnComponentContext,
      tag: ctx.tag,
    })
  }
  }
  .position({ x: 0, y: 0 })

}

const wrappedCustomRNComponentBuilder = wrapBuilder(buildCustomRNComponent)

/**
 * If you want to use custom fonts, you need to register them here.
 * We should support react-native-asset to handle registering fonts automatically.
 */
const fonts: font.FontOptions[] = [
  {
    familyName: 'Pacifico-Regular',
    familySrc: '/assets/fonts/Pacifico-Regular.ttf'
  },
  {
    familyName: 'StintUltraCondensed-Regular',
    familySrc: '/assets/fonts/StintUltraCondensed-Regular.ttf'
  }
]

@Entry
@Component
struct Index {
  @StorageLink('RNOHCoreContext') private rnohCoreContext: RNOHCoreContext | undefined = undefined
  @State shouldShow: boolean = false
  private logger!: RNOHLogger
  bundlePath: string = 'bunlde.harmony.js'
  @State hasBundle: boolean = false

  aboutToAppear() {
    this.logger = this.rnohCoreContext!.logger.clone("Index")
    const stopTracing = this.logger.clone("aboutToAppear").startTracing()
    for (const customFont of fonts) {
      font.registerFont(customFont)
    }

    this.shouldShow = true
    stopTracing()
  }

  onBackPress(): boolean | undefined {
    // NOTE: this is required since `Ability`'s `onBackPressed` function always
    // terminates or puts the app in the background, but we want Ark to ignore it completely
    // when handled by RN
    this.rnohCoreContext!.dispatchBackPress()
    return true
  }

  build() {
    Column() {
      if (this.rnohCoreContext && this.shouldShow) {
        if (this.rnohCoreContext?.isDebugModeEnabled) {
          RNOHErrorDialog({ ctx: this.rnohCoreContext })
        }
        RNApp({
          rnInstanceConfig: {
            createRNPackages,
            enableNDKTextMeasuring: true,
            enableBackgroundExecutor: false,
            enableCAPIArchitecture: true,
            arkTsComponentNames: arkTsComponentNames,
          },
          initialProps: { "foo": "bar" } as Record<string, string>,
          appKey: "app_name",
          wrappedCustomRNComponentBuilder: wrappedCustomRNComponentBuilder,
          onSetUp: (rnInstance) => {
            rnInstance.enableFeatureFlag("ENABLE_RN_INSTANCE_CLEAN_UP")
          },
          jsBundleProvider: new TraceJSBundleProviderDecorator(
            new AnyJSBundleProvider([
              new MetroJSBundleProvider(),
              // NOTE: to load the bundle from file, place it in
              // `/data/app/el2/100/base/com.rnoh.tester/files/bundle.harmony.js`
              // on your device. The path mismatch is due to app sandboxing on HarmonyOS
              new FileJSBundleProvider('/data/storage/el2/base/files/bundle.harmony.js'),
              // new FileJSBundleProvider(context.filesDir '/' this.bundlePath),
              new ResourceJSBundleProvider(this.rnohCoreContext.uiAbilityContext.resourceManager, 'hermes_bundle.hbc'),
              new ResourceJSBundleProvider(this.rnohCoreContext.uiAbilityContext.resourceManager, 'bundle.harmony.js')
            ]),
            this.rnohCoreContext.logger),
        })
      }
      Text("1233333333122 1212323")
    }
    .height('100%')
    .width('100%')
  }
}
