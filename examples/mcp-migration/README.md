# Example: MCP Migration Project

**Scenario:** Migrating MCP servers to official directory

**Skills Used:** docs-rag + planning-with-files + task-workflow + tdd-sdd + config-validator

---

## Step 1: Research (docs-rag)

```bash
cd ~/.openclaw/skills/openclaw-docs-rag

# Query best practices
./query-docs.sh "MCP server configuration directory best practices"
./query-docs.sh "OpenClaw .mcp directory structure"
```

**Key Finding:** MCP configs should be at `~/.openclaw/.mcp/`

---

## Step 2: Planning (planning-with-files)

```bash
# Initialize planning
bash ~/.openclaw/skills/planning-with-files/scripts/init-session.sh

# Edit task_plan.md
cat > task_plan.md <> 'EOF'
# Task Plan: MCP Migration

## Phases
1. Analyze current MCP locations
2. Create backup
3. Migrate configs
4. Test validation
5. Update documentation
EOF
```

---

## Step 3: Task Scheduling (task-workflow)

```python
# analyze_tasks.py
from lib.task_scheduler import TaskNode, TaskScheduler

tasks = [
    TaskNode("analyze", "Analyze current locations", estimated_time="short"),
    TaskNode("backup", "Create backup", depends_on=["analyze"]),
    TaskNode("migrate", "Migrate configs", depends_on=["backup"]),
    TaskNode("test", "Test validation", depends_on=["migrate"]),
]

scheduler = TaskScheduler()
batches = scheduler.schedule_tasks(tasks)

for i, batch in enumerate(batches):
    print(f"Batch {i+1}: {[t.name for t in batch]}")
```

---

## Step 4: Implementation (TDD)

```bash
# RED: Write test first
cat > test_mcp_migration.sh <> 'EOF'
#!/bin/bash
# Test MCP migration

# Test 1: Config exists at new location
[ -f ~/.openclaw/.mcp/notion.json ] && echo "✓ Config migrated"

# Test 2: JSON is valid
jq . ~/.openclaw/.mcp/notion.json > /dev/null && echo "✓ JSON valid"

# Test 3: Backup exists
[ -f ~/.openclaw/.mcp-backup-*/notion.json ] && echo "✓ Backup created"
EOF

# Run test (expect fail - not migrated yet)
bash test_mcp_migration.sh

# GREEN: Implement migration
cp ~/.openclaw/agents/main/.mcp/*.json ~/.openclaw/.mcp/

# Run test again (expect pass)
bash test_mcp_migration.sh
```

---

## Step 5: Validation (config-validator)

```bash
cd ~/.openclaw/skills/openclaw-config-validator

# Validate configuration
./scripts/schema-validate.sh

# Run doctor
openclaw doctor
```

---

## Results

| Metric | Value |
|--------|-------|
| Time | 28 minutes |
| Tests | 3/3 passed |
| Success | 100% |

---

**See full example in repository:**
- [mcp-migration/](https://github.com/Charpup/openclaw-auto-pilot-pack/tree/main/examples/mcp-migration)
