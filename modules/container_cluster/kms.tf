resource "google_kms_key_ring" "this" {
  count = var.kms_key_ring_enabled ? 1 : 0

  name     = "kubernetes-etcd"
  location = var.kms_location
}

resource "google_kms_crypto_key" "this" {
  count = var.kms_key_ring_enabled ? 1 : 0

  name            = "kubernetes-etcd-key"
  key_ring        = google_kms_key_ring.this[0].id
  rotation_period = "100000s"

  lifecycle {
    prevent_destroy = true
  }
}
