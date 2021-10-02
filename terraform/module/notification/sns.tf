resource "aws_sns_topic" "chat_bot" {
  name = "send-security-hub-events-to-chat-bot"
}

resource "aws_sns_topic_policy" "chat_bot" {
  arn = aws_sns_topic.chat_bot.arn

  policy = jsonencode({
    "Version" : "2008-10-17",
    "Id" : "__default_policy_ID",
    "Statement" : [
      {
        "Sid" : "__default_statement_ID",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "*"
        },
        "Action" : [
          "SNS:Publish",
          "SNS:RemovePermission",
          "SNS:SetTopicAttributes",
          "SNS:DeleteTopic",
          "SNS:ListSubscriptionsByTopic",
          "SNS:GetTopicAttributes",
          "SNS:Receive",
          "SNS:AddPermission",
          "SNS:Subscribe"
        ],
        "Resource" : aws_sns_topic.chat_bot.arn,
        "Condition" : {
          "StringEquals" : {
            "AWS:SourceOwner" : "${data.aws_caller_identity.current.account_id}"
          }
        }
      },
      {
        "Sid" : "AllowAccessFromEventBridge",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "events.amazonaws.com"
        },
        "Action" : "sns:Publish",
        "Resource" : aws_sns_topic.chat_bot.arn
      }
    ]
  })
}
