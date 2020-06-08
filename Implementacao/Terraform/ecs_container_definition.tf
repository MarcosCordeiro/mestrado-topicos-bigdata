data "aws_ecs_container_definition" "ecs-wikibot" {
  task_definition = "${aws_ecs_task_definition.wikibot.id}"
  container_name  = "wikibot"
}