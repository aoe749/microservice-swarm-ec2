# resource "aws_route53_zone" "swarm" {
#   name = "swarm.local"
#
#   vpc {
#     vpc_id = aws_vpc.swarm.id
#   }
#   lifecycle {
#     ignore_changes = [vpc]
#   }
# }
#
# resource "aws_route53_record" "master" {
#   zone_id = aws_route53_zone.swarm.id
#   name    = "master"
#   type    = "A"
#   ttl     = "300"
#   records = [aws_instance.master.private_ip]
# }
#
# resource "aws_route53_record" "manager1" {
#   zone_id = aws_route53_zone.swarm.id
#   name    = "manager1"
#   type    = "A"
#   ttl     = "300"
#   records = [aws_instance.manager1.private_ip]
# }
#
# resource "aws_route53_record" "manager2" {
#   zone_id = aws_route53_zone.swarm.id
#   name    = "manager2"
#   type    = "A"
#   ttl     = "300"
#   records = [aws_instance.manager2.private_ip]
# }
#
# resource "aws_route53_record" "worker" {
#   zone_id = aws_route53_zone.swarm.id
#   count   = length(local.worker)
#   name    = "worker-${count.index + 1}"
#   type    = "A"
#   ttl     = "300"
#   records = [local.worker[count.index]]
# }
