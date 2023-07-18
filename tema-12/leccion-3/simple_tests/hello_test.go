package simple_tests

import (
	"context"
	"fmt"
	"testing"
	"sigs.k8s.io/e2e-framework/pkg/env"
	"sigs.k8s.io/e2e-framework/pkg/envconf"
	"sigs.k8s.io/e2e-framework/pkg/features"
)

func Hello(name string) string {
	return fmt.Sprintf("Hello %s", name)
}

func TestHello(t *testing.T) {
	e := env.NewWithConfig(envconf.New())
	feat := features.New("Hello Feature").
		Assess("test message", func(ctx context.Context, t *testing.T, _ *envconf.Config) context.Context {
			result := Hello("foo")
			if result != "Hello foo" {
				t.Error("unexpected message")
			}
			return ctx
		})

	e.Test(t, feat.Feature())
}
