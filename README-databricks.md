This is the Databricks fork for io.prometheus/client_java.

It contains two main modifications:
* It doesn't enforce that all counters end with `_total` to match the OpenTelemetry standard.
* It won't create the new `_created` metric for each counter.

We should try to merge some of these changes upstream so that we don't need to keep this around for very long.

# Deploying to Maven

This project is configured to deploy to an Databricks Private S3 Backed Maven repository.

The version is read from ALL pom files. At the time of writing "0.16.1-databricks" is the
version. Deploying this version to S3 (or any -SNAPSHOT) will push to a special snapshot repository
and *overwrite* any existing snapshot of the same version. It is advisable to use a unique name
while developing to avoid conflicts between multiple developers. Non-snapshot releases are immutable
and cannot be overwritten.

When doing local development, installing to the local repository is prefered.

Use the following command to install the artifact *locally*
```
./deploy.sh <your-email>@databricks.com install
```

To deploy to our maven repo. First go to go/aws-rnd-root and select aws-staging. Pick the databricks-build-artifacts-write account and choose 'Command line or programmatic access'.
In that window, you can copy the command that sets the credentials.

```
export AWS_ACCESS_KEY_ID=...
export AWS_SECRET_ACCESS_KEY=...
export AWS_SESSION_TOKEN=..

./deploy.sh <your-email>@databricks.com deploy
```

Use the following to reference the artifact from Maven in other projects:
```
  <groupId>io.prometheus</groupId>
  <artifactId>simple_client</artifactId>
  <version>0.16.1-databricks</version>
```
