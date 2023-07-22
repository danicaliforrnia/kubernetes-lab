package cloud

import (
	"context"
	"testing"
	"time"

	appsv1 "k8s.io/api/apps/v1"
	v1 "k8s.io/api/core/v1"
	corev1 "k8s.io/api/core/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"sigs.k8s.io/e2e-framework/klient/k8s"
	"sigs.k8s.io/e2e-framework/klient/wait"
	"sigs.k8s.io/e2e-framework/klient/wait/conditions"
	"sigs.k8s.io/e2e-framework/pkg/envconf"
	"sigs.k8s.io/e2e-framework/pkg/features"
)

func TestRealClusterWithWait(t *testing.T) {
	deploymentFeature := features.New("appsv1/deployment").WithLabel("type", "wait").
		Setup(func(ctx context.Context, t *testing.T, cfg *envconf.Config) context.Context {
			deployment := newWaitDeployment(cfg.Namespace(), "test-deployment", 4)
			client, err := cfg.NewClient()

			if err != nil {
				t.Fatal(err)
			}

			if err := client.Resources().Create(ctx, deployment); err != nil {
				t.Fatal(err)
			}

			return ctx
		}).
		Assess("deployment >=50% available", func(ctx context.Context, t *testing.T, cfg *envconf.Config) context.Context {
			client, err := cfg.NewClient()
			if err != nil {
				t.Fatal(err)
			}
			
			dep := appsv1.Deployment{
				ObjectMeta: metav1.ObjectMeta{Name: "test-deployment", Namespace: cfg.Namespace()},
			}

			
			err = wait.For(conditions.New(client.Resources()).ResourceMatch(&dep, func(object k8s.Object) bool {
				d := object.(*appsv1.Deployment)
				return float64(d.Status.ReadyReplicas)/float64(*d.Spec.Replicas) >= 0.50
			}), wait.WithTimeout(time.Minute*2))
			
			if err != nil {
				t.Fatal(err)
			}

			t.Logf("deployment availability: %.2f%%", float64(dep.Status.ReadyReplicas)/float64(*dep.Spec.Replicas)*100)

			return ctx
		}).
		Assess("deployment available", func(ctx context.Context, t *testing.T, cfg *envconf.Config) context.Context {
			client, err := cfg.NewClient()

			if err != nil {
				t.Fatal(err)
			}

			dep := appsv1.Deployment{
				ObjectMeta: metav1.ObjectMeta{Name: "test-deployment", Namespace: cfg.Namespace()},
			}

			
			err = wait.For(conditions.New(client.Resources()).DeploymentConditionMatch(&dep, appsv1.DeploymentAvailable, v1.ConditionTrue), wait.WithTimeout(time.Minute*1))

			if err != nil {
				t.Fatal(err)
			}

			return ctx
		}).Feature()

	testenv.Test(t, deploymentFeature)
}

func newWaitDeployment(namespace string, name string, replicaCount int32) *appsv1.Deployment {
	return &appsv1.Deployment{
		ObjectMeta: metav1.ObjectMeta{Name: name, Namespace: namespace, Labels: map[string]string{"app": "test-app"}},
		Spec: appsv1.DeploymentSpec{
			Replicas: &replicaCount,
			Selector: &metav1.LabelSelector{
				MatchLabels: map[string]string{"app": "test-app"},
			},
			Template: corev1.PodTemplateSpec{
				ObjectMeta: metav1.ObjectMeta{Labels: map[string]string{"app": "test-app"}},
				Spec:       corev1.PodSpec{Containers: []corev1.Container{{Name: "nginx", Image: "nginx"}}},
			},
		},
	}
}