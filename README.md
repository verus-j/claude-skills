# claude-skills

[Claude Code](https://claude.com/claude-code) 스킬을 **플러그인 마켓플레이스**로 배포하는 저장소.

마켓플레이스 이름: `verus-skills`

## 스킬(플러그인) 목록

| 플러그인 | 설명 |
|----------|------|
| [`ai-tdd`](plugins/ai-tdd/skills/ai-tdd/SKILL.md) | AI와 사람이 페어로 진행하는 TDD 협업 워크플로우 |

## 설치 (다른 PC 포함)

Claude Code에서 마켓플레이스를 등록하고 원하는 플러그인을 설치한다:

```
/plugin marketplace add verus-j/claude-skills
/plugin install ai-tdd@verus-skills
```

설치 후 스킬은 플러그인 이름으로 네임스페이스된다 — 예: `/ai-tdd:ai-tdd`. Skill 자동 트리거도 동작한다.

- **자동 업데이트**: 이 저장소에 push하면 새 커밋이 새 버전으로 인식된다. 사용자는 `/plugin marketplace update`로 갱신한다.
- **제거**: `/plugin uninstall ai-tdd@verus-skills`
- CLI로도 가능: `claude plugin marketplace add verus-j/claude-skills`, `claude plugin install ai-tdd@verus-skills`.

## 저장소 구조

```
.claude-plugin/marketplace.json      # 마켓플레이스 카탈로그 (플러그인 목록)
plugins/<plugin>/
  .claude-plugin/plugin.json         # 플러그인 매니페스트
  skills/<skill>/SKILL.md            # 스킬 본문
```

## 새 스킬 추가

1. `plugins/<이름>/skills/<이름>/SKILL.md` 작성
2. `plugins/<이름>/.claude-plugin/plugin.json` 작성 (`name`, `description`)
3. `.claude-plugin/marketplace.json`의 `plugins` 배열에 항목 추가 (`name`, `source`, `description`)
4. `claude plugin validate .`로 검증 후 커밋·push

## 로컬 개발 (메인테이너)

저장소에서 직접 스킬을 편집하며 바로 테스트하려면 심링크를 건다:

```sh
ln -s "$PWD/plugins/ai-tdd/skills/ai-tdd" ~/.claude/skills/ai-tdd
```

이러면 편집이 즉시 반영된다. 단, 같은 머신에서 마켓플레이스로도 설치하면 스킬이 중복되니 한쪽만 사용한다.
