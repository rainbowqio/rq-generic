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
#   1. A change is made somewhere, rq-blameless needs an update.
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
set -e

AWK="/usr/bin/awk"
CURL="/usr/bin/curl"
YQ="/usr/local/bin/yq"

# GitHub File Details
OWNER='blamelesshq'
REPO='blameless-deploy'
PATH='.circleci/config.yml'

# API Call
GH_API="https://api.github.com"
GH_REPO="$GH_API/repos/$OWNER/$REPO/contents/$PATH"
AUTH="Authorization: token $GH_TOKEN"
CONTENT="application/vnd.github.v3.raw"

# Validate Token
[[ $GH_TOKEN ]] || print "ERROR: GH_TOKEN required." >&2; exit 1
$CURL -o /dev/null -sH "$AUTH" $GH_REPO || print "ERROR: Connection verification unsuccessful. Please check for valid repo, token, and network.";  exit 1

# Download Raw File
# CURL_ARGS="-LJO#"
# $CURL $CURL_ARGS -H "$AUTH" -H "Accept: $CONTENT" "$GH_REPO"

# Fill Template
#
/bin/cp prefetch.toml rainbow.toml

# Prep Local Inserts
#

# Prep Fetch Inserts
#
print "\n# Blameless Deployed Instances" >> rainbow.toml

# Process Fetches
#
# circleci config.yml
$CURL -s -H "$AUTH" -H "Accept: $CONTENT" "$GH_REPO" | \
  $YQ e '.jobs.[].environment.INSTANCE_VALUES_DIR' - | \
  $AWK -F'_' 'BEGIN {print "[blameless.prod.instance]"} /prod/{print $3" = \""$1"_"$2"\""}' >> rainbow.toml

print "$0 done." >&2
