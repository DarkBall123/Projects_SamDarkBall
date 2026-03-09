#!/usr/bin/env bash
set -euo pipefail

IMAGE_TO_PAA_PATH="${1:-${IMAGE_TO_PAA:-}}"

if [[ -z "${IMAGE_TO_PAA_PATH}" ]]; then
  echo "Usage: IMAGE_TO_PAA=/path/to/ImageToPAA.exe ./db_raycastui/tools/build_paa.sh"
  exit 1
fi

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

convert_file() {
  local input_path="$1"
  local output_path="$2"
  mkdir -p "$(dirname "$output_path")"
  "${IMAGE_TO_PAA_PATH}" "$input_path" "$output_path"
}

for wall in brick tech stone; do
  convert_file \
    "${ROOT_DIR}/data/walls/${wall}/${wall}.png" \
    "${ROOT_DIR}/data/walls/${wall}/${wall}.paa"

  while IFS= read -r slice_path; do
    slice_name="$(basename "${slice_path%.png}")"
    convert_file \
      "$slice_path" \
      "${ROOT_DIR}/data/walls/${wall}/jpg/${slice_name}.paa"
  done < <(find "${ROOT_DIR}/data/walls/${wall}/jpg" -name 'slice_*.png' | sort)
done

convert_file \
  "${ROOT_DIR}/data/ui/weapon/blaster.png" \
  "${ROOT_DIR}/data/ui/weapon/blaster.paa"

convert_file \
  "${ROOT_DIR}/data/ui/weapon/blaster_fire.png" \
  "${ROOT_DIR}/data/ui/weapon/blaster_fire.paa"

convert_file \
  "${ROOT_DIR}/data/ui/weapon/shotgun.png" \
  "${ROOT_DIR}/data/ui/weapon/shotgun.paa"

convert_file \
  "${ROOT_DIR}/data/ui/weapon/shotgun_fire.png" \
  "${ROOT_DIR}/data/ui/weapon/shotgun_fire.paa"

convert_file \
  "${ROOT_DIR}/data/ui/weapon/shotgun_reload.png" \
  "${ROOT_DIR}/data/ui/weapon/shotgun_reload.paa"

convert_file \
  "${ROOT_DIR}/data/ui/logo/doomcard.png" \
  "${ROOT_DIR}/data/ui/logo/doomcard.paa"

convert_file \
  "${ROOT_DIR}/data/ui/status/statusbar.png" \
  "${ROOT_DIR}/data/ui/status/statusbar.paa"

convert_file \
  "${ROOT_DIR}/data/ui/status/face_idle.png" \
  "${ROOT_DIR}/data/ui/status/face_idle.paa"

convert_file \
  "${ROOT_DIR}/data/ui/status/face_alert.png" \
  "${ROOT_DIR}/data/ui/status/face_alert.paa"

convert_file \
  "${ROOT_DIR}/data/ui/status/face_hurt.png" \
  "${ROOT_DIR}/data/ui/status/face_hurt.paa"

convert_file \
  "${ROOT_DIR}/data/ui/status/face_dead.png" \
  "${ROOT_DIR}/data/ui/status/face_dead.paa"

convert_file \
  "${ROOT_DIR}/data/sprites/enemies/imp_idle.png" \
  "${ROOT_DIR}/data/sprites/enemies/imp_idle.paa"

convert_file \
  "${ROOT_DIR}/data/sprites/enemies/imp_attack.png" \
  "${ROOT_DIR}/data/sprites/enemies/imp_attack.paa"

convert_file \
  "${ROOT_DIR}/data/sprites/enemies/imp_hurt.png" \
  "${ROOT_DIR}/data/sprites/enemies/imp_hurt.paa"

convert_file \
  "${ROOT_DIR}/data/sprites/pickups/exit_portal.png" \
  "${ROOT_DIR}/data/sprites/pickups/exit_portal.paa"

convert_file \
  "${ROOT_DIR}/data/sprites/projectiles/fireball_0.png" \
  "${ROOT_DIR}/data/sprites/projectiles/fireball_0.paa"

convert_file \
  "${ROOT_DIR}/data/sprites/projectiles/fireball_1.png" \
  "${ROOT_DIR}/data/sprites/projectiles/fireball_1.paa"

convert_file \
  "${ROOT_DIR}/data/sprites/projectiles/fireball_2.png" \
  "${ROOT_DIR}/data/sprites/projectiles/fireball_2.paa"
