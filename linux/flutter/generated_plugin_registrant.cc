//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <descope/descope_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) descope_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "DescopePlugin");
  descope_plugin_register_with_registrar(descope_registrar);
}
