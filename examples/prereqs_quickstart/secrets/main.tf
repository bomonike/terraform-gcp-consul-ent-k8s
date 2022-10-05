/**
 * Copyright © 2014-2022 HashiCorp, Inc.
 *
 * This Source Code is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this project, you can obtain one at http://mozilla.org/MPL/2.0/.
 *
 */

resource "random_id" "secret" {
  byte_length = 4
}

resource "google_secret_manager_secret" "federation" {
  secret_id = "${var.federation_secret_id}-${random_id.secret.hex}"

  replication {
    automatic = true
  }
}
