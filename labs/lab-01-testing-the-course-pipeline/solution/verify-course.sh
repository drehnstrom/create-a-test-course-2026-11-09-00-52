#!/usr/bin/env bash
# Automated course pipeline verification script
set -euo pipefail

echo "==========================================="
echo "Running Course Pipeline Verification Checks"
echo "==========================================="

ERRORS=0

echo "Checking slide files in course/..."

# 1. Check for fenced code blocks without a language tag
echo "Check 1: Verifying code block language tags..."
if grep -n '^```[[:space:]]*$' course/*.md 2>/dev/null; then
  echo "FAIL: Found code fences without an explicit language tag."
  ERRORS=$((ERRORS + 1))
else
  echo "PASS: All code fences specify a language tag."
fi

# 2. Check for prohibited ampersand characters in slide text
echo "Check 2: Checking for prohibited ampersands in prose and titles..."
if grep -n '&' course/*.md 2>/dev/null; then
  echo "FAIL: Found raw ampersand characters. Use 'and' instead."
  ERRORS=$((ERRORS + 1))
else
  echo "PASS: No prohibited ampersand characters found."
fi

# 3. Check for unsupported alert tags
echo "Check 3: Validating alert callout syntax..."
if grep -E -n '^>[[:space:]]+\[!(INFO|DANGER|ALERT|SUCCESS)\]' course/*.md 2>/dev/null; then
  echo "FAIL: Found unsupported alert tags. Use NOTE, TIP, IMPORTANT, WARNING, or CAUTION."
  ERRORS=$((ERRORS + 1))
else
  echo "PASS: All alert callouts use supported platform tags."
fi

# 4. Check for course metadata headers
echo "Check 4: Verifying required course metadata comments..."
MISSING_METADATA=0
for file in course/0*.md; do
  if ! grep -q '<!-- course-title:' "$file" || ! grep -q '<!-- course-theme:' "$file"; then
    echo "FAIL: $file is missing required course-title or course-theme header."
    MISSING_METADATA=$((MISSING_METADATA + 1))
  fi
done

if [ "$MISSING_METADATA" -eq 0 ]; then
  echo "PASS: All chapter slide decks declare required metadata."
else
  ERRORS=$((ERRORS + MISSING_METADATA))
fi

echo "==========================================="
if [ "$ERRORS" -eq 0 ]; then
  echo "Result: All verification checks passed."
  exit 0
else
  echo "Result: Verification failed with $ERRORS defect(s)."
  exit 1
fi
