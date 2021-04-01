# Processing Bag

## Blameless Deployed Instances

Download:

    <https://github.com/blamelesshq/blameless-deploy/blob/master/.circleci/config.yml>

Process:

```shell
yq e '.workflows.test_and_deploy.jobs.[] | keys' customertry.yaml | awk 'BEGIN {print "[blameless.deploy.instance]"} {printf "%s = true\n", $2}' > deployjobs.toml
```

This one is better:


```shell
yq e '.jobs.[].environment.INSTANCE_VALUES_DIR' customertry.yaml | awk -F'_' 'BEGIN {print "[blameless.prod.instance]"} /prod/{print $3" = \""$1"_"$2"\""}' > prodinstance.toml
```
