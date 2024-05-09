{
  // import kube-prometheus and override configurations
  kp:
    (import 'kube-prometheus/main.libsonnet') +
    (import 'kube-prometheus/addons/all-namespaces.libsonnet') +
    // Uncomment the following imports to enable its patches
    // (import 'kube-prometheus/addons/anti-affinity.libsonnet') +
    // (import 'kube-prometheus/addons/managed-cluster.libsonnet') +
    (import 'kube-prometheus/addons/node-ports.libsonnet') +
    // (import 'kube-prometheus/addons/static-etcd.libsonnet') +
    // (import 'kube-prometheus/addons/custom-metrics.libsonnet') +
    // (import 'kube-prometheus/addons/external-metrics.libsonnet') +
    {
      values+:: {
        common+: {
          namespace: $._config.openebsMonitoring.namespace,
        },
      },
    },

  // import openebs-mixin and override configurations
  openebsMixin: (import './openebs-mixin/mixin.libsonnet') {
    _config+:: {
      dashboards+: {
        lvmLocalPV: $._config.openebsMonitoringAddon.lvmLocalPV.dashboards,
        zfsLocalPV: $._config.openebsMonitoringAddon.zfsLocalPV.dashboards,
        mayastor: $._config.openebsMonitoringAddon.mayastor.dashboards,
      },
      alertRules+: {
        lvmLocalPV: $._config.openebsMonitoringAddon.lvmLocalPV.alertRules,
        zfsLocalPV: $._config.openebsMonitoringAddon.zfsLocalPV.alertRules,
        mayastor: $._config.openebsMonitoringAddon.mayastor.alertRules,
      },
    },
  },

  // Template function for ServiceMonitor
  local serviceMonitor(port, path, selectorName) = {
    // Endpoints of the selected service to be monitored
    endpoints: {

      // Name of the endpoint's service port
      port: port,

      // HTTP path to scrape for metrics
      path: path,
    },
    // Label selector for services to which this ServiceMonitor applies
    selector: {
      matchLabels: selectorName,
    },
    // Namespaces from which services are selected
    namespaceSelector: {
      any: true,
    },
  },

  // Configuration for openebs monitoring
  _config+:: {
    openebsMonitoring: {
      namespace: 'openebs',
    },
    // Configuration for different cas types.
    openebsMonitoringAddon: {
      mayastor: {
        // To generate manifests for mayastor. If set, manifests will be generated.
        enabled: true,
        // To generate dashboards configMap yamls. If set, dashboards will be appended in grafana-dashboardDefinition yaml.
        dashboards: true,
        // To generate prometheusRule yamls. If set, prometheusRule will be generated.
        alertRules: false,
        // ServiceMonitor configuration
        serviceMonitor: serviceMonitor('metrics', '/metrics', {
          app: 'metrics-exporter-io-engine',
        }) {
          enabled: true,
        },
        // PodMonitor configuration
        podMonitor: {
          enabled: false,
        },
      },
      lvmLocalPV: {
        // To generate manifests for lvmLocalPV. If set, manifests will be generated for lvm-localpv.
        enabled: true,
        // To generate dashboards configMap yamls. If set, dashboards will be appended in grafana-dashboardDefinition yaml.
        dashboards: true,
        // To generate prometheusRule yamls. If set, prometheusRule will be generated.
        alertRules: true,
        // ServiceMonitor configuration
        serviceMonitor: serviceMonitor('metrics', '/metrics', {
          name: 'openebs-lvm-node',
        }) {
          enabled: true,
        },
        // PodMonitor configuration
        podMonitor: {
          enabled: false,
        },
      },
      zfsLocalPV: {
        // To generate manifests for zfs localpv. If set, manifests will be generated.
        enabled: true,
        // To generate dashboards configMap yamls. If set, dashboards will be appended in grafana-dashboardDefinition yaml.
        dashboards: true,
        // To generate prometheusRule yamls. If set, prometheusRule will be generated.
        alertRules: false,
        // ServiceMonitor configuration
        serviceMonitor: {
          enabled: false,
        },
        // PodMonitor configuration
        podMonitor: {
          enabled: false,
        },
      },
    },
  },
}
