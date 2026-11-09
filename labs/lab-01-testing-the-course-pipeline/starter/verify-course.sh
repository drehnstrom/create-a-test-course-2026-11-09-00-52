#!/usr/bin/env bash
# Starter template for course pipeline verification
set -euo pipefail

echo "==========================================="
echo "Running Course Pipeline Verification Checks"
echo "==========================================="

ERRORS=0

echo "Checking slide files in course/..."

# Check 1: Verifying code block language tags
echo "Check 1: Verifying code block language tags..."
# TODO: Use grep to find code fences ('```') that lack a language tag
if grep -n '^```[[:space:]]*$' course/*.md 2>/dev/null; then
  echo "FAIL: Found code fences without an explicit language tag."
  ERRORS=$((ERRORS + 1))
else
  echo "PASS: All code fences specify a language tag."
fi

# Check 2: Checking for prohibited ampersand characters
echo "Check 2: Checking for prohibited ampersands in prose and titles..."
# TODO: Use grep to check for raw ampersand characters in course/*.md
if grep -n '&' course/*.md 2>/dev/null; then
  echo "FAIL: Found raw ampersand characters. Use 'and' instead."
  ERRORS=$((ERRORS + 1))
else
  echo "PASS: No prohibited ampersand characters found."
fi

# Check 3: Validating alert callout syntax
echo "Check 3: Validating alert callout syntax..."
# TODO: Use grep to check for unsupported alert tags like INFO or DANGER
if grep -E -n '^>[[:space:]]+\[!(INFO|DANGER|ALERT|SUCCESS)\]' course/*.md 2>/dev/null; then
  echo "FAIL: Found unsupported alert tags."
  ERRORS=$((ERRORS + 1))
else
  echo "PASS: All alert callouts use supported platform tags."
fi

# Check 4: Verifying required course metadata comments
echo "Check 4: Verifying required course metadata comments..."
# TODO: Check that course/0*.md files contain course-title and course-theme headers

echo "==========================================="
if [ "$ERRORS" -eq 0 ]; then
  echo "Result: All verification checks passed."
  exit 0
else
  echo "Result: Verification failed with $ERRORS defect(s)."
  exit 1
fi
