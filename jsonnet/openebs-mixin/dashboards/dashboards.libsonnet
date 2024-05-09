// Populate grafanaDashboards object
function(param) {
  local dashboard = self,
  _config+:: param,
  grafanaDashboards+:: {
    [if dashboard._config.dashboards.lvmLocalPV then 'lvmlocalpv-pool.json']: import './openebs/lvmlocalpv-pool.json',
    [if dashboard._config.dashboards.zfsLocalPV then 'zfslocalpv.json']: import './openebs/zfslocalpv.json',
    [if dashboard._config.dashboards.mayastor then 'diskpool.json']: import './mayastor/diskpool.json',
    [if dashboard._config.dashboards.mayastor then 'volume.json']: import './mayastor/volume.json',
    [if dashboard._config.dashboards.mayastor then 'volume-replica.json']: import './mayastor/volume-replica.json',
    [if dashboard._config.dashboards.npd then 'npd-node-volume-problem.json']: import './npd/npd-node-volume-problem.json',
  },
}
