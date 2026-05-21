/*
Copyright 2026 Data Foundation.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

package webhook

import (
	"context"
	"encoding/json"
	"fmt"
	"net/http"

	appsv1 "k8s.io/api/apps/v1"
	ctrl "sigs.k8s.io/controller-runtime"
	"sigs.k8s.io/controller-runtime/pkg/client"
	"sigs.k8s.io/controller-runtime/pkg/log"
	"sigs.k8s.io/controller-runtime/pkg/webhook"
	"sigs.k8s.io/controller-runtime/pkg/webhook/admission"

	"github.com/red-hat-storage/odf-operator/internal/controller"
)

type OperatorDeploymentMutator struct {
	Client            client.Client
	Decoder           admission.Decoder
	OperatorNamespace string
}

func (r *OperatorDeploymentMutator) Handle(ctx context.Context, req admission.Request) admission.Response {

	logger := log.FromContext(ctx)
	logger.Info("request received for deployment review")

	deployment := &appsv1.Deployment{}
	if err := r.Decoder.Decode(req, deployment); err != nil {
		logger.Error(err, "failed decoding admission review as deployment")
		return admission.Errored(http.StatusBadRequest, fmt.Errorf("failed decoding admission review as deployment: %v", err))
	}

	deployment.Spec.Template.Spec.HostNetwork = true

	marshaledDeployment, err := json.Marshal(deployment)
	if err != nil {
		logger.Error(err, "failed marshaling deployment")
		return admission.Errored(http.StatusInternalServerError, fmt.Errorf("failed marshaling deployment: %v", err))
	}

	return admission.PatchResponseFromRaw(req.Object.Raw, marshaledDeployment)
}

func (r *OperatorDeploymentMutator) SetupWebhookWithManager(mgr ctrl.Manager) error {

	mgr.GetWebhookServer().Register(controller.DeploymentWebhookPath, &webhook.Admission{Handler: r})

	return nil
}
