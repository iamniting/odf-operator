CEPHCSI_BUNDLE_IMG ?= quay.io/ocs-dev/cephcsi-operator-bundle:main-9bd2093
CSIADDONS_BUNDLE_IMG ?= quay.io/csiaddons/k8s-bundle:v0.14.0
NOOBAA_BUNDLE_IMG ?= quay.io/noobaa/noobaa-operator-bundle:master-20260401
OCS_BUNDLE_IMG ?= quay.io/ocs-dev/ocs-operator-bundle:main-9a87de4
OCS_CLIENT_BUNDLE_IMG ?= quay.io/ocs-dev/ocs-client-operator-bundle:main-408b4fb
PROMETHEUS_BUNDLE_IMG ?= quay.io/ocs-dev/odf-prometheus-operator-bundle:main-2a77acf
RECIPE_BUNDLE_IMG ?= quay.io/ramendr/recipe-bundle:latest
ROOK_BUNDLE_IMG ?= quay.io/ocs-dev/rook-ceph-operator-bundle:master-89eb70f42
OCS_TLS_BUNDLE_IMG ?= quay.io/ocs-dev/ocs-tls-profiles-bundle:main-9fd1952
ODF_SNAPSHOT_CONTROLLER_BUNDLE_IMG ?= quay.io/ocs-dev/snapshot-controller-bundle:main-66bfe3a
IBM_ODF_BUNDLE_IMG ?= quay.io/ibmodffs/ibm-storage-odf-operator-bundle:1.9.0
IBM_CSI_BUNDLE_IMG ?= quay.io/ibmcsiblock/ibm-block-csi-operator-bundle:1.13.2
CNSA_BUNDLE_IMG ?= cp.stg.icr.io/cp/ibm-spectrum-scale-operator-bundle:v6.0.1.1_latest

extract-maifests:
	rm -rf config/bundles/*

	$(CONTAINER_TOOL) create --name cephcsi $(CEPHCSI_BUNDLE_IMG) /bin/true
	$(CONTAINER_TOOL) cp cephcsi:/manifests config/bundles/cephcsi
	$(CONTAINER_TOOL) rm cephcsi

	$(CONTAINER_TOOL) create --name csiaddons $(CSIADDONS_BUNDLE_IMG) /bin/true
	$(CONTAINER_TOOL) cp csiaddons:/manifests config/bundles/csiaddons
	$(CONTAINER_TOOL) rm csiaddons

	$(CONTAINER_TOOL) create --name noobaa $(NOOBAA_BUNDLE_IMG) /bin/true
	$(CONTAINER_TOOL) cp noobaa:/manifests config/bundles/noobaa
	$(CONTAINER_TOOL) rm noobaa

	$(CONTAINER_TOOL) create --name ocs $(OCS_BUNDLE_IMG) /bin/true
	$(CONTAINER_TOOL) cp ocs:/manifests config/bundles/ocs
	$(CONTAINER_TOOL) rm ocs

	$(CONTAINER_TOOL) create --name client $(OCS_CLIENT_BUNDLE_IMG) /bin/true
	$(CONTAINER_TOOL) cp client:/manifests config/bundles/client
	$(CONTAINER_TOOL) rm client

	$(CONTAINER_TOOL) create --name prometheus $(PROMETHEUS_BUNDLE_IMG) /bin/true
	$(CONTAINER_TOOL) cp prometheus:/manifests config/bundles/prometheus
	$(CONTAINER_TOOL) rm prometheus

	$(CONTAINER_TOOL) create --name recipe $(RECIPE_BUNDLE_IMG) /bin/true
	$(CONTAINER_TOOL) cp recipe:/manifests config/bundles/recipe
	$(CONTAINER_TOOL) rm recipe

	$(CONTAINER_TOOL) create --name rook $(ROOK_BUNDLE_IMG) /bin/true
	$(CONTAINER_TOOL) cp rook:/manifests config/bundles/rook
	$(CONTAINER_TOOL) rm rook

	$(CONTAINER_TOOL) create --name ocs-tls $(OCS_TLS_BUNDLE_IMG) /bin/true
	$(CONTAINER_TOOL) cp ocs-tls:/manifests config/bundles/ocs-tls
	$(CONTAINER_TOOL) rm ocs-tls

	$(CONTAINER_TOOL) create --name snapshot-controller $(ODF_SNAPSHOT_CONTROLLER_BUNDLE_IMG) /bin/true
	$(CONTAINER_TOOL) cp snapshot-controller:/manifests config/bundles/snapshot-controller
	$(CONTAINER_TOOL) rm snapshot-controller

	$(CONTAINER_TOOL) create --name ibm-odf $(IBM_ODF_BUNDLE_IMG) /bin/true
	$(CONTAINER_TOOL) cp ibm-odf:/manifests config/bundles/ibm-odf
	$(CONTAINER_TOOL) rm ibm-odf

	$(CONTAINER_TOOL) create --name ibm-csi $(IBM_CSI_BUNDLE_IMG) /bin/true
	$(CONTAINER_TOOL) cp ibm-csi:/manifests config/bundles/ibm-csi
	$(CONTAINER_TOOL) rm ibm-csi

	$(CONTAINER_TOOL) create --name cnsa $(CNSA_BUNDLE_IMG) /bin/true
	$(CONTAINER_TOOL) cp cnsa:/manifests config/bundles/cnsa
	$(CONTAINER_TOOL) rm cnsa

render-bundles: opm
	$(OPM) render $(CEPHCSI_BUNDLE_IMG) > catalog/cephcsi.json
	$(OPM) render $(CSIADDONS_BUNDLE_IMG) > catalog/csiaddons.json
	$(OPM) render $(NOOBAA_BUNDLE_IMG) > catalog/noobaa.json
	$(OPM) render $(OCS_BUNDLE_IMG) > catalog/ocs.json
	$(OPM) render $(OCS_CLIENT_BUNDLE_IMG) > catalog/client.json
	$(OPM) render $(PROMETHEUS_BUNDLE_IMG) > catalog/prometheus.json
	$(OPM) render $(RECIPE_BUNDLE_IMG) > catalog/recipe.json
	$(OPM) render $(ROOK_BUNDLE_IMG) > catalog/rook.json
	$(OPM) render $(OCS_TLS_BUNDLE_IMG) > catalog/ocs-tls.json
	$(OPM) render $(ODF_SNAPSHOT_CONTROLLER_BUNDLE_IMG) > catalog/snapshot-controller.json
	$(OPM) render $(IBM_ODF_BUNDLE_IMG) > catalog/ibm-odf.json
	$(OPM) render $(IBM_CSI_BUNDLE_IMG) > catalog/ibm-csi.json
	$(OPM) render $(CNSA_BUNDLE_IMG) > catalog/cnsa.json
