resource "aws_cloudwatch_dashboard" "ecs_dashboard" {
  dashboard_name = "Strapi-ECS-Dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric",
        properties = {
          metrics = [
            ["AWS/ECS","CPUUtilization","ClusterName","strapi-cluster","ServiceName","strapi-service"]
          ],
          period = 300,
          stat = "Average",
          region = var.region,
          title = "CPU Utilization"
        }
      },
      {
        type = "metric",
        properties = {
          metrics = [
            ["AWS/ECS","MemoryUtilization","ClusterName","strapi-cluster","ServiceName","strapi-service"]
          ],
          period = 300,
          stat = "Average",
          region = var.region,
          title = "Memory Utilization"
        }
      },
      {
        type = "metric",
        properties = {
          metrics = [
            ["AWS/ECS","RunningTaskCount","ClusterName","strapi-cluster","ServiceName","strapi-service"]
          ],
          period = 300,
          stat = "Average",
          region = var.region,
          title = "Task Count"
        }
      },
      {
        type = "metric",
        properties = {
          metrics = [
            ["AWS/ECS","NetworkIn","ClusterName","strapi-cluster","ServiceName","strapi-service"],
            [".","NetworkOut",".",".",".","."]
          ],
          period = 300,
          stat = "Sum",
          region = var.region,
          title = "Network In / Out"
        }
      }
    ]
  })
}
