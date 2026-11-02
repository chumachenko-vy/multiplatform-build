package main

import (
	"strings"
	"testing"
)

func TestGreeting(t *testing.T) {
	if !strings.HasPrefix(Greeting(), "Hello from ") {
		t.Fatalf("unexpected greeting: %s", Greeting())
	}
}
