## Node elasticity

1. Application deployed: ![localImage](./task4_create_deployment.png)
2. Found some pods in pending state: ![localImage](./task4_pending_pods.png) ![localImage](./task4_incomplete_deployment.png)
3. Not enough nodes/node_capacity available to spin up all the pods: ![localImage](./task4_problem.png)
4. Modified the EKS terraform config for max and desired number of nodes to 3. TF apply: ![localImage](./task4_tf_update.png)
5. After TF apply, the pods were no longer in a pending state: ![localImage](./task4_kgpo.png)