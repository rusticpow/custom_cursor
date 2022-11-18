#include "custom_cursor_plugin.h"

// This must be included before many other Windows headers.
#include <windows.h>

// For getPlatformVersion; remove unless needed for your plugin implementation.
#include <VersionHelpers.h>

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

#include <memory>
#include <sstream>

namespace custom_cursor {

// static
void CustomCursorPlugin::RegisterWithRegistrar(
    flutter::PluginRegistrarWindows *registrar) {
  auto channel =
      std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
          registrar->messenger(), "custom_cursor",
          &flutter::StandardMethodCodec::GetInstance());

  auto plugin = std::make_unique<CustomCursorPlugin>();

  channel->SetMethodCallHandler(
      [plugin_pointer = plugin.get()](const auto &call, auto result) {
        plugin_pointer->HandleMethodCall(call, std::move(result));
      });

  registrar->AddPlugin(std::move(plugin));
}

CustomCursorPlugin::CustomCursorPlugin() {}

CustomCursorPlugin::~CustomCursorPlugin() {}

std::wstring get_utf16(const std::string& str, int codepage)
{
    if (str.empty()) return std::wstring();
    int sz = MultiByteToWideChar(codepage, 0, &str[0], (int)str.size(), 0, 0);
    std::wstring res(sz, 0);
    MultiByteToWideChar(codepage, 0, &str[0], (int)str.size(), &res[0], sz);
    return res;
}

void CustomCursorPlugin::HandleMethodCall(
    const flutter::MethodCall<flutter::EncodableValue> &method_call,
    std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {
  if (method_call.method_name().compare("activateCustomCursor") == 0) {
    std::ostringstream version_stream;
    version_stream << "Windows ";
    const flutter::EncodableMap* argsList = std::get_if<flutter::EncodableMap>(method_call.arguments());
    auto a_it = (argsList->find(flutter::EncodableValue("curFile")))->second;
    const auto& curFile = std::get<std::string>(a_it);
    auto curFileS = get_utf16(curFile, CP_UTF8);
    LPCWSTR curFileLS = curFileS.c_str();
    current_cursor_ = ::LoadCursorFromFile(curFileLS);
   // const HCURSOR customCursor = static_cast<HCURSOR>(LoadImage(nullptr, (curFile.c_str()), IMAGE_CURSOR, 0, 0, LR_LOADFROMFILE))
    ::SetCursor(current_cursor_);

    if (IsWindows10OrGreater()) {
      version_stream << "10+";
    } else if (IsWindows8OrGreater()) {
      version_stream << "8";
    } else if (IsWindows7OrGreater()) {
      version_stream << "7";
    }
    result->Success();
  }
  else {
    result->NotImplemented();
  }
}

}  // namespace custom_cursor
