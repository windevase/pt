resource "aws_key_pair" "hjko_key" {
    key_name = "hjko-key"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQClBDzRw6OZ5405QxqsEF9ZEiZen+Ya3EhrDB49Gj2+H2G76Aptj4PiKbQIydernOsV0yXvdpLmnVJ+ltSupOvHlWZ83Nb17oxgZaMhEq1dCgmjPC7c5X5jUbfW40U3K4p82V18ICgKNuniwvBJgloO/qHb4JBLd4pSS+fP73uHUIYTkj4TMJgn8nIZIoCsFOZgueKr6P6gp0F7sEzaE3Ir9fHHHJReVNYI+0oZpy4LieelwJtFVeUlk7DUitocmo/maeZTYxVFoFG72M0qT2Ad4WAlfktYCjOH0NYSpOvoLtRUIKRP83SqJO0SsavHl/KRsDQrrFBTW4fp6QNlBLjelVQhytObheUA3GAYjMVeoSVZaxovtQvEJVo3pwIBJ+axrZlA6z2SQNKnlzBuX9UrdNWKMKcSgNMSYD9uLI9r54c6zhOMO29SUlsVN1+cfT/t04U5FSlfXO+xufVHUNzSCdRGWjSEgR31w7bkJq14EEWZpMCqOvoDczBBDk4J+2E="
}

/* resource "aws_key_pair" "hjko_key" {
    key_name = "hjko-key"
    public_key = "ssh-rsa "  
} */