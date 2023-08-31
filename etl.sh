#!/usr/bin/env zsh
#
#   This script requires 'export GH_TOKEN=<personal access token>'
#
#   This script is idempotent: it composes a completely new resources every time, it does not edit existing files.
#
#   *** About the ETL ***
#
#   There are two artifacts:
#   1. QIO has its own tag / version / release
#   2. rainbow.yaml has its own tag / version / release
#
#   QIO code can be pulled down by this module to build a Docker container with the data embedded.
#   1. A change is made somewhere, rq needs an update.
#   2. An agent checks out this repo
#   3. The agent runs this script that cats toml together
#   4. The result is rainbow.toml which is committed to the repo
#
#   That's all there is to it. If the person can check out this repo and install qio, they have the ability to run it against this data.
#
#   However, that is probably not the case, so we put it in a container.
#
#   5. qio should not 'control' any ETL of data itself, its job is to pull a set of configurations that is ready to go.
#   6. so it's actually the rq-* repo that contains the Dockerfile that is going to package up the company data alongside qio in a container.

# The owner of the repo
OWNER='GITHUB OWNER'
# The repo with a file that has relevant data to grab
REPO='GITHUB REPO'
# The path of the file with data
PATH='.circleci/config.yml'
# The GitHub API endpoint
GH_API="https://api.github.com"
# The GitHub API URI for this operation
GH_REPO="$GH_API/repos/$OWNER/$REPO/contents/$PATH"
# Headers
AUTH="Authorization: token $GH_TOKEN"
CONTENT="application/vnd.github.v3.raw"
# Options
CURL_ARGS="-LJO#"
# Binaries
AWK="/usr/bin/awk"
CURL="/usr/bin/curl"
YQ="/usr/local/bin/yq"

# Validate Token
$CURL -o /dev/null -sH "$AUTH" $GH_REPO || { echo "ERROR: Invalid repo, bad token, network issue?";  exit 1; }

# Download Raw File
# $CURL $CURL_ARGS -H "$AUTH" -H "Accept: $CONTENT" "$GH_REPO"

# Fill Template
#
/bin/cp prefetch.toml rainbow.toml

# Prep Local Inserts
#

# Prep Fetch Inserts
#
print "\n# Org Deployed Instances" >> rainbow.toml

# Process Fetches
#
# circleci config.yml
$CURL -s -H "$AUTH" -H "Accept: $CONTENT" "$GH_REPO" | \
  $YQ e '.jobs.[].environment.INSTANCE_VALUES_DIR' - | \
  $AWK -F'_' 'BEGIN {print "[org.prod.instance]"} /prod/{print $3" = \""$1"_"$2"\""}' >> rainbow.toml

print "$0 done." >&2
