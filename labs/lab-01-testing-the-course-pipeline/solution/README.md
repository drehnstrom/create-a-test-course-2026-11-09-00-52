# Solution: Testing the Course Pipeline

## End State

- Verified pipeline tracking files:
  - `.course-factory.json` containing valid repository configuration and run identifiers
  - `.course-factory/chapters-done.txt` recording completed chapter files
  - `plan/course-outline.md` defining approved modules, objectives, and hands-on exercises
- Validated slide Markdown files in `course/01-pipeline-fundamentals.md` and `course/02-pipeline-execution-and-verification.md` adhering to the HTML Slides Viewer contract:
  - Clean metadata headers (`course-title` and `course-theme`)
  - Isolated slide separators (`---`)
  - Valid layout directives (`title`, `navigation`, `2-column`, `3-column`, `card-layout`, `panel-left`, and `panel-right`)
  - Supported alert callouts (`NOTE`, `TIP`, `IMPORTANT`, `WARNING`, and `CAUTION`)
  - Explicit language tags on all fenced code blocks
  - Conformance with quality gates (no ampersands, no em-dashes, and varied slide layouts)
- Completed verification script at `scripts/verify-course.sh` (or `labs/lab-01-testing-the-course-pipeline/solution/verify-course.sh`) that automates structural checks across all course slide decks

## How to Verify

1. Run the verification script:

```bash
chmod +x labs/lab-01-testing-the-course-pipeline/solution/verify-course.sh
./labs/lab-01-testing-the-course-pipeline/solution/verify-course.sh
```

Expected output:

```text
===========================================
Running Course Pipeline Verification Checks
===========================================
Checking slide files in course/...
Check 1: Verifying code block language tags...
PASS: All code fences specify a language tag.
Check 2: Checking for prohibited ampersands in prose and titles...
PASS: No prohibited ampersand characters found.
Check 3: Validating alert callout syntax...
PASS: All alert callouts use supported platform tags.
Check 4: Verifying required course metadata comments...
PASS: All chapter slide decks declare required metadata.
===========================================
Result: All verification checks passed.
```

2. Confirm chapter progression and state files:

```bash
cat .course-factory/chapters-done.txt
```

Expected output:

```text
course/01-pipeline-fundamentals.md
course/02-pipeline-execution-and-verification.md
```

3. Confirm that slide decks use valid separators and layout directives:

```bash
grep -n "^---" course/01-pipeline-fundamentals.md | head -n 5
grep -E "<!-- layout:" course/01-pipeline-fundamentals.md | head -n 5
```

Expected output:
Each line contains an isolated `---` separator or a recognized layout comment.

## Built With

- Bash 5.x, POSIX standard utilities (`grep`, `cat`, `head`), Git 2.x (checked 2026-11-09)
- Unverified: None (tested against repository course files)
