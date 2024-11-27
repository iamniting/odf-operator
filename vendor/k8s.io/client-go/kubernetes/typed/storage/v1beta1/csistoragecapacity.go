/*
Copyright The Kubernetes Authors.

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

// Code generated by client-gen. DO NOT EDIT.

package v1beta1

import (
	"context"

	v1beta1 "k8s.io/api/storage/v1beta1"
	v1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	types "k8s.io/apimachinery/pkg/types"
	watch "k8s.io/apimachinery/pkg/watch"
	storagev1beta1 "k8s.io/client-go/applyconfigurations/storage/v1beta1"
	gentype "k8s.io/client-go/gentype"
	scheme "k8s.io/client-go/kubernetes/scheme"
)

// CSIStorageCapacitiesGetter has a method to return a CSIStorageCapacityInterface.
// A group's client should implement this interface.
type CSIStorageCapacitiesGetter interface {
	CSIStorageCapacities(namespace string) CSIStorageCapacityInterface
}

// CSIStorageCapacityInterface has methods to work with CSIStorageCapacity resources.
type CSIStorageCapacityInterface interface {
	Create(ctx context.Context, cSIStorageCapacity *v1beta1.CSIStorageCapacity, opts v1.CreateOptions) (*v1beta1.CSIStorageCapacity, error)
	Update(ctx context.Context, cSIStorageCapacity *v1beta1.CSIStorageCapacity, opts v1.UpdateOptions) (*v1beta1.CSIStorageCapacity, error)
	Delete(ctx context.Context, name string, opts v1.DeleteOptions) error
	DeleteCollection(ctx context.Context, opts v1.DeleteOptions, listOpts v1.ListOptions) error
	Get(ctx context.Context, name string, opts v1.GetOptions) (*v1beta1.CSIStorageCapacity, error)
	List(ctx context.Context, opts v1.ListOptions) (*v1beta1.CSIStorageCapacityList, error)
	Watch(ctx context.Context, opts v1.ListOptions) (watch.Interface, error)
	Patch(ctx context.Context, name string, pt types.PatchType, data []byte, opts v1.PatchOptions, subresources ...string) (result *v1beta1.CSIStorageCapacity, err error)
	Apply(ctx context.Context, cSIStorageCapacity *storagev1beta1.CSIStorageCapacityApplyConfiguration, opts v1.ApplyOptions) (result *v1beta1.CSIStorageCapacity, err error)
	CSIStorageCapacityExpansion
}

// cSIStorageCapacities implements CSIStorageCapacityInterface
type cSIStorageCapacities struct {
	*gentype.ClientWithListAndApply[*v1beta1.CSIStorageCapacity, *v1beta1.CSIStorageCapacityList, *storagev1beta1.CSIStorageCapacityApplyConfiguration]
}

// newCSIStorageCapacities returns a CSIStorageCapacities
func newCSIStorageCapacities(c *StorageV1beta1Client, namespace string) *cSIStorageCapacities {
	return &cSIStorageCapacities{
		gentype.NewClientWithListAndApply[*v1beta1.CSIStorageCapacity, *v1beta1.CSIStorageCapacityList, *storagev1beta1.CSIStorageCapacityApplyConfiguration](
			"csistoragecapacities",
			c.RESTClient(),
			scheme.ParameterCodec,
			namespace,
			func() *v1beta1.CSIStorageCapacity { return &v1beta1.CSIStorageCapacity{} },
			func() *v1beta1.CSIStorageCapacityList { return &v1beta1.CSIStorageCapacityList{} }),
	}
}