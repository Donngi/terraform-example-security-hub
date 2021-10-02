module "security_hub" {
  source = "../../module/security_hub"
}

module "notification" {
  source                         = "../../module/notification"
  custom_action_send_to_chat_arn = module.security_hub.custom_action_send_to_chat_arn
}
