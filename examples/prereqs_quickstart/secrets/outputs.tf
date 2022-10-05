/**
 * Copyright © 2014-2022 HashiCorp, Inc.
 *
 * This Source Code is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this project, you can obtain one at http://mozilla.org/MPL/2.0/.
 *
 */

output "federation_secret_id" {
  value       = google_secret_manager_secret.federation.id
  description = "Secret id/name given to the Google Secret Manager secret for the Consul federation secret"
}
