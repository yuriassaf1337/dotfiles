#!/bin/bash

curl -s "wttr.in/?format=%t" | tr -d "+"
