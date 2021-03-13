# RainbowQ: A Resource Advisor

Part of having Observability is knowing where to find it.

One result of deeper dives into the network, security, integration, and identity infrastructures at Blameless is that there are multiplicative ways to find answers without any good way to get to the entry points. There is a real need for a data system that is a practical bibliography and global semaphore, curated and customized to the organization and needs of the people asking questions across every cloudy area of the business.

We are all familiar with these questions...

  What customers are in Tier-1?
  Which helm-vars are we using for <deployment>?
  Which cluster is <customer> in?
  What user accounts have access to Bastions?
  Where do I see the logs for Jira errors?
  Where can I see Auth0 reported errors?
  Who is on-call right now?

**RainbowQ** is this source of _truths_.

It is not only meant to help clear ambiguity by shining light on an answer, it provides a diverse spectrum of configurations and terms. It is part-Question engine, part-Queue of slowly-variable-to-constant data, part-Query tools and service location system.

The implementation of **RainbowQ** is meant to be modular and move with the flow of our needs by design. This means it may start life as a GitHub repo with a single yaml file. This may grow to something akin to a Salt Pillar with declarative layout. Later grow into a Consul cluster with strong consistency. Consume Kafka topics. Even be open-sourced, the reason for this Org and repo.
