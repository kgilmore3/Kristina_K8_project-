resource "aws_iam_role_policy" "ec2_policy" {
  name = "ec2_policy1"
  role = aws_iam_role.ec2_role.id

  policy = "${file("~/Desktop/MyProjects/Kristina_K8_project_2/modules/ec2_iam/ec2-policy.json")}"
  
}

resource "aws_iam_role" "ec2_role" {
  name = "ec2_role1"

  assume_role_policy = "${file("~/Desktop/MyProjects/Kristina_K8_project_2/modules/ec2_iam/ec2-assume.json")}"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile1"
  role = aws_iam_role.ec2_role.name
}