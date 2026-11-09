<!-- course-title: Create a Test Course -->
<!-- course-theme: roi-alt-theme -->

<!-- layout: title -->
![ROI Logo](images/roi-logo-with-name.png)

Create a Test Course

# Chapter 1: Pipeline Fundamentals

---

# Chapter 1: Objectives

- Explore the structure, roles, and components of the course pipeline
- Explain the purpose and scope of automated course pipelines
- Identify the core architectural components and roles in the course pipeline
- Recognize the required inputs and resulting artifacts across the generation workflow

---

<!-- layout: navigation -->
# Chapter 1

- **Introduction to Course Pipelines**
- Pipeline Architecture and Components
- Expected Inputs and Artifacts

---

# What Is a Course Pipeline?

- Automated pipelines convert training course creation into a reproducible engineering process
- Structured agent steps transform an approved catalog outline into production-ready slide decks and labs
- Specialized AI agents run discrete tasks rather than attempting an unguided monolithic prompt
- Every stage produces deterministic Markdown files that compile directly in platform viewers

> [!NOTE]
> Separating the workflow into isolated file-based steps prevents context window degradation and keeps generations reproducible across teams.

---

<!-- layout: 2-column -->
# Manual Authoring vs Pipeline Delivery

### Manual Authoring
- High author fatigue and multi-week turnaround times
- Inconsistent slide layouts and uneven visual polish
- Code snippets and lab steps quickly drift out of date
- Syntax errors break browser presentation decks

### Pipeline Delivery
- Staged execution completes modules in minutes
- Programmatic enforcement of theme and layout gates
- Dedicated review agents verify code and facts
- Clean Markdown compiles in HTML slide viewers

---

<!-- layout: card-layout -->
# Why Staged Execution Matters

### Isolated Contexts
- Each step runs in a clean session reading from disk.
- Prevents previous agent hallucinations from polluting later stages.

### Human Checkpoints
- A human author approves the outline before writing starts.
- Critical architectural choices lock early to avoid costly rewrites.

### Specialized Skills
- Planners do not format slides, and editors do not change meaning.
- Distinct model tiers handle architecture, technical checks, and copy.

---

# Common Pipeline Failure Modes

- **Monolithic generation**: asking one prompt to write an entire course causes truncated code and omitted sections
- **Style coupling**: mixing visual styling with raw drafting creates invalid layout directives
- **Unverified claims**: fast-moving technology facts decay rapidly in model memory
- **Missing human gates**: skipping outline approval cascades structural errors through all downstream slides

> [!WARNING]
> Never let an automated agent start generating slides or labs until a human has explicitly approved `plan/course-outline.md`.

---

<!-- layout: navigation -->
# Chapter 1

- Introduction to Course Pipelines
- **Pipeline Architecture and Components**
- Expected Inputs and Artifacts

---

<!-- layout: card-layout -->
# Sequential Pipeline Stages

### Plan and Frame
- Architect writes the catalog outline and learning objectives.
- Spine generator creates introductory and chapter skeleton files.

### Content and Graphics
- Course generator drafts teaching slides, code, and quizzes.
- Graphics designer polishes visuals and validates layout directives.

### Review and Release
- Technical and copy editors verify facts, code, and typography.
- Lab generator builds and tests hands-on student exercises.

---

<!-- layout: 3-column -->
# Core Agent Roles

### Architecture and Spine
- **Course Architect**: writes outline from brief
- **Spine Generator**: establishes chapter files
- Enforces slide hierarchy and navigation

### Content and Graphics
- **Course Generator**: drafts teaching and code
- **Instructor Review**: adds demos and discussions
- **Graphics Designer**: polishes visuals and layouts

### Verification and Quality
- **Technical Editor**: verifies volatile facts
- **Lab Tester**: executes hands-on lab code
- **Copy Editor**: fixes grammar and typography

---

<!-- layout: 2-column -->
# Model Tiers and Separation of Duties

### Best Available Models
- Power planning, spine generation, and core teaching
- Require deep reasoning to balance depth and pacing
- Build functional lab solutions and step-by-step guides

### Independent Verification Models
- Use a different model tier to review technical accuracy
- Prevents self-confirmation bias when verifying CLI flags and APIs
- Lightweight models execute final copy editing and rule checks

<!-- below-columns -->

> [!TIP]
> Always run technical review and lab testing with a different model family than the generator to catch blind spots.

---

# File-Based Inter-Agent Communication

- Agents communicate exclusively through repository files, never shared chat memory
- Each step operates in a fresh session to ensure complete portability
- Standardized Markdown formats allow humans and tools to inspect state at any stage
- Git tracks the exact diff produced by each pipeline specialist

```bash
# Typical pipeline directory artifact progression
plan/course-outline.md           # Step 1: Architect
course/00-introduction.md        # Step 2: Spine Generator
course/01-pipeline-fund.md       # Step 3: Course Generator
reviews/technical-review.md      # Step 6: Technical Editor
labs/lab-01-pipeline/lab.md      # Step 7: Lab Generator
```

---

<!-- layout: navigation -->
# Chapter 1

- Introduction to Course Pipelines
- Pipeline Architecture and Components
- **Expected Inputs and Artifacts**

---

<!-- layout: 2-column -->
# The Planning Input: Brief and Outline

### Session Brief
- High-level course title and target duration
- Target audience definition and prerequisites
- Core technologies and learning objectives
- Starting guidance or existing outlines

### Course Outline (`plan/`)
- Two-level module and section breakdown
- Verifiable, single-line learning objectives
- Exact list of hands-on lab exercises
- Approved blueprint before any slide is drafted

---

<!-- layout: card-layout -->
# Slide Artifacts and Viewer Contracts

### Metadata Headers
- Every file declares `course-title` and `course-theme`.
- Binds the presentation to the HTML Slides Viewer.

### Single Slide Separators
- Exactly one `---` on a blank line separates slides.
- Missing or duplicate separators break slide counts.

### Structured Directives
- Standardized comments like `<!-- layout: 2-column -->`.
- Restricts layout choices to validated platform templates.

---

# Lab Artifacts and Supporting Files

- Labs are self-contained folders stored under `labs/lab-NN-slug/`
- Every lab includes a student manual (`lab.md`) and a tested solution directory
- Starter code provides initial templates when students should not build from scratch
- Supporting diagrams and screenshots live in a dedicated local `images/` directory

> [!IMPORTANT]
> The slide deck links to labs using `Lab link: TODO` until published URLs are generated and added during final delivery.

---

<!-- layout: 3-column -->
# Review Reports and Quality Gates

### Technical Review
- Written by technical editor
- Documents verified facts
- Logs CLI and API fixes in `reviews/technical-review.md`

### Lab Test Report
- Written by lab tester
- Proves steps in a clean run
- Records reproducible errors in `test-report.md`

### Copy Edit Report
- Written by copy editor
- Confirms typography rules
- Validates smart quotes, dashes, and clean grammar

---

# What You Learned

- Explored the structure, roles, and components of the course pipeline
- Explained the purpose and scope of automated course pipelines
- Identified the core architectural components and roles in the course pipeline
- Recognized the required inputs and resulting artifacts across the generation workflow

---

# Quiz 1 of 3

**Why does the course generation pipeline run each step in a fresh agent session?**

- A. To bypass git commit history and avoid tracking file changes
- B. To prevent context window degradation and avoid carrying forward hallucinations
- C. To allow agents to rewrite earlier approved course outlines
- D. To eliminate the need for human outline review

---

# Quiz 1: Answer

**Why does the course generation pipeline run each step in a fresh agent session?**

**Correct: B.** To prevent context window degradation and avoid carrying forward hallucinations

- Isolated sessions force agents to read authoritative state directly from repository files
- Long-running sessions accumulate chat drift and lose track of strict formatting rules
- Fresh sessions ensure work remains portable across different editor and agent tools
- Each step focuses entirely on its specific skill without prior conversational bias

---

# Quiz 2 of 3

**Which artifact serves as the mandatory human-approved contract before slide generation begins?**

- A. `reviews/copy-edit-report.md`
- B. `course/00-introduction.md`
- C. `plan/course-outline.md`
- D. `labs/lab-01-pipeline/test-report.md`

---

# Quiz 2: Answer

**Which artifact serves as the mandatory human-approved contract before slide generation begins?**

**Correct: C.** `plan/course-outline.md`

- The Course Architect writes the outline from the initial course brief
- Human approval at this checkpoint locks scope, audience, and objectives
- The Spine Generator and Course Generator depend on this file for module structure
- Generating slides before outline approval causes extensive rewrites and wasted tokens

---

<!-- layout: 2-column -->
# Quiz 3 of 3: Discussion

### Prompt
Your team wants to speed up course production by having a single agent prompt generate the entire course, slides, diagrams, and labs in one pass.

### Discuss
- What failure modes and quality risks are most likely to occur?
- Which pipeline quality gates would be bypassed?
- How does staged execution with specialized roles prevent these issues?

---

<!-- layout: 2-column -->
# Quiz 3: Discussion Points

**Your team wants to speed up course production by having a single agent prompt generate the entire course, slides, diagrams, and labs in one pass.**

### Strong Answers Mention
- Context window overflow resulting in truncated labs or superficial slides
- High likelihood of hallucinated CLI commands and untested code
- Loss of human checkpoints such as approving the outline before writing
- Inability to use independent models for technical and copy reviews

### Watch For
- Believing stronger frontier models eliminate the need for multi-step verification
- Viewing pipeline reviews and tests as unnecessary friction
- Overlooking platform presentation viewer formatting constraints

---

# Questions and Answers

Questions?
