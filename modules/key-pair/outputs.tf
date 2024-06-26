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

output "private_key_pem" {
  description = "Private key data PEM (RFC 1421)"
  value       = try(nonsensitive(tls_private_key.this[0].private_key_pem), null)
}
