resource "aws_efs_file_system" "ga_efs" {
  creation_token  = "ga-efs-${var.BRANCH_NAME}"
  encrypted       = true
  throughput_mode = "elastic"
  tags = {
    Name = "ga-efs-${var.BRANCH_NAME}"
  }
}

resource "aws_efs_mount_target" "ga_efs_mount_target_1" {
  file_system_id  = aws_efs_file_system.ga_efs.id
  security_groups = [data.aws_security_group.app.id]           
  subnet_id       = element(data.aws_subnets.app.ids, 1)
}

resource "aws_efs_mount_target" "ga_efs_mount_target_2" {
  file_system_id  = aws_efs_file_system.ga_efs.id
  security_groups = [data.aws_security_group.app.id]
  subnet_id       = element(data.aws_subnets.app.ids, 2)
}

resource "aws_efs_access_point" "ga_ap" {
  for_each = tomap({
    sharedconfig  = "sharedconfig"
    userdata      = "userdata"
    upgrader1     = "upgrader1"
    config1       = "config1"
    tomcatserver1 = "tomcatserver1"
    tomcatlog1    = "tomcatlog1"
    ghttpsroot1   = "ghttpsroot1"
    upgrader2     = "upgrader2"
    config2       = "config2"
    tomcatserver2 = "tomcatserver2"
    tomcatlog2    = "tomcatlog2"
    ghttpsroot2   = "ghttpsroot2"
  })
  file_system_id  = aws_efs_file_system.ga_efs.id
  posix_user {
    gid = 992
    uid = 994
  }
  root_directory {
    creation_info {
      owner_gid   = 992
      owner_uid   = 994
      permissions = 777
    }
    path = "/${each.value}"
  }
  tags = {
    Name = "${each.value}-${var.BRANCH_NAME}"
  }
}