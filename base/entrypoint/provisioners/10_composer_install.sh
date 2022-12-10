#!/bin/bash
echo "Composer install provisioner start. Searching for composer in $PROJECT_ROOT..."
if [ -e $PROJECT_ROOT/composer.phar ]; then
  php $PROJECT_ROOT/composer.phar install --optimize-autoloader --no-progress --no-interaction --no-ansi --prefer-dist
fi;
echo "Composer executable not found in $PROJECT_ROOT, searching if composer is installed globally..."
EXECUTABLE=$(which composer)
if [ -x "$EXECUTABLE" ]; then
   $EXECUTABLE install --optimize-autoloader --no-progress --no-interaction --no-ansi --prefer-dist
fi
echo "No Composer executable found, skip dependency installation."