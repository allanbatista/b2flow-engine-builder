#!/usr/bin/env bash
echo "=================================================="
echo "                       BUILDER                    "
echo "=================================================="
sh builder.sh | tee builder.log
STATUS=${PIPESTATUS[0]}

echo "=================================================="
echo "                       CALLBACK                   "
echo "=================================================="
python -m b2flow_builder.callback ${STATUS} builder.log

echo "=================================================="
echo "                       EXITING                    "
echo "=================================================="
exit 0