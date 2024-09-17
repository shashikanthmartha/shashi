output "elb_web" {
  value = aws_elb.web_elb.id
}
output "web_elb_dns" {
  value = aws_elb.web_elb.dns_name
}