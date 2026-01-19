# BEADS MEMORY PROTOCOL
type: always_on

You share a persistent memory graph with other agents via the `bd` CLI.
1. **NO MENTAL PLANS:** Do not create markdown checklists or "Implementation Plans".
2. **START:** At the start of every turn, run `bd ready` to see your assigned task.
3. **WORK:** If you find new sub-tasks, use `bd create "Title" --blocker <current_id>` to log them immediately.
4. **DONE:** Run `bd close <id>` only when the code is verified.
