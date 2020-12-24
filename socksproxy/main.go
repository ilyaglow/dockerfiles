package main

import (
	"flag"
	"log"
	"os"

	"github.com/armon/go-socks5"
)

func main() {
	conf := &socks5.Config{
		AuthMethods: []socks5.Authenticator{
			socks5.UserPassAuthenticator{
				Credentials: socks5.StaticCredentials{
					os.Getenv("USER"): os.Getenv("PASS"),
				},
			},
		},
		Logger: log.New(os.Stdout, "", log.LstdFlags),
	}
	port := flag.String("p", ":8080", "port")
	flag.Parse()

	srv, err := socks5.New(conf)
	if err != nil {
		log.Fatal(err)
	}

	log.Fatal(srv.ListenAndServe("tcp", *port))
}
