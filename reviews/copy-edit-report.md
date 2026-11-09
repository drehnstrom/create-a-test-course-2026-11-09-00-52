# Copy Edit Report: Create a Test Course

## Pass: 2026-11-09

| Field | Value |
| :--- | :--- |
| Editor model | Claude 3.7 Sonnet |
| Session | Fresh (yes) |
| Scope | Slides and labs (`course/*.md`, `labs/lab-01-testing-the-course-pipeline/lab.md`) |

### Glossary

| Term | Form used | Notes |
| :--- | :--- | :--- |
| Git | `Git` | Standardized capitalized proper noun for the version control system in prose; command contexts retain lowercase `git` |
| Markdown | `Markdown` | Standardized capitalized noun for the markup format across prose |
| reformats | `reformats` | Standardized unhyphenated verb spelling |
| HTML Slides Viewer | `HTML Slides Viewer` | Standardized official platform component name |
| hands-on | `hands-on` | Hyphenated adjective before nouns in titles and prose |

### Fix counts

| Type | Count |
| :--- | :--- |
| Spelling | 1 |
| Grammar | 1 |
| Smart quotes | 0 |
| Em-dashes / ampersands | 0 |
| Consistency | 5 |

### Representative fixes

- `course/01-pipeline-fundamentals.md` / Model Tiers and Separation of Duties: “Prevents” → “Prevent” (subject-verb agreement matching plural subject and parallel verbs)
- `course/01-pipeline-fundamentals.md` / Quiz 1 of 3: “git commit history” → “Git commit history” (capitalized proper noun in prose)
- `course/02-pipeline-execution-and-verification.md` / Handling Execution Interruptions: “git commands” → “Git commands” (capitalized system name)
- `course/02-pipeline-execution-and-verification.md` / Quiz 1 of 3: “re-formats invalid markdown” → “reformats invalid Markdown” (unhyphenated verb spelling and capitalized format name)
- `labs/lab-01-testing-the-course-pipeline/lab.md` / You learn how to, Task 1, and Congratulations: “git version history” / “git commits” → “Git version history” / “Git commits”

### Left unchanged

- `git`, `grep`, `cat`, `head`, and `chmod` CLI command invocations inside code fences and inline code
- `Lab link: TODO` preserved exactly on Chapter 2 lab slide
- Platform layout directives (`<!-- layout: 2-column -->`, `<!-- layout: card-layout -->`, `<!-- layout: 3-column -->`, etc.) intact
- Metadata header comments (`<!-- course-title: Create a Test Course -->` and `<!-- course-theme: roi-alt-theme -->`) intact
- Slide separators (`---`) and heading structure preserved across all files
