{
  // openebs-mixin configurations
  _config+:: {
    // Configuration to set which cas types is installed. Based on this, dashboards and alert rules configuration will be set.
    casTypes: {
      lvmLocalPV: true,
      zfsLocalPV: true,
      mayastor: true,
    },

    // dashboards configuration. If set, then dashboards json will be generated.
    dashboards: {
      lvmLocalPV: $._config.casTypes.lvmLocalPV,
      zfsLocalPV: $._config.casTypes.zfsLocalPV,
      npd: true,
      mayastor: $._config.casTypes.mayastor,
    },
    // AlertRules configuration. If set, then rules json will be generated.
    alertRules: {
      lvmLocalPV: $._config.casTypes.lvmLocalPV,
      volume: $._config.casTypes.lvmLocalPV,
      npd: true,
    },
  },
}
