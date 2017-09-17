output "ids" { value = ["${aws_subnet.private.*.id}"] }
