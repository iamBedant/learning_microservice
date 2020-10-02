package models

type SignInResponse struct {
	Token string `json:"token"`
}

func (r *SignInResponse) prepare(token string)  {
	r.Token = token
}