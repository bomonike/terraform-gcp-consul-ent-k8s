#!/bin/bash
# Copyright © 2014-2022 HashiCorp, Inc.
#
# This Source Code is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this project, you can obtain one at http://mozilla.org/MPL/2.0/.
#

set -e

cd "$(dirname "$0")"

echo "Running Terraform destroy on each module directory in reverse order..."
for i in $(find ./ -iname '0*' -type d -maxdepth 1 | sort -r); do
  cd $i && terraform apply -destroy -auto-approve && rm *.auto.tfvars && cd ..;
done
