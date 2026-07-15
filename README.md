# claude-skills

[Claude Code](https://claude.com/claude-code) 스킬을 버전 관리하는 저장소.

각 스킬은 최상위 디렉토리 하나(`<skill-name>/SKILL.md`)로 구성된다.

## 스킬 목록

- [`ai-tdd`](ai-tdd/SKILL.md) — AI와 사람이 페어로 진행하는 TDD 협업 워크플로우.

## 설치 (다른 PC 포함)

저장소를 클론하고 설치 스크립트를 실행하면, 모든 스킬이 `~/.claude/skills/`로 심링크된다:

```sh
git clone https://github.com/verus-j/claude-skills.git
cd claude-skills
./install.sh
```

- 저장소가 **단일 진실 공급원**이다. 이후 `git pull` 한 번이면 그 PC의 모든 스킬이 갱신된다.
- 이미 같은 이름의 스킬이 있으면 건너뛴다. 덮어쓰려면 `./install.sh --force` (기존 항목은 `.bak.<타임스탬프>`로 백업).
- 설치 위치를 바꾸려면 `CLAUDE_SKILLS_DIR=/경로 ./install.sh`.

편집은 클론한 저장소에서 하면 심링크를 통해 Claude Code가 로드하는 스킬에 바로 반영된다. 변경 후 `git push`로 공유한다.
