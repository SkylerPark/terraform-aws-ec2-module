output "id" {
  description = "key pair ID"
  value       = aws_key_pair.this.id
}

output "name" {
  description = "key pair name"
  value       = aws_key_pair.this.key_name
}

output "public_key" {
  description = "key pair public key"
  value       = aws_key_pair.this.public_key
}
