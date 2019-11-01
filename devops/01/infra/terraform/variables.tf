variable "public_key" {
    default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC/7GyZz74zideAqkoaJu/+9k734l2KYvVyugzO/lmhMo5y93synWnRQySrl5I90ZCluXkbgTrmUetITrF2SdCaadcPXvr+DzKVm8Jposi2xHUV4dlgLxvMyCWzTkzFQX+Z4xxfYNhu4EPKkiv6rOL7JWGJj18p2bcwfl6eEg5sLBH0B4WbBC+z87/I3mPTJLMB0Kcclky1QfaLy3YCWqYP1PddyYDcc+O0tje8byBlM+HoNKq4+Me8ppbtI5R+eJxxWbyguSIAqeucTwSUakmCPhcxNzh+nEqc+HFTdg1kxjpWNqhYd34lbsDnAN9jfilTa8c81B8stQvHmIeqAsOp herculesaleixo@aces"
}

variable "sg_ingress_ports" {
  default = ["22", "6443", "2379", "2380", "10250", "10251", "10252"]
}
