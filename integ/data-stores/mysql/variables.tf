variable "db_username" {
  description = "Nombre de usuario de la BBDD"
  type = string
  sensitive = true
}

variable "db_password" {
  description = "Contraseña de la BBDD"
  type = string
  sensitive = true
}
