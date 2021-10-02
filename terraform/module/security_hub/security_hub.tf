resource "aws_securityhub_account" "main" {}

resource "aws_securityhub_action_target" "send_to_chat" {
  depends_on  = [aws_securityhub_account.main]
  name        = "Send to chat"
  identifier  = "SendToChat"
  description = "Custom action sends selected findings to chat"
}
