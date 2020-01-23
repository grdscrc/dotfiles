#!/bin/bash

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi # Rbenv shims
export CC=/usr/bin/clang #Fixes bug in 'rbenv install'

