#!/usr/bin/env bash
#
# claude-skills 설치 스크립트
#
# 이 저장소의 각 스킬 디렉토리(<name>/SKILL.md)를 ~/.claude/skills/ 로 심링크한다.
# 저장소가 단일 진실 공급원이 되고, git pull 하면 모든 PC의 스킬이 갱신된다.
#
# 사용법:
#   ./install.sh            # 모든 스킬 설치
#   ./install.sh --force    # 기존 파일/디렉토리가 있어도 백업 후 덮어씀
#
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_DIR="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"
FORCE=0
[[ "${1:-}" == "--force" ]] && FORCE=1

mkdir -p "$SKILLS_DIR"

installed=0
skipped=0

for skill_md in "$REPO_DIR"/*/SKILL.md; do
  [[ -e "$skill_md" ]] || { echo "설치할 스킬이 없습니다 (SKILL.md 없음)."; exit 0; }
  src="$(dirname "$skill_md")"
  name="$(basename "$src")"
  dest="$SKILLS_DIR/$name"

  # 이미 이 저장소를 가리키는 심링크면 스킵
  if [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]; then
    echo "✓ $name — 이미 설치됨"
    skipped=$((skipped+1))
    continue
  fi

  # 다른 무언가가 이미 존재하는 경우
  if [[ -e "$dest" || -L "$dest" ]]; then
    if [[ "$FORCE" == "1" ]]; then
      backup="$dest.bak.$(date +%Y%m%d%H%M%S)"
      mv "$dest" "$backup"
      echo "↷ $name — 기존 항목을 $backup 으로 백업"
    else
      echo "⚠ $name — 이미 존재함 (심링크 아님). --force 로 덮어쓰거나 직접 정리하세요. 건너뜀"
      skipped=$((skipped+1))
      continue
    fi
  fi

  ln -s "$src" "$dest"
  echo "✓ $name — 설치됨 ($dest -> $src)"
  installed=$((installed+1))
done

echo
echo "완료: 설치 $installed, 건너뜀 $skipped"
echo "스킬 위치: $SKILLS_DIR"
