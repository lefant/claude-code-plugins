# Spec Create Command

Create a feature specification through interactive brainstorming.

Extra user prompt: $ARGUMENTS

## Usage

```
/spec_create [feature name or description]
```

## What it does

1. **Reference skill**: Load the `feature-specs` skill for conventions
2. **Clarify intent**: Ask questions to understand what we're really trying to do
3. **Explore alternatives**: Surface options the user might not have considered
4. **Draft in chunks**: Present Purpose, then Requirements, then Open Questions for validation
5. **Create directory**: Create `./docs/specs/` if it doesn't exist
6. **Write file**: Save approved spec to `./docs/specs/<feature>.md`

## Filename Convention

`<feature-name>.md` - lowercase, dash-separated

- **Examples**:
  - `/spec_create "user authentication"` → `user-authentication.md`
  - `/spec_create "CSV export"` → `csv-export.md`

## Template

Use the template from the `feature-specs` skill:
`lefant/skills/feature-specs/template.md`

## Interactive Flow

### Step 1: Clarify Intent

Ask 2-3 focused questions:
- "What problem does this solve for users?"
- "What's the minimal version that would be useful?"
- "Are there existing patterns in the codebase we should follow?"

### Step 2: Explore Alternatives

Before drafting, briefly consider:
- "Have you considered [alternative approach]?"
- "Some systems handle this by [different pattern]—would that work here?"

Keep this light—one or two alternatives max.

### Step 3: Draft in Chunks

Present each section for validation:

1. **Purpose**: "Here's what I understand the feature is about..."
2. **Requirements**: "These are the key behaviors I've identified..."
3. **Open Questions**: "Here are uncertainties we should track..."

Get approval or refinement on each before proceeding.

### Step 4: Save

Once approved, write to `./docs/specs/<feature>.md`

## Related Skill

For full conventions and guidelines, see:
```
/skill feature-specs
```
