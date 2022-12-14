load("@build_bazel_rules_apple//apple:ios.bzl", "ios_application")
load("@build_bazel_rules_apple//apple:versioning.bzl", "apple_bundle_version")
load("@build_bazel_rules_apple//apple:resources.bzl", "apple_resource_group")
load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")
load("@build_bazel_rules_apple//apple:apple.bzl", "local_provisioning_profile")
load("cdda_version.bzl", "CDDA_BUILD_NUMBER")

local_provisioning_profile(
    name = "app_debug_profile",
    profile_name = "match Development net.nornagon.cdda.experimental",
)

local_provisioning_profile(
    name = "app_distribution_profile",
    profile_name = "match AppStore net.nornagon.cdda.experimental 1667430063",
)

apple_bundle_version(
    name = "version",
    build_version = "1." + CDDA_BUILD_NUMBER + ".0",
    short_version_string = "1." + CDDA_BUILD_NUMBER + ".0",
)

filegroup(
    name = "common_bundle_assets",
    srcs = glob(
        ["Common/Bundle/Assets.xcassets/**"],
        exclude = ["**/.DS_Store"],
    ),
)

swift_library(
    name = "cdda_swift_common",
    srcs = [
        "Common/source/MenuButton.swift",
        "Common/source/PageUpDownPanGestureRecognizer.swift",
        "Common/source/ShowAndFixGestureRecognizer.swift",
        "Common/source/ZipArchiver.swift",
    ],
    data = [
        "Common/Bundle/Base.lproj/UIControls.storyboard",
        ":common_bundle_assets",
    ],
    generated_header_name = "CDDA-Swift.h",
    generates_header = True,
    deps = ["@zip"],
)

objc_library(
    name = "cdda_objc_common_gamepad",
    srcs = [
        "Common/source/GamePadViewController.h",
        "Common/source/DPadView.h",
        "Common/source/SDL_uikitviewcontroller+Gamepad.h",
        "Common/source/SDL_uikitviewcontroller+Gamepad.mm",
        "Common/source/game_dependent.h",
        "Common/source/game_dependent.mm",
    ],
    hdrs = [
        "Common/source/SDL_char_utils.h",
    ],
    copts = ["-std=c++14"],
    deps = [
        ":cdda_swift_common",
        "@cdda",
        "@sdl2",
    ],
)

objc_library(
    name = "cdda_objc_common",
    srcs = [
        "Common/source/AppDelegate.h",
        "Common/source/AppDelegate.m",
        "Common/source/CDDA-Bridging-Header.h",
        "Common/source/CDDA_iOS_main.h",
        "Common/source/GamePadViewController.h",
        "Common/source/GamePadViewController.m",
        "Common/source/DPadView.h",
        "Common/source/DPadView.m",
        "Common/source/SDL_char_utils.h",
        "Common/source/SDL_char_utils.m",
        "Common/source/SDL_uikitview+CDDA.h",
        "Common/source/SDL_uikitview+CDDA.m",
        "Common/source/SDL_uikitviewcontroller+KeyboardKeysHandling.h",
        "Common/source/SDL_uikitviewcontroller+KeyboardKeysHandling.m",
        "Common/source/SDL_uikitviewcontroller+VirtualKeyboardInput.h",
        "Common/source/SDL_uikitviewcontroller+VirtualKeyboardInput.m",
        "Common/source/main.m",
        "Common/source/path_utils.h",
        "Common/source/path_utils.m",
    ],
    data = [
        "Common/Bundle/JSDPad/dPad-None@2x.png",
        "Common/Bundle/Base.lproj/Main.storyboard",
        "Common/Bundle/Settings.bundle",
    ],
    includes = ["Common/source"],
    deps = [
        ":cdda_objc_common_gamepad",
        ":cdda_swift_common",
        "@jscontroller",
        "@sdl2",
    ],
)

objc_library(
    name = "cdda_objc_distinct",
    srcs = [
        "Distinct/source/MainViewController.m",
    ],
    hdrs = [
        "Distinct/source/MainViewController.h",
    ],
    data = [
        "Distinct/icon_1024x1024.png",
    ],
    deps = [
        ":cdda_objc_common",
        ":cdda_swift_common",
    ],
)

apple_resource_group(
    name = "cdda_mo",
    structured_resources = [
        "@cdda//:cdda_mo",
    ],
)

objc_library(
    name = "cdda_ios_main",
    srcs = [
        "Distinct/source/CDDA_iOS_main.mm",
    ],
    hdrs = [
        "Common/source/CDDA_iOS_main.h",
    ],
    copts = ["-std=gnu++14"],
    data = [
        "@cdda//:data",
        "@cdda//:gfx",
        ":cdda_mo",
    ] + glob(
        ["Common/Bundle/*.lproj/**"],
        exclude = ["Common/Bundle/Base.lproj/**"],
    ),
    deps = [
        ":cdda_objc_distinct",
        "@cdda",
        "@sdl2",
    ],
)

filegroup(
    name = "app_icon",
    srcs = glob(
        ["Distinct/Assets.xcassets/**"],
        exclude = ["**/.DS_Store"],
    ),
)

config_setting(
    name = "release",
    define_values = {
        "BUILD_TYPE": "release",
    },
)

ios_application(
    name = "cdda_ios",
    app_icons = [":app_icon"],
    bundle_id = "net.nornagon.cdda.experimental",
    entitlements = "Distinct/CDDA.entitlements",
    families = [
        "iphone",
        "ipad",
    ],
    infoplists = [":Distinct/CDDA.plist"],
    launch_storyboard = "Common/Bundle/Base.lproj/LaunchScreen.storyboard",
    minimum_os_version = "11.0",
    provisioning_profile = select({
        ":release": ":app_distribution_profile",
        "//conditions:default": ":app_debug_profile",
    }),
    version = ":version",
    visibility = ["//visibility:public"],
    deps = [
        ":cdda_ios_main",
        ":cdda_objc_common",
        ":cdda_objc_distinct",
        "@cdda",
    ],
)
