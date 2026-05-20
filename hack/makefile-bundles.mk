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

	mkdir config/bundles/cephcsi
	$(CONTAINER_TOOL) create --name cephcsi $(CEPHCSI_BUNDLE_IMG) /bin/true
	$(CONTAINER_TOOL) cp cephcsi:/manifests config/bundles/cephcsi/manifests
	$(CONTAINER_TOOL) cp cephcsi:/metadata config/bundles/cephcsi/metadata
	$(CONTAINER_TOOL) rm cephcsi

	mkdir config/bundles/csiaddons
	$(CONTAINER_TOOL) create --name csiaddons $(CSIADDONS_BUNDLE_IMG) /bin/true
	$(CONTAINER_TOOL) cp csiaddons:/manifests config/bundles/csiaddons/manifests
	$(CONTAINER_TOOL) cp csiaddons:/metadata config/bundles/csiaddons/metadata
	$(CONTAINER_TOOL) rm csiaddons

	mkdir config/bundles/noobaa
	$(CONTAINER_TOOL) create --name noobaa $(NOOBAA_BUNDLE_IMG) /bin/true
	$(CONTAINER_TOOL) cp noobaa:/manifests config/bundles/noobaa/manifests
	$(CONTAINER_TOOL) cp noobaa:/metadata config/bundles/noobaa/metadata
	$(CONTAINER_TOOL) rm noobaa

	mkdir config/bundles/ocs
	$(CONTAINER_TOOL) create --name ocs $(OCS_BUNDLE_IMG) /bin/true
	$(CONTAINER_TOOL) cp ocs:/manifests config/bundles/ocs/manifests
	$(CONTAINER_TOOL) cp ocs:/metadata config/bundles/ocs/metadata
	$(CONTAINER_TOOL) rm ocs

	mkdir config/bundles/client
	$(CONTAINER_TOOL) create --name client $(OCS_CLIENT_BUNDLE_IMG) /bin/true
	$(CONTAINER_TOOL) cp client:/manifests config/bundles/client/manifests
	$(CONTAINER_TOOL) cp client:/metadata config/bundles/client/metadata
	$(CONTAINER_TOOL) rm client

	mkdir config/bundles/prometheus
	$(CONTAINER_TOOL) create --name prometheus $(PROMETHEUS_BUNDLE_IMG) /bin/true
	$(CONTAINER_TOOL) cp prometheus:/manifests config/bundles/prometheus/manifests
	$(CONTAINER_TOOL) cp prometheus:/metadata config/bundles/prometheus/metadata
	$(CONTAINER_TOOL) rm prometheus

	mkdir config/bundles/recipe
	$(CONTAINER_TOOL) create --name recipe $(RECIPE_BUNDLE_IMG) /bin/true
	$(CONTAINER_TOOL) cp recipe:/manifests config/bundles/recipe/manifests
	$(CONTAINER_TOOL) cp recipe:/metadata config/bundles/recipe/metadata
	$(CONTAINER_TOOL) rm recipe

	mkdir config/bundles/rook
	$(CONTAINER_TOOL) create --name rook $(ROOK_BUNDLE_IMG) /bin/true
	$(CONTAINER_TOOL) cp rook:/manifests config/bundles/rook/manifests
	$(CONTAINER_TOOL) cp rook:/metadata config/bundles/rook/metadata
	$(CONTAINER_TOOL) rm rook

	mkdir config/bundles/ocs-tls
	$(CONTAINER_TOOL) create --name ocs-tls $(OCS_TLS_BUNDLE_IMG) /bin/true
	$(CONTAINER_TOOL) cp ocs-tls:/manifests config/bundles/ocs-tls/manifests
	$(CONTAINER_TOOL) cp ocs-tls:/metadata config/bundles/ocs-tls/metadata
	$(CONTAINER_TOOL) rm ocs-tls

	mkdir config/bundles/snapshot-controller
	$(CONTAINER_TOOL) create --name snapshot-controller $(ODF_SNAPSHOT_CONTROLLER_BUNDLE_IMG) /bin/true
	$(CONTAINER_TOOL) cp snapshot-controller:/manifests config/bundles/snapshot-controller/manifests
	$(CONTAINER_TOOL) cp snapshot-controller:/metadata config/bundles/snapshot-controller/metadata
	$(CONTAINER_TOOL) rm snapshot-controller

	mkdir config/bundles/ibm-odf
	$(CONTAINER_TOOL) create --name ibm-odf $(IBM_ODF_BUNDLE_IMG) /bin/true
	$(CONTAINER_TOOL) cp ibm-odf:/manifests config/bundles/ibm-odf/manifests
	$(CONTAINER_TOOL) cp ibm-odf:/metadata config/bundles/ibm-odf/metadata
	$(CONTAINER_TOOL) rm ibm-odf

	mkdir config/bundles/ibm-csi
	$(CONTAINER_TOOL) create --name ibm-csi $(IBM_CSI_BUNDLE_IMG) /bin/true
	$(CONTAINER_TOOL) cp ibm-csi:/manifests config/bundles/ibm-csi/manifests
	$(CONTAINER_TOOL) cp ibm-csi:/metadata config/bundles/ibm-csi/metadata
	$(CONTAINER_TOOL) rm ibm-csi

	mkdir config/bundles/cnsa
	$(CONTAINER_TOOL) create --name cnsa $(CNSA_BUNDLE_IMG) /bin/true
	$(CONTAINER_TOOL) cp cnsa:/manifests config/bundles/cnsa/manifests
	$(CONTAINER_TOOL) cp cnsa:/metadata config/bundles/cnsa/metadata
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
