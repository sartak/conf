function qraw --description 'ask openai'
  set prompt $argv[1]
  echo "$prompt" > ~/.local/share/openai/prompt

  if not set -q tokens
    set -f tokens 200
  end

  set payload "{\"model\": \"text-davinci-003\", \"prompt\": $prompt, \"max_tokens\": $tokens}"
  set apikey (command cat ~/.local/share/openai/key)

  set output (curl -s https://api.openai.com/v1/completions \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $apikey" \
    -d $payload)

  echo $output | jq -r '.choices[0].text'
  if test $status -ne 0
    echo "output:"
    echo $output
    return 1
  end
end

function q --description 'ask openai'
  if not set -q argv[1]
    set prompt (command cat ~/.local/share/openai/prompt)
  else
    set prompt (echo $argv | jq -R)
  end

  qraw "$prompt"
end

function qf --description 'add question to current openai thread'
  if not set -q argv[1]
    echo 'usage: qf question…' >&2
    return 1
  end

  set context (command cat ~/.local/share/openai/prompt)
  set new (echo $argv | jq -R)

  set prefix (string sub --length 1 $context)

  if test "$prefix" = '"'
    set prompt "[$context, $new]"
  else
    set prompt (string replace -r ']$' ", $new]" $context)
  end

  qraw "$prompt"
end

function qq --description 'ask openai but longer'
  set -fx tokens 1000
  q $argv
end

function qqf --description 'add question to current openai thread but longer'
  set -fx tokens 1000
  qf $argv
end

