# 4. Platform Expectations of Services

Date: 2018-10-12

## Status

Accepted

## Context

As we are using Google Cloud Platform (GCP), some expectations must be met in order for services to run with high availability. There are a number of failure types that can occur at any point due to GCP, including (but not limited to); unexpected single instance failure, unexpected single instance reboot, and zone/region failures.

## Decision

### Stateless

Where possible, all state should exist external to the server. Examples of this include uploading files to Google Cloud Storage, using managed data storage (Redis, MySQL, etc), or logging to a centralised system. If the service cannot be stateless, or the service is a data store, use backups, shutdown scripts, and other mechanisms described in [Google's robust systems tutorial](https://cloud.google.com/compute/docs/tutorials/robustsystems) to allow quick recovery and reconfiguration of services. Data should be distributed between multiple availability zones, so as to avoid the risk of losing data.

### Resiliency to Unexpected Termination

GCP instances give a period of 30 seconds to run any shutdown commands or service tidying before forcefully terminating. Due to this, services should aim to complete any final shutdown processes within that time.

### Independent

The service should fail fast with any errors based on its own setup, however, the service should not rely on any other service to be in a started or healthy state to become started in itself. Once started, it should check dependencies to get itself into a healthy state.

## Consequences

* Services will need to be updated to ensure they meet the above criteria.
* Google restarting, terminating, or migrating our VMs would cause little to no impact on our operations.
* Services can be moved onto pre-emptive instances with a greater level of confidence, reducing overall infrastructure costs.
