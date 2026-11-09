<!-- course-title: Create a Test Course -->
<!-- course-theme: roi-alt-theme -->

<!-- layout: title -->
![ROI Logo](images/roi-logo-with-name.png)

Create a Test Course

# Chapter 2: Pipeline Execution and Verification

---

# Chapter 2: Objectives

- Validate course generation and review automated pipeline outputs
- Run the automated course generation workflow from start to finish
- Verify generated slide decks and course artifacts against quality standards
- Test the complete course generation pipeline in a hands-on exercise

---

<!-- layout: navigation -->
# Chapter 2

- **Executing the Generation Workflow**
- Validating Generated Assets
- Lab: Testing the Course Pipeline

---

# Initiating the Pipeline Workflow

- A generation run begins with a structured brief defining title, audience, and scope
- Initializer scripts scaffold repository branches, file skeletons, and tracking metadata
- The Course Architect produces `plan/course-outline.md` as the authoritative blueprint
- Human review locks learning objectives and module lists before slide drafting begins

> [!NOTE]
> The course brief acts as the seed across all agent sessions, keeping explanations aligned with the intended student audience.

---

# Launching a Course Run

- Initialization commands establish working directories and seed tracking files
- Execution scripts pass parameters into the workspace scaffold
- Repository state tracks progression from catalog idea to generated files

```bash
# Initialize course workspace from brief parameters
./scripts/new-course.sh \
  --title "Create a Test Course" \
  --length "1 hour" \
  --audience "Anyone" \
  --repo "create-a-test-course"

# Verify initial plan directory and outline scaffold
ls -la plan/
# -rw-r--r-- 1 runner runner 1024 May 12 10:00 course-outline.md
```

---

<!-- layout: card-layout -->
# Managing Pipeline State

### Session State
- Stored in `.course-factory.json` to record repository configuration and parameters.
- Supplies consistent metadata across distinct, isolated agent invocations.

### Chapter Progress
- Tracked in `.course-factory/chapters-done.txt` as each chapter completes.
- Prevents redundant execution when restarting after interruptions or token limits.

### Git Versioning
- Every agent step commits distinct file changes directly to the repository.
- Provides rollback checkpoints whenever an agent violates formatting rules.

---

<!-- layout: 2-column -->
# Staged Generation vs Monolithic Runs

### Monolithic Generation
- Attempts to draft all chapters, slides, and exercises in one prompt
- Context window saturation causes truncated code and omitted sections
- Difficult to identify which instruction produced a formatting bug
- High token waste when an error forces a complete generation restart

### Staged Generation
- Processes one chapter file per agent run in a clean context window
- Preserves model reasoning capacity for thorough teaching and code
- Isolates errors to a single file without corrupting finished chapters
- Allows human authors to inspect and adjust chapters incrementally

---

# Handling Execution Interruptions

- Network drops or rate limits can pause a pipeline mid-run
- File-based tracking enables clean resumption from the exact failed step
- Uncommitted edits from an aborted step are discarded via git commands
- Previously completed chapters remain preserved and verified in repository history

> [!TIP]
> Always run `git status` and `git diff` before restarting a paused pipeline stage to confirm the working tree is clean.

---

<!-- layout: navigation -->
# Chapter 2

- Executing the Generation Workflow
- **Validating Generated Assets**
- Lab: Testing the Course Pipeline

---

# The HTML Slides Viewer Contract

- The presentation viewer parses slide Markdown directly in real time
- Slide transitions rely on clean `---` delimiters on isolated lines
- Unrecognized layout comments or unclosed fences break browser rendering
- Conformance checklist validation protects instructors from live classroom failures

> [!IMPORTANT]
> Viewer syntax rules are hard gates. A broken layout directive or missing slide separator halts presentation rendering.

---

<!-- layout: 2-column -->
# Valid Syntax vs Breaking Violations

### Valid Viewer Syntax
- Layout directive on its own line above the `#` title: `<!-- layout: 2-column -->`
- Slide separators consist of exactly `---` on an isolated line
- Blockquote alerts use only permitted tags such as `> [!NOTE]`
- Every fenced code block specifies an explicit language tag

### Breaking Violations
- Invented layout tags like `<!-- layout: split -->` or nested comments
- Trailing text or spaces on separator lines like `--- slide 2 ---`
- Unrecognized alert markers like `> [!INFO]` or missing blockquote brackets
- Untagged code fences that confuse syntax highlighters

---

<!-- layout: card-layout -->
# Quality Gates for Generated Slides

### Layout Variety
- Enforces a maximum of three consecutive default content slides.
- Alternates between two-column comparisons, card layouts, and code blocks.

### Typography Rules
- Requires smart quotes in prose and straight quotes in code fences.
- Strictly prohibits ampersand characters and em-dashes in visible text.

### Content Depth
- Ensures every non-lab section teaches an idea, an example, and a failure mode.
- Uses thesis-first bullets with a maximum of two nested hierarchy levels.

---

# Validating Fences and Alerts

- Code blocks require language identifiers to ensure accurate syntax highlighting
- Alert boxes must use one of five supported tags: NOTE, TIP, IMPORTANT, WARNING, or CAUTION
- Review passes check these constraints before slide decks reach publishing stages

```markdown
<!-- layout: 2-column -->
# Checking Syntax Rules

### Proper Callout
> [!WARNING]
> Never commit sensitive credentials or unverified state.

### Proper Code Block
```bash
# Validate markdown syntax before commit
npx markdownlint course/02-pipeline-execution-and-verification.md
```
```

---

<!-- layout: 3-column -->
# Specialized Review Agents

### Technical Editor
- Verifies technical claims, API signatures, and CLI options
- Confirms code samples execute without deprecated flags
- Documents verified facts in `reviews/technical-review.md`

### Instructor Review
- Assesses cognitive load, pacing, and explanation clarity
- Inserts demonstration prompts and discussion pauses
- Verifies time budgeting against course targets

### Copy Editor
- Enforces typography standards, grammar, and style rules
- Converts straight quotes in prose to directional smart quotes
- Removes prohibited ampersands and validates metadata headers

---

<!-- layout: navigation -->
# Chapter 2

- Executing the Generation Workflow
- Validating Generated Assets
- **Lab: Testing the Course Pipeline**

---

# Testing the Course Pipeline

Lab link: TODO

---

# What You Learned

- Validated course generation and reviewed automated pipeline outputs
- Ran the automated course generation workflow from start to finish
- Verified generated slide decks and course artifacts against quality standards
- Tested the complete course generation pipeline in a hands-on exercise

---

# Quiz 1 of 3

**Why is viewer syntax conformance treated as a non-negotiable hard gate in the pipeline?**

- A. The presentation viewer automatically re-formats invalid markdown on the server
- B. Invalid layout comments or malformed separators break deck rendering during live delivery
- C. Markdown syntax errors only affect PDF export tools and leave browser slides intact
- D. Layout directives are optional hints that the viewer ignores at runtime

---

# Quiz 1: Answer

**Why is viewer syntax conformance treated as a non-negotiable hard gate in the pipeline?**

**Correct: B.** Invalid layout comments or malformed separators break deck rendering during live delivery

- The HTML Slides Viewer parses Markdown directly in real time
- An invalid layout comment or missing separator halts slide parsing in front of a class
- Broken code fences or nested comments corrupt visual layout and navigation drawers
- Automated verification catches structural errors before instructors present

---

# Quiz 2 of 3

**Which slide formatting pattern violates the HTML Slides Viewer rules?**

- A. Using `<!-- layout: 2-column -->` on its own line immediately above a slide title
- B. Placing a lone `---` on an empty line between slides
- C. Using `<!-- layout: split -->` or inserting an ampersand into a slide title
- D. Specifying `bash` on a fenced code block

---

# Quiz 2: Answer

**Which slide formatting pattern violates the HTML Slides Viewer rules?**

**Correct: C.** Using `<!-- layout: split -->` or inserting an ampersand into a slide title

- `split` is not a recognized layout directive in the viewer engine
- Prohibited ampersands in titles and visible text violate house typography rules
- Valid directives are limited to documented templates like `2-column`, `card-layout`, and `stacked`
- Every code fence must provide a language tag, and separators must sit on lone lines

---

<!-- layout: 2-column -->
# Quiz 3 of 3: Discussion

### Prompt
A generator produces a chapter where five consecutive slides use the default bullet layout, two code blocks lack language tags, and the title uses an ampersand.

### Discuss
- Which platform rules and quality gates were violated?
- What impact do these issues have on student engagement and presentation rendering?
- How should the pipeline identify and correct these defects before release?

---

<!-- layout: 2-column -->
# Quiz 3: Discussion Points

**A generator produces a chapter where five consecutive slides use the default bullet layout, two code blocks lack language tags, and the title uses an ampersand.**

### Strong Answers Mention
- Violation of the variety rule (maximum of three consecutive default content slides)
- Unfenced code languages causing broken syntax highlighting
- Typography failure due to the forbidden ampersand character
- Automated linting or copy-editor review as the enforcement mechanism

### Watch For
- Treating layout variety as purely cosmetic rather than a pedagogical tool
- Overlooking viewer rendering errors caused by missing language tags
- Suggesting manual slide fixes during live instruction instead of pipeline checks

---

# Questions and Answers

Questions?
