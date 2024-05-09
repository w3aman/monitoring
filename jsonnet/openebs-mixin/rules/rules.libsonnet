local lvmLocalPV = (import './openebs/lvmlocalpv-rules.libsonnet');
local volume = (import './volume/volume-rules.libsonnet');
local npd = (import './npd/npd-rules.libsonnet');

// Alert rules for different CAS types and others(as defined in config.libsonnet under alertRules) are stored separately in prometheusRules object.
// prometheusRules : {
//    mayastor: {
//      ...
//    },
//      ...
//    }

function(param) {
  local prometheusRules = self,
  _config+:: param,
  prometheusRules+::
    lvmLocalPV(prometheusRules._config).prometheusRules + volume(prometheusRules._config).prometheusRules
    + npd(prometheusRules._config).prometheusRules,
}
