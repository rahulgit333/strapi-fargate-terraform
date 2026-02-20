resource "aws_ecs_task_definition" "strapi" {
  family                   = "strapi-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "512"
  memory                   = "1024"
  execution_role_arn       = aws_iam_role.ecs_execution.arn

  container_definitions = jsonencode([
    {
      name  = "strapi"
      image = "${aws_ecr_repository.strapi.repository_url}:latest"

      portMappings = [
        {
          containerPort = 1337
        }
      ]

      # ✅ ENV VARIABLE ADDED
      environment = [
        {
          name  = "NODE_ENV"
          value = "production"
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.strapi.name
          awslogs-region        = var.region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}
