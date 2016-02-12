package main

import (
    "fmt"
    "net/http"
    "os"
    "os/signal"
    "syscall"
)

func handler(w http.ResponseWriter, r *http.Request) {
	hostname, _ := os.Hostname()
	fmt.Fprintln(w, "<html><head></head><body><h2>Welcome this page runs in a docker container</h2>")
	fmt.Fprintln(w, "... and the container's hostname is:")
	fmt.Fprintln(w, "<h1>"+hostname+"</h1>")
	fmt.Fprintln(w, "</body></html>")
}

func startserver() {
    var PORT string
    PORT = "80"
    http.HandleFunc("/", handler)
    fmt.Println("serving at "+":"+PORT)
    http.ListenAndServe(":"+PORT, nil)
}

func main() {
    go startserver()
    sig := make(chan os.Signal)
    signal.Notify(sig, syscall.SIGINT, syscall.SIGTERM)
    endless:
        select {
        case s :=  <-sig:
            fmt.Println( "Signal (%d) received, stopping ", s)
            break endless
        }
}
