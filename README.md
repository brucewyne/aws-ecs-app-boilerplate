# An AWS ECS application boilerplate.

This is to be used in conjunction with https://github.com/brucewyne/aws-ecs-boilerplate. Once ECS + a Load Balancer is setup, you can deploy multiple Services or Applications to ECS using Fargate.

The included Dockerfile is just for reference. 

## What this gives you

* The Basics of a CI/CD Pipeline to Production
* The Basics of a CI/CD Pipeline to a "Pre-Production" environment
* a Preview Environment per each open PR. 
  * Great for Front Ends in which you want to isolate QA or UAT.

## Prerequisites
* Create an ECR in AWS. It's not included by default in the previous Repository.
* Cloudflare to manage your DNS if using dynamic Preview Environments
