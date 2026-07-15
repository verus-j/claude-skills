# claude-skills

[Claude Code](https://claude.com/claude-code) 스킬을 버전 관리하는 저장소.

각 스킬은 최상위 디렉토리 하나(`<skill-name>/SKILL.md`)로 구성된다.

## 스킬 목록

- [`ai-tdd`](ai-tdd/SKILL.md) — AI와 사람이 페어로 진행하는 TDD 협업 워크플로우.

## 설치 (심링크)

이 저장소를 단일 진실 공급원으로 두고, 각 스킬을 `~/.claude/skills/`로 심링크한다:

```sh
ln -s "$PWD/ai-tdd" ~/.claude/skills/ai-tdd
```

저장소에서 편집하면 Claude Code가 로드하는 스킬에 바로 반영된다.
