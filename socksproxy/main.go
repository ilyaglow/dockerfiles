package main

import (
	"flag"
	"log"

	"github.com/armon/go-socks5"
)

func main() {
	port := flag.String("p", ":8080", "port")
	flag.Parse()

	conf := &socks5.Config{}

	srv, err := socks5.New(conf)
	if err != nil {
		log.Fatal(err)
	}

	log.Fatal(srv.ListenAndServe("tcp", *port))
}
