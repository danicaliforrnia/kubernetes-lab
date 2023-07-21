package cloud


import (
	"os"
	"testing"

	_ "k8s.io/client-go/plugin/pkg/client/auth/gcp" 

	"sigs.k8s.io/e2e-framework/klient/conf"
	"sigs.k8s.io/e2e-framework/pkg/env"
	"sigs.k8s.io/e2e-framework/pkg/envconf"
	"sigs.k8s.io/e2e-framework/pkg/envfuncs"
)

var testenv env.Environment

func TestMain(m *testing.M) {
	testenv, _ = env.NewFromFlags()
	namespace := envconf.RandomName("sample-ns", 16)

	if os.Getenv("REAL_CLUSTER") == "true" {
		path := conf.ResolveKubeConfigFile()
		cfg := envconf.NewWithKubeConfig(path)
		testenv = env.NewWithConfig(cfg)

		testenv.Setup(
			envfuncs.CreateNamespace(namespace),
		)
		
		testenv.Finish(
			envfuncs.DeleteNamespace(namespace),
		)
	} else {
		kindClusterName := envconf.RandomName("kind-with-config", 16)

		testenv.Setup(
			envfuncs.CreateKindCluster(kindClusterName),
			envfuncs.CreateNamespace(namespace),
		)

		testenv.Finish(
			envfuncs.DeleteNamespace(namespace),
			envfuncs.DestroyKindCluster(kindClusterName),
		)
	}

	os.Exit(testenv.Run(m))
}
