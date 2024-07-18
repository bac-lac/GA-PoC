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

resource "aws_efs_access_point" "ga_ap_userdata" {
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
    path = "/userdata"
  }
  tags = {
    Name = "userdata-${var.BRANCH_NAME}"
  }
}

resource "aws_efs_access_point" "ga_ap_sharedconfig" {
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
    path = "/sharedconfig"
  }
  tags = {
    Name = "sharedconfig-${var.BRANCH_NAME}"
  }
}

resource "aws_efs_access_point" "ga_ap_upgrader1" {
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
    path = "/upgrader1"
  }
  tags = {
    Name = "upgrader1-${var.BRANCH_NAME}"
  }
}

resource "aws_efs_access_point" "ga_ap_config1" {
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
    path = "/config1"
  }
  tags = {
    Name = "config1-${var.BRANCH_NAME}"
  }
}

resource "aws_efs_access_point" "ga_ap_tomcatserver1" {
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
    path = "/tomcatserver1"
  }
  tags = {
    Name = "tomcatserver1-${var.BRANCH_NAME}"
  }
}

resource "aws_efs_access_point" "ga_ap_tomcatlog1" {
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
    path = "/tomcatlog1"
  }
  tags = {
    Name = "tomcatlog1-${var.BRANCH_NAME}"
  }
}

resource "aws_efs_access_point" "ga_ap_ghttpsroot1" {
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
    path = "/ghttpsroot1"
  }
  tags = {
    Name = "ghttpsrootoot1-${var.BRANCH_NAME}"
  }
}

resource "aws_efs_access_point" "ga_ap_upgrader2" {
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
    path = "/upgrader2"
  }
  tags = {
    Name = "upgrader2-${var.BRANCH_NAME}"
  }
}

resource "aws_efs_access_point" "ga_ap_config2" {
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
    path = "/config2"
  }
  tags = {
    Name = "config2-${var.BRANCH_NAME}"
  }
}

resource "aws_efs_access_point" "ga_ap_tomcatserver2" {
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
    path = "/tomcatserver2"
  }
  tags = {
    Name = "tomcatserver2-${var.BRANCH_NAME}"
  }
}

resource "aws_efs_access_point" "ga_ap_tomcatlog2" {
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
    path = "/tomcatlog2"
  }
  tags = {
    Name = "tomcatlog2-${var.BRANCH_NAME}"
  }
}

resource "aws_efs_access_point" "ga_ap_ghttpsroot2" {
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
    path = "/ghttpsroot2"
  }
  tags = {
    Name = "ghttpsrootoot2-${var.BRANCH_NAME}"
  }
}

resource "aws_efs_access_point" "ga_ap_test" {
  for_each = tomap({
    testa   = "eastus"
    testb   = "westus2"
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