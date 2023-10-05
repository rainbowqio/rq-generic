# RainbowQ Almanac Schema

Data structure for [RainbowQ](https://github.com/rainbowqio/qio) Almanacs.

## Usage

1. `go get github.com/rainbowq/qio` if you have a Golang environment
2. `docker pull rainbowq/qio` to run as a container
3. `qio list` will create a new database
4. `cd $HOME/.config/qio/`
5. `rm rainbow.toml`
6. `ln -s <PATH_TO>/rainbow.toml` (i.e. this directory)
7. `qio list` will now show the newly installed rainbow

You may also want to make a copy and place that in `$HOME/.config/qio/` so you won't clobber it on a code refresh.

## ETL example

This example shows how the included shell script could be used to download data from a Github repo and perform some munging on it.

1. `export GH_TOKEN=<personal access token>`
2. `./etl.sh`
3. Commit the new `rainbow.toml` data file.

## About RainbowQ

Part of having Observability is knowing where to find it.

One result of deeper dives into the network, security, integration, and identity infrastructures is that there are multiplicative ways to find answers without any good way to get to the entry points. There is a real need for a data system that is a practical bibliography and global semaphore, curated and customized to the organization and needs of the people asking questions across every cloudy area of the business.

We are all familiar with these questions...

- What customers are in Tier-1?
- Which helm-vars are we using for <deployment>?
- Which cluster is <customer> in?
- What user accounts have access to Bastions?
- Where do I see the logs for Jira errors?
- Where can I see Auth0 reported errors?
- Who is on-call right now?

**RainbowQ** is this source of _truths_.

It is not only meant to help clear ambiguity by shining light on an answer, it provides a diverse spectrum of configurations and terms. It is part-Question engine, part-Queue of slowly-variable-to-constant data, part-Query tools and service location system.

The implementation of **RainbowQ** is meant to be modular and move with the flow of our needs by design. This means it may start life as a GitHub repo with a single yaml file. This may grow to something akin to a Salt Pillar with declarative layout. Later grow into a Consul cluster with strong consistency. Consume Kafka topics. Even be open-sourced, the reason for this Org and repo.
