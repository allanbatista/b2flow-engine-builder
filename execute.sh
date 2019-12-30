#!/usr/bin/env bash
sh builder.sh | tee builder.log

python -m b2flow_builder.callback ${PIPESTATUS[0]} builder.log