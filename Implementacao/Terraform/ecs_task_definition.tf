# Simply specify the family to find the latest ACTIVE revision in that family.
data "aws_ecs_task_definition" "mongo" {
  task_definition = "${aws_ecs_task_definition.mongo.family}"
}

resource "aws_ecs_cluster" "foo" {
  name = "foo"
}

resource "aws_ecs_task_definition" "wikibot" {
  family = "wikibot"

  container_definitions = <<DEFINITION
[
  {
    "cpu": 128,
    "environment": [{
      "name": "SECRET",
      "value": "KEY"
    }],
    "essential": true,
    "image": "wikibot:latest",
    "memory": 128,
    "memoryReservation": 64,
    "name": "wikibot"
  }
]
DEFINITION
}

resource "aws_ecs_service" "wikibot" {
  name          = "wikibot"
  cluster       = "${aws_ecs_cluster.wikibot.id}"
  desired_count = 2

  # Track the latest ACTIVE revision
  task_definition = "${aws_ecs_task_definition.wikibot.family}:${max("${aws_ecs_task_definition.wikibot.revision}", "${data.aws_ecs_task_definition.wikibot.revision}")}"
}