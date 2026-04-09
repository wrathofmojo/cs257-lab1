#!/bin/bash

# Check if a question was provided
if [ $# -eq 0 ]; then
    echo "Usage: hey your question here"
    exit 1
fi

# Check if API key is set
if [ -z "$GEMINI_API_KEY" ]; then
    echo "Error: GEMINI_API_KEY not set. Add to ~/.bashrc:"
    echo "export GEMINI_API_KEY=your-key-here"
    exit 1
fi

# The user's question (all arguments combined)
QUESTION="$*"

# Build the prompt
PROMPT="You are a friendly tutor helping a student who has never used the command line or git before. This is their second programming class.

Question: $QUESTION

Instructions:
- Put any command they should copy on its own line, with no other text on that line
- Keep explanations simple and jargon-free
- If you must use a technical term, briefly explain it
- For simple questions, give just the command and one sentence explaining what it does
- For complex questions, break it down step by step"

# Call the Gemini API
RESPONSE=$(curl -s "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=$GEMINI_API_KEY" \
  -H "Content-Type: application/json" \
  -d "{
    \"contents\": [{
      \"parts\": [{\"text\": \"$PROMPT\"}]
    }]
  }")

# Extract and print the response text
echo "$RESPONSE" | jq -r '.candidates[0].content.parts[0].text'

