package main

import "net/http"

func main() {

	http.HandleFunc("/", func(resWriter http.ResponseWriter, request *http.Request) {
		resWriter.Write([]byte("<h1>hello xmiss33<h1>"))
	})

	http.ListenAndServe(":8888", nil)
}
