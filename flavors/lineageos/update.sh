#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2020 Daniel Fullmer and robotnix contributors
# SPDX-License-Identifier: MIT

set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")"

branch=$1

args=(
    --cache-search-path ../../
    --ref-type branch
    "https://github.com/LineageOS/android"
    "$branch"
)

export TMPDIR=/tmp

# TODO: Uncomment when updating to lineage-20
# ./update_device_metadata.py
../../scripts/mk_repo_file.py --jobs 4 --out "${branch}/repo.json" "${args[@]}"
./update_device_dirs.py --branch "$branch" oneplus_instantnoodlep
./update_device_dirs.py --branch "$branch" oneplus_dumpling

echo Updated branch "$branch". End epoch: "$(date +%s)"
