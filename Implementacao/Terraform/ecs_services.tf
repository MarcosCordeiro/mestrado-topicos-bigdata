data "aws_ecs_service" "wikibot_services" {
  service_name = "wikibot"
  cluster_arn  = "${data.aws_ecs_cluster.wikibot.arn}"
}