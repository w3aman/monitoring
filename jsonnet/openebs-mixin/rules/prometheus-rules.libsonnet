local lvmLocalPV = (import './openebs/lvmlocalpv-rules.libsonnet');
local volume = (import './volume/volume-rules.libsonnet');
local npd = (import './npd/npd-rules.libsonnet');

// Populate prometheusRules object from volume, and npd rules.
// prometheusRules:{
//     groups:[
//            {npd alert-1},
//            {npd alert-2}
//             .
//             .
//            {npd alert-n},
//             ...
//        ]
//   },

function(param) {
  local prometheusRules = self,
  _config+:: param,
  prometheusRules+::
    lvmLocalPV(prometheusRules._config).prometheusRules.lvmLocalPV + volume(prometheusRules._config).prometheusRules.volume
    + npd(prometheusRules._config).prometheusRules.npd,
}
