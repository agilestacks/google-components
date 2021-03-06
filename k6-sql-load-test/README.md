# K6 SQL load test

## Description

The component uses [k6.io]testing framework with [xk6-sql extension](https://github.com/grafana/xk6-sql) to run an example load test against the given SQL server.

## Structure

The component executes the given test scenario. Currently, there is only one scenario, please see [example](example-mysql.js.template)
The component has the following directory structure:

```text
./
├── hub-component.yaml               # manifest file of the component with configuration and parameters
├── deploy.sh                        # `deploy` runs the load test
├── undeploy.sh                      # `undeploy` does nothing
└── example-mysql.js.template        # example test scenario that inserts some dummy data to the given mysql database and runs a simple select query against it
```

## Parameters

| Name      | Description | Default Value | Required
| :-------- | :--------   | :--------     | :--:
| `component.k6SQLloadTest.dbKind` | SQL database kind | mysql | x |
| `component.k6SQLloadTest.dbHost` | SQL database hostname | n/a | x |
| `component.k6SQLloadTest.dbName` | SQL database name | n/a | x |
| `component.k6SQLloadTest.dbUser` | SQL database user | n/a | x |
| `component.k6SQLloadTest.password` | SQL database password | n/a | x |
| `component.k6SQLloadTest.testName` | Test name | example | x |
| `component.k6SQLloadTest.testDuration` | Test duration | 100s | x |
| `component.k6SQLloadTest.numberOfUsers` | Number of concurent users | 1000 | x |

## References

* [k6.io]
* [hub cli](https://github.com/agilestacks/hub/wiki)

[k6.io]: https://k6.io
