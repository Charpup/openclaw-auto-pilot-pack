# OpenClaw Auto-Pilot Skill Pack 🜁

**A curated collection of essential OpenClaw skills for auto-pilot development workflow.**

[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)](https://github.com/Charpup/openclaw-auto-pilot-pack)
[![OpenClaw](https://img.shields.io/badge/OpenClaw-2026.2.1+-green.svg)](https://openclaw.ai)

---

## 📦 What's Included

This skill pack contains **5 essential skills** that work seamlessly together to create a powerful auto-pilot development workflow:

| Skill | Version | Purpose | GitHub |
|-------|---------|---------|--------|
| **docs-rag** | 3.0.0 | Query OpenClaw official documentation using RAG | [View](https://github.com/Charpup/openclaw-docs-rag) |
| **task-workflow** | 3.1.0 | Intelligent task scheduling with dependency analysis | [View](https://github.com/Charpup/openclaw-task-workflow) |
| **planning-with-files** | 2.10.0 | Manus-style file-based planning system | [View](https://github.com/OthmanAdi/planning-with-files) |
| **tdd-sdd-development** | 1.1.0 | TDD+SDD dual-pyramid development workflow | [View](https://github.com/Charpup/openclaw-tdd-sdd-skill) |
| **config-validator** | 2.1.0 | Configuration validation with Research Workflow | [View](https://github.com/Charpup/openclaw-config-validator) |

---

## 🎯 The Auto-Pilot Pattern

```
Complex Task
    ↓
[docs-rag] Query best practices
    ↓
[planning-with-files] Create task plan
    ↓
[task-workflow] Analyze & schedule
    ↓
[tdd-sdd] Define specs & tests
    ↓
[subagent] Parallel execution
    ↓
[config-validator] Validate changes
    ↓
[github] Release
```

---

## 🚀 Quick Start

### Installation

```bash
# Clone the skill pack
git clone https://github.com/Charpup/openclaw-auto-pilot-pack.git

# Install all skills
cd openclaw-auto-pilot-pack
./install.sh

# Or install individual skills
cd skills/docs-rag && npm install
cd skills/task-workflow && pip install -r requirements.txt
# ... etc
```

### Verification

```bash
# Verify installation
openclaw doctor

# Check skill status
openclaw skills list
```

---

## 📖 Usage Guide

### 1. Research Phase (docs-rag)

```bash
# Query OpenClaw documentation
cd ~/.openclaw/skills/openclaw-docs-rag
./query-docs.sh "How to configure cron jobs"
```

**Best Practice:** Always query docs-rag before any complex task.

### 2. Planning Phase (planning-with-files)

```bash
# Initialize planning files
bash ~/.openclaw/skills/planning-with-files/scripts/init-session.sh

# Creates:
# - task_plan.md    (Phases & progress)
# - findings.md     (Research discoveries)
# - progress.md     (Session logs)
```

### 3. Task Analysis (task-workflow)

```python
from lib.task_scheduler import TaskNode, TaskScheduler

tasks = [
    TaskNode(
        id="research",
        name="Research phase",
        estimated_time="medium",
        tool_calls_estimate=5
    ),
    TaskNode(
        id="implement",
        name="Implementation",
        depends_on=["research"],
        estimated_time="long"
    )
]

scheduler = TaskScheduler()
batches = scheduler.schedule_tasks(tasks)
```

### 4. Spec Definition (tdd-sdd)

```yaml
# SPEC.yaml
interface: MyComponent
methods:
  - name: process
    signature: process(data) -> Result
scenarios:
  - name: valid input
    given: Valid data provided
    when: process() called
    then: Returns success
```

### 5. Config Validation (config-validator)

```bash
# Validate OpenClaw configuration
./scripts/schema-validate.sh

# Research before changes
./scripts/audit-proposal.sh --target-node gateway
```

---

## 📂 Directory Structure

```
openclaw-auto-pilot-pack/
├── skills/                     # Skill submodules
│   ├── docs-rag/
│   ├── task-workflow/
│   ├── planning-with-files/
│   ├── tdd-sdd-development/
│   └── config-validator/
├── docs/                       # Documentation
│   ├── architecture.md
│   ├── workflow-guide.md
│   └── troubleshooting.md
├── examples/                   # Example projects
│   ├── mcp-migration/
│   └── schema-sync/
├── templates/                  # Templates
│   ├── task-plan.md
│   ├── spec.yaml
│   └── progress.md
├── install.sh                  # Installation script
├── README.md                   # This file
└── LICENSE
```

---

## 💡 Use Cases

### Use Case 1: MCP Migration Project

**Scenario:** Migrating MCP servers to official directory

**Workflow:**
1. `docs-rag` - Query MCP configuration best practices
2. `planning-with-files` - Create migration plan
3. `task-workflow` - Schedule 6 migration tasks
4. `tdd-sdd` - Define validation tests
5. `config-validator` - Verify final config

**Result:** Successful migration with zero downtime

See: [examples/mcp-migration/](examples/mcp-migration/)

### Use Case 2: Schema Sync System

**Scenario:** Building automated schema sync between docs-rag and config-validator

**Workflow:**
1. `docs-rag` - Extract latest schema
2. `planning-with-files` - Design sync mechanism
3. `task-workflow` - Parallel subagent research
4. `tdd-sdd` - Test-driven implementation
5. `github` - Release v2.1.0

**Result:** 32/32 tests passed, 7.5x faster than estimated

See: [examples/schema-sync/](examples/schema-sync/)

---

## 🔧 Configuration

### Environment Variables

```bash
# docs-rag
export OPENAI_API_KEY="sk-..."
export MEMU_DB_PASSWORD="..."

# config-validator
export CONFIG_VALIDATOR_STRICT=true

# task-workflow
export TASK_WORKFLOW_MAX_BATCH=10
```

### OpenClaw Integration

Add to `~/.openclaw/openclaw.json`:

```json
{
  "skills": {
    "autoPilotPack": {
      "enabled": true,
      "path": "~/.openclaw/skills/openclaw-auto-pilot-pack"
    }
  }
}
```

---

## 🤝 Skill Dependencies

```
docs-rag (base)
    ↓
planning-with-files (uses docs-rag for research)
    ↓
task-workflow (uses planning-with-files for tracking)
    ↓
tdd-sdd (uses task-workflow for phases)
    ↓
config-validator (uses docs-rag for schema)
```

All skills can work independently but are optimized for combined use.

---

## 📊 Metrics from Real Usage

| Metric | Value |
|--------|-------|
| **Total Tasks Completed** | 19 |
| **Success Rate** | 100% (19/19) |
| **Average Efficiency** | 7.5x faster than estimates |
| **Test Pass Rate** | 100% (32/32) |
| **GitHub Releases** | 3 |

---

## 🛠️ Troubleshooting

### Issue: docs-rag query returns no results

**Solution:**
```bash
cd ~/.openclaw/skills/openclaw-docs-rag
npm run sync  # Sync documentation
```

### Issue: task-workflow shows no active tasks

**Solution:**
```bash
# Initialize daily file
python3 cli.py init-daily
```

### Issue: config-validator rejects valid config

**Solution:**
```bash
# Run with verbose mode
./scripts/schema-validate.sh --verbose
```

See [docs/troubleshooting.md](docs/troubleshooting.md) for more.

---

## 🤖 For OpenClaw Agents

This skill pack is designed **by agents, for agents**. It encodes:

- **Research-first approach** - Never assume, always verify
- **Structured planning** - Files over memory
- **Test-driven development** - Red, Green, Refactor
- **Continuous validation** - Every phase verified
- **Documentation sync** - Code and docs together

---

## 📜 License

MIT License - See [LICENSE](LICENSE) for details.

---

## 🙏 Credits

- **Galatea** 🜁 - Skill pack curator and primary developer
- **Charpup** - Project sponsor and use case provider
- **OpenClaw Team** - Platform and ecosystem

---

## 📮 Support

- **Discord:** #openclaw-auto-pilot-pack
- **Issues:** [GitHub Issues](https://github.com/Charpup/openclaw-auto-pilot-pack/issues)
- **Docs:** [Full Documentation](docs/)

---

**Ready to develop on auto-pilot?** 🚀

```bash
git clone https://github.com/Charpup/openclaw-auto-pilot-pack.git
./install.sh
# Start building!
```
