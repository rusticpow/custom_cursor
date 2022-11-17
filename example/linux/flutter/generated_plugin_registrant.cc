//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <custom_cursor/custom_cursor_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) custom_cursor_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "CustomCursorPlugin");
  custom_cursor_plugin_register_with_registrar(custom_cursor_registrar);
}
