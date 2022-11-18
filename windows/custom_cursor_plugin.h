#ifndef FLUTTER_PLUGIN_CUSTOM_CURSOR_PLUGIN_H_
#define FLUTTER_PLUGIN_CUSTOM_CURSOR_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace custom_cursor {

class CustomCursorPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  CustomCursorPlugin();

  virtual ~CustomCursorPlugin();

  // Disallow copy and assign.
  CustomCursorPlugin(const CustomCursorPlugin&) = delete;
  CustomCursorPlugin& operator=(const CustomCursorPlugin&) = delete;

 private:
  HCURSOR current_cursor_;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace custom_cursor

#endif  // FLUTTER_PLUGIN_CUSTOM_CURSOR_PLUGIN_H_
