#include "include/custom_cursor/custom_cursor_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "custom_cursor_plugin.h"

void CustomCursorPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  custom_cursor::CustomCursorPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
