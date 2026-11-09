# Testing the Course Pipeline

## Time Required

30 minutes

## Overview

In this lab, you will validate an automated course generation pipeline by inspecting repository execution artifacts, verifying slide Markdown against the HTML Slides Viewer contract, and enforcing platform quality gates.

### You learn how to:
- Inspect pipeline session state, chapter completion logs, and git version history.
- Verify slide Markdown files against the HTML Slides Viewer syntax contract.
- Validate quality gates for layout variety, typography, and code fences.
- Create an automated verification script to detect course pipeline violations.

## Scenario

Your team relies on an automated course generation pipeline to draft slide decks, review reports, and hands-on exercises from a course brief. Before publishing these materials to instructors and students, you must verify that all pipeline artifacts exist, state files reflect clean execution, and generated slide decks strictly adhere to viewer formatting rules and quality gates.

## Lab Instructions

### Task 1: Inspect pipeline execution state and repository artifacts

In this task, you inspect the course repository to confirm that session state is recorded, chapter completion logs are up to date, and the planning blueprint matches course requirements.

1. Open your terminal in the root directory of the course repository.

2. Display the pipeline session metadata stored in `.course-factory.json`:

```bash
cat .course-factory.json
```

> [!NOTE]
> The `.course-factory.json` file records the repository URL, creation metadata, and execution run identifier used across isolated agent sessions.

3. Inspect the chapter completion log to verify which chapters have completed generation:

```bash
cat .course-factory/chapters-done.txt
```

4. Confirm that both `course/01-pipeline-fundamentals.md` and `course/02-pipeline-execution-and-verification.md` appear in the completion log.

5. Inspect the approved course outline in `plan/course-outline.md`:

```bash
head -n 25 plan/course-outline.md
```

6. Verify that the outline specifies the course title, audience, prerequisites, and learning objectives before any chapter files were drafted.

7. Review recent git commits to confirm that each pipeline stage made atomic commits:

```bash
git log --oneline -n 5
```

### Task 2: Validate slide syntax against the viewer contract

In this task, you validate generated slide files against the HTML Slides Viewer rules, checking metadata headers, slide separators, layout directives, alert callouts, and code fences.

1. Check the required metadata comments at the beginning of each slide deck:

```bash
head -n 3 course/01-pipeline-fundamentals.md course/02-pipeline-execution-and-verification.md
```

2. Confirm that each file begins with both `<!-- course-title: … -->` and `<!-- course-theme: … -->` comments.

3. Verify that slide separators consist of exactly three hyphens on their own isolated lines:

```bash
grep -n "^---" course/01-pipeline-fundamentals.md | head -n 10
```

> [!IMPORTANT]
> A slide separator must not contain trailing text, spaces, or comments. Malformed separators break slide parsing in the presentation viewer.

4. Check the layout directives used across Chapter 1 and Chapter 2:

```bash
grep -E "<!-- layout:" course/01-pipeline-fundamentals.md course/02-pipeline-execution-and-verification.md
```

5. Confirm that all directives reference supported viewer layouts, such as `title`, `navigation`, `2-column`, `3-column`, `card-layout`, `panel-left`, or `panel-right`.

6. Search for alert callouts in the slide decks and verify their syntax:

```bash
grep -E "^> \[!" course/01-pipeline-fundamentals.md course/02-pipeline-execution-and-verification.md
```

7. Confirm that every alert block uses one of the five supported tags: `NOTE`, `TIP`, `IMPORTANT`, `WARNING`, or `CAUTION`.

8. Search for any fenced code blocks that lack an explicit language identifier:

```bash
grep -n '^```[[:space:]]*$' course/*.md || echo "All code blocks have language tags."
```

### Task 3: Enforce platform quality gates

In this task, you test the generated course files against platform quality gates, checking slide layout variety, typography standards, and content depth.

1. Verify layout variety by scanning Chapter 1 for consecutive slides that lack a layout directive:

```bash
grep -n -E "^(# |<!-- layout:)" course/01-pipeline-fundamentals.md
```

> [!NOTE]
> Platform quality gates permit a maximum of three consecutive default layout slides. Frequent layout changes maintain visual engagement and reduce cognitive fatigue.

2. Search for prohibited ampersand characters across all course slide decks:

```bash
grep -n '&' course/*.md || echo "No prohibited ampersand characters found."
```

> [!WARNING]
> Do not use raw ampersand characters in slide or lab prose and titles. Spell out the word “and” to conform to house typography guidelines.

3. Verify that directional smart quotes appear in prose and straight quotes appear inside code fences.

4. Inspect the review reports directory to confirm quality gate findings are documented:

```bash
ls -la reviews/
```

### Bonus Task 4: Build a pipeline validation script

With fewer step-by-step hints, automate these verification checks using an executable shell script that can run before publishing course updates.

1. Copy the starter script template to your repository scripts directory:

```bash
cp starter/verify-course.sh scripts/verify-course.sh
chmod +x scripts/verify-course.sh
```

2. Open `scripts/verify-course.sh` in your editor and complete the verification checks for:
   - Fenced code blocks without language tags
   - Prohibited ampersand characters
   - Unsupported alert callout tags
   - Required course metadata comments

3. Run your completed verification script against the course repository:

```bash
./scripts/verify-course.sh
```

4. Confirm that all checks report passing status without errors.

> [!TIP]
> You can compare your implementation with the reference solution in `solution/verify-course.sh`.

## Congratulations!

In this lab, you have:
- Inspected pipeline session state, chapter completion logs, and git version history.
- Verified slide Markdown files against the HTML Slides Viewer syntax contract.
- Validated quality gates for layout variety, typography, and code fences.
- Created an automated verification script to detect course pipeline violations.
