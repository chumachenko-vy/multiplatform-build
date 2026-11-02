package main

import (
	"fmt"
	"runtime"
)

func Greeting() string {
	return "Hello from " + runtime.GOOS + "/" + runtime.GOARCH
}

func main() {
	fmt.Println(Greeting())
}
