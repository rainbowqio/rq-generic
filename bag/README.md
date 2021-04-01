# Processing Bag

## Blameless Deployed Instances

Download:

    <https://github.com/blamelesshq/blameless-deploy/blob/master/.circleci/config.yml>

Process:

```shell
yq e '.workflows.test_and_deploy.jobs.[] | keys' customertry.yaml | \
awk 'BEGIN {print "[blameless.deploy.instance]"} {printf "%s = true\n", $2}' > deployjobs.toml
```

The result is a new Almanac with each deployed instance marked as 'true'. This will allow the user to find the presence of a customer:

```shell
qio ask blameless.deploy.instance hashicorp
blameless.deploy.instance.hashicorp ::: %!s(bool=true)
```

Or list all customers (messy right now, raw map output): `qio ask blameless.deploy instance`

