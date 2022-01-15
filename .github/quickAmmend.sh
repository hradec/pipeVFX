#!/bin/bash
# quickly ammend main.yml and push - usefull to debug and re-run actions

git commit .github/workflows/main.yml --amend -m "$(git log -1 | grep Date -A20 | egrep -v '^$|Date')" ; git push -f
