# OpenEBS Monitoring

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
![Chart Lint and Test](https://github.com/openebs/monitoring/workflows/Chart%20Lint%20and%20Test/badge.svg)
![Release Charts](https://github.com/openebs/monitoring/workflows/Release%20Charts/badge.svg?branch=develop)

A Helm chart for OpenEBS monitoring. This chart bootstraps OpenEBS monitoring stack on a [Kubernetes](http://kubernetes.io) cluster using the  
[Helm](https://helm.sh) package manager.

**Homepage:** <http://www.openebs.io/>

## Get Repo Info

```console
helm repo add monitoring https://openebs.github.io/monitoring/
helm repo update
```

_See [helm repo](https://helm.sh/docs/helm/helm_repo/) for command documentation._

## Install Chart

Please visit the [link](https://openebs.github.io/monitoring/) for install instructions via helm3.

```console
# Helm
helm install [RELEASE_NAME] monitoring/monitoring --namespace [NAMESPACE] --create-namespace
```

_See [configuration](#configuration) below._

_See [helm install](https://helm.sh/docs/helm/helm_install/) for command documentation._

## Dependencies

By default this chart installs additional, dependent charts:

| Repository                                                                                 | Name                  | Version  |
| ------------------------------------------------------------------------------------------ | --------------------- | -------- |
| https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack | kube-prometheus-stack | `58.0.*` |
| https://charts.deliveryhero.io/                                                            | node-problem-detector | `2.0.*`  |

_See [helm dependency](https://helm.sh/docs/helm/helm_dependency/) for command documentation._

## Uninstall Chart

```console
# Helm
helm uninstall [RELEASE_NAME] --namespace [NAMESPACE]
```

This removes all the Kubernetes components associated with the chart and deletes the release.

_See [helm uninstall](https://helm.sh/docs/helm/helm_uninstall/) for command documentation._

## Upgrading Chart

```console
# Helm
helm upgrade [RELEASE_NAME] [CHART] --install --namespace [NAMESPACE]
```

## Configuration

The following table lists the configurable parameters of the OpenEBS monitoring chart and their default values.

You can modify different parameters by specifying the desired value in the `helm install` command by using the `--set` and/or the `--set-string` flag(s). You can modify the parameters of the [kube-prometheus-stack chart](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack) by adding `kube-prometheus-stack` before the desired parameter in the `helm install` command.

In the following sample command we modify `openebsMonitoringAddon.lvmLocalPV.enabled` from the monitoring chart and `kube-prometheus-stack.kubeProxy.enabled` from the kube-prometheus-stack chart to disable monitoring for lvmLocalPV and kube-proxy.

```console
helm install monitoring monitoring/monitoring --namespace openebs --create-namespace \
	--set openebsMonitoringAddon.lvmLocalPV.enabled=false \
	--set kube-prometheus-stack.kubeProxy.enabled=false
```

| Parameter                                                                                 | Description                                                                         | Default                                                   |
| ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- | --------------------------------------------------------- |
| `kube-prometheus-stack.global.rbac.pspEnabled`                                           | Disable PSP for alertmanager, prometheus and prometheus-operator                                                         | `false`                                              |
| `kube-prometheus-stack.kube-state-metrics.podSecurityPolicy.enabled`                                           | Disable PSP for kube-state-metrics                                                        | `false`                                              |
| `kube-prometheus-stack.prometheus.service.type`                                           | Service type for Prometheus                                                         | `"NodePort"`                                              |
| `kube-prometheus-stack.prometheus.service.nodePort`                                       | NodePort value for Prometheus service                                               | `32514`                                                   |
| `kube-prometheus-stack.prometheus.prometheusSpec.serviceMonitorSelectorNilUsesHelmValues` | Enables Prometheus to select every service monitors                                 | `false`                                                   |
| `kube-prometheus-stack.prometheus.prometheusSpec.podMonitorSelectorNilUsesHelmValues`     | Enables Prometheus to select every pod monitors                                     | `false`                                                   |
| `kube-prometheus-stack.prometheus.prometheusSpec.ruleSelectorNilUsesHelmValues`           | Enables Prometheus to select every Prometheus rules                                 | `false`                                                   |
| `kube-prometheus-stack.prometheus.prometheusSpec.replicas`                                | Number of instances to deploy for a Prometheus deployment                           | `1`                                                       |
| `kube-prometheus-stack.prometheus.prometheusSpec.storageSpec`                             | Storage spec to specify how storage shall be used.                                  | `{}`                                                      |
| `kube-prometheus-stack.prometheus-node-exporter.rbac.pspEnabled`                                           | Disable PSP for node-exporter                                                         | `false`                                              |
| `kube-prometheus-stack.prometheus-node-exporter.securityContext`                          | Privilege and access control settings for node-exporter                             | `{...}`                                                   |
| `kube-prometheus-stack.prometheus-node-exporter.extraArgs`                                | Additional container arguments                                                      | `[...]`                                                   |
| `kube-prometheus-stack.alertmanager.enabled`                                              | Deploy Alertmanager                                                                 | `true`                                                    |
| `kube-prometheus-stack.alertmanager.config`                                               | Provide YAML to configure Alertmanager.                                             | `{...}`                                                   |
| `kube-prometheus-stack.alertmanager.service.type`                                         | Service type for Alertmanager                                                       | `"NodePort"`                                              |
| `kube-prometheus-stack.alertmanager.service.nodePort`                                     | NodePort value for Alertmanager service                                             | `30903`                                                   |
| `kube-prometheus-stack.alertmanager.alertmanagerSpec.replicas`                            | Number of instances to deploy for a Alertmanager deployment                         | `1`                                                       |
| `kube-prometheus-stack.alertmanager.alertmanagerSpec.storage`                             | Storage is the definition of how storage will be used by the Alertmanager instances | `{}`                                                      |
| `kube-prometheus-stack.prometheusOperator.enabled`                                        | Deploy Prometheus Operator                                                          | `true`                                                    |
| `kube-prometheus-stack.grafana.enabled`                                                   | Enables monitoring of grafana itself                                                | `true`                                                    |
| `kube-prometheus-stack.grafana.rbac.pspEnabled`                                           | Disable PSP for grafana                                                        | `false`                                              |
| `kube-prometheus-stack.grafana.grafana.ini`                                               | Append to Grafana's primary configuration                                           | `{panels: {disable_sanitize_html: true}}`                 |
| `kube-prometheus-stack.grafana.service.type`                                              | Service type for Grafana                                                            | `"NodePort"`                                              |
| `kube-prometheus-stack.grafana.service.nodePort`                                          | NodePort value for Grafana service                                                  | `32515`                                                   |
| `kube-prometheus-stack.grafana.defaultDashboardsEnabled`                                  | Deploys default dashboards                                                          | `true`                                                    |
| `kube-prometheus-stack.grafana.openebsDashboardsEnabled`                                  | Deploys custom OpenEBS dashboards                                                   | `true`                                                    |
| `kube-prometheus-stack.grafana.adminPassword`                                             | Administrator password for Grafana                                                  | `"admin"`                                                 |
| `kube-prometheus-stack.grafana.sidecar.dashboards.enabled`                                | Allows Grafana sidecar container to provision dashboards                            | `true`                                                    |
| `kube-prometheus-stack.grafana.sidecar.dashboards.label`                                  | Labels for configmaps to be collected by Grafana sidecars                           | `"grafana_dashboard"`                                     |
| `kube-prometheus-stack.grafana.plugins`                                                   | Adds Grafana plugin list to be installed                                            | `["grafana-polystat-panel","snuids-trafficlights-panel"]` |
| `openebsMonitoringAddon.lvmLocalPV.enabled`                                               | Enables installation of monitoring addons for lvm-LocalPV                           | `true`                                                    |
| `openebsMonitoringAddon.lvmLocalPV.dashboards.enabled`                                    | Enables dashboard installation of OpenEBS lvm-localpv storage engine                | `true`                                                    |
| `openebsMonitoringAddon.npd.dashboards.enabled`                                           | Enables dashboard installation related to node problems                             | `true`                                                    |
| `node-problem-detector.extraVolumes`                                                      | Volumes needed by node problem detector                                             | `[...]`                                                   |
| `node-problem-detector.extraVolumeMounts`                                                 | Volumes mounts needed by node problem detector                                      | `[...]`                                                   |
| `node-problem-detector.metrics.serviceMonitor.enabled`                                    | Enables node problem detector monitoring                                            | `true`                                                    |
| `openebsMonitoringAddon.lvmLocalPV.alertRules.enabled`                                    | Enables OpenEBS lvm-localpv Storage engine rules                                    | `true`                                                    |
| `openebsMonitoringAddon.volume.alertRules.enabled`                                        | Enables persistent volume rules                                                     | `true`                                                    |
| `openebsMonitoringAddon.lvmLocalPV.serviceMonitor.enabled`                                | Enables monitoring of lvm localPV                                                   | `true`                                                    |
| `openebsMonitoringAddon.lvmLocalPV.serviceMonitor.endpoints.port`                         | Name of the service port lvm localPV node endpoint refers to                        | `"metrics"`                                               |
| `openebsMonitoringAddon.lvmLocalPV.serviceMonitor.endpoints.path`                         | HTTP path to scrape for metrics from lvm localPV node                               | `"/metrics"`                                              |
| `openebsMonitoringAddon.lvmLocalPV.serviceMonitor.selector`                               | Selector to select endpoints objects                                                | `{matchLabels: {name: openebs-lvm-node}}`                 |
| `openebsMonitoringAddon.lvmLocalPV.serviceMonitor.namespaceSelector`                      | Selector to select which namespaces the endpoints objects are discovered from       | `[any: true]`                                             |
| `openebsMonitoringAddon.zfsLocalPV.enabled`                                               | Enables installation of monitoring addons for zfs LocalPV                           | `true`                                                    |
| `openebsMonitoringAddon.zfsLocalPV.dashboards.enabled`                                    | Enables dashboard installation of OpenEBS zfs localPV Storage engine                | `true`                                                    |

We can edit the npd parameters too accordingly from [here](https://artifacthub.io/packages/helm/deliveryhero/node-problem-detector)

A YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```bash
helm install <release-name> -f values.yaml --namespace monitoring monitoring/monitoring
```

> **Tip**: You can use the default [values.yaml](values.yaml)
