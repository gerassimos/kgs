#!/bin/sh

echo "release-name: $(basename $(pwd))"
helm template --release-name "$(basename $(pwd))" -f values.yaml . > template.yaml