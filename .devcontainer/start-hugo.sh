#!/bin/bash
cd /workspaces/$(basename $(pwd))
hugo server -D --bind=0.0.0.0