package controllers

import (
	"net/http"
	"../responses"
)

func (server *Server) Home(w http.ResponseWriter, r *http.Request) {
	responses.JSON(w, http.StatusOK, "Welcome to this dummy api homepage")
}