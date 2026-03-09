#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

required_paths=(
  "${ROOT_DIR}/data/ui/logo/doomcard.paa"
  "${ROOT_DIR}/data/ui/status/statusbar.paa"
  "${ROOT_DIR}/data/ui/status/face_idle.paa"
  "${ROOT_DIR}/data/ui/status/face_alert.paa"
  "${ROOT_DIR}/data/ui/status/face_hurt.paa"
  "${ROOT_DIR}/data/ui/status/face_dead.paa"
  "${ROOT_DIR}/data/ui/weapon/blaster.paa"
  "${ROOT_DIR}/data/ui/weapon/blaster_fire.paa"
  "${ROOT_DIR}/data/ui/weapon/shotgun.paa"
  "${ROOT_DIR}/data/ui/weapon/shotgun_fire.paa"
  "${ROOT_DIR}/data/ui/weapon/shotgun_reload.paa"
  "${ROOT_DIR}/data/sprites/enemies/imp_idle.paa"
  "${ROOT_DIR}/data/sprites/enemies/imp_attack.paa"
  "${ROOT_DIR}/data/sprites/enemies/imp_hurt.paa"
  "${ROOT_DIR}/data/sprites/pickups/exit_portal.paa"
  "${ROOT_DIR}/data/sprites/projectiles/fireball_0.paa"
  "${ROOT_DIR}/data/sprites/projectiles/fireball_1.paa"
  "${ROOT_DIR}/data/sprites/projectiles/fireball_2.paa"
  "${ROOT_DIR}/data/walls/brick/brick.paa"
  "${ROOT_DIR}/data/walls/stone/stone.paa"
  "${ROOT_DIR}/data/walls/tech/tech.paa"
)

for wall in brick stone tech; do
  for index in $(seq -w 0 63); do
    required_paths+=("${ROOT_DIR}/data/walls/${wall}/jpg/slice_${index}.paa")
  done
done

missing=0
for path in "${required_paths[@]}"; do
  if [[ ! -f "${path}" ]]; then
    echo "Missing .paa asset: ${path#${ROOT_DIR}/}"
    missing=1
  fi
done

if [[ "${missing}" -ne 0 ]]; then
  exit 1
fi

echo "DB Raycast UI .paa asset set looks complete."
