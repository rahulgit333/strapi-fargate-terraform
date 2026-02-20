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
          protocol      = "tcp"
        }
      ]

      environment = [
        {
          name  = "NODE_ENV"
          value = "production"
        },
        {
          name  = "HOST"
          value = "0.0.0.0"
        },
        {
          name  = "PORT"
          value = "1337"
        },
        {
          name  = "APP_KEYS"
          value = "4av3q0DH1wxv7s7MHBhm+IgjLpvarB7cW+ciHfsREmo=,5+pBSG0CM0GUYpi1jf1GkDmGBhaKkYp4f9WP1A6zTSw="
        },
        {
          name  = "API_TOKEN_SALT"
          value = "GrIzdHmoKbYRzFmDv/Mr80MgZRgLn6Raxm1F8coubPE="
        },
        {
          name  = "ADMIN_JWT_SECRET"
          value = "TmDRvIM2gCHIWKhZaB+WPsrk7jsZUnrMvpicf/MxRsI="
        },
        {
          name  = "JWT_SECRET"
          value = "TmDRvIM2gCHIWKhZaB+WPsrk7jsZUnrMvpicf/MxRsI="
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

      essential = true
    }
  ])
}
