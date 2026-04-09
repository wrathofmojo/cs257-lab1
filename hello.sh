#!/bin/bash

script_name="$(basename "$0")"

echo "Hello from bash!"

echo "The first argument is: $1"
echo "The second argument is: $2"
echo "The third argument is: $@"
echo "The number of arguments is: $#"

# check if a question was provided
if [ $# -eq 0 ]; then

    echo "$0 your question here"
    exit 1
fi

# Check if API key is set
if [ -z "$GEMINI_API_KEY" ]; then
    echo "Error: GEMINI_API_KEY not set. Add to ~/.bashrc:"
    echo "export GEMINI_API_KEY=your-key-here"
    exit 1
fi

# The user's question
QUESTION="S*"

# Build the prompt
PROMPT="My instructor just said I need to move this to a git repo, How might I do that?"

Question: $QUESTION

# Call the Gemini API
RESPONSE=$(curl -s "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=$GEMINI_API_KEY" \
  -H "Content-Type: application/json" \echo "Hello from bash!"

  -d "{
    \"contents\": [{
      \"parts\": [{\"text\": \"$PROMPT\"}]
    }]
  }")

# Extract and print the response text
  echo "$RESPONSE" | jq -r '.candidates[0].content.parts[0].text'

