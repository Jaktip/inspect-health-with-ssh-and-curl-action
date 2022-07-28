## Usage

```yml
name: Test action

on:
  push:
    branches:
      - master
  pull_request:
    branches:
      - master
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Execute sshpass
        id: inspect-service-health
        uses: ./
        with:
          host: ${{ secrets.HOST}}
          username: ${{ secrets.USERNAME}}
          ssh_private_key: ${{ secrets.SSH_PRIVATE_KEY}}
          module: ${{ secrets.MODULE}}
          module_port: ${{ secrets.MODULE_PORT}}

      - name: Display Execut sshpass output
        run: echo "${{ steps.inspect-service-health.outputs.status }}"
```


## Inputs

```yml
inputs:
  host:
    description: "SSHPASS host"
    required: true
  port:
    description: "SSHPASS host"
    default: 22
  username:
    description: "SSHPASS username"
    required: true
  module:
    description: "Module to inspect the health"
    required: true
  module_port:
    description: "Module's internal port"
    required: true
  ssh_private_key:
    description: "private key to set up Public Key Authentication with SSH"
    required: true
```

## Outputs

```yml
outputs:
  status:
    description: "Status of service health. 0 indicates that service is up, 1 indicates the service unavailabilty"
```
## Configuration

GitHub App authentication via `APP_ID`/`PRIVATE_KEY` is not supported. Only token authentication is supported by setting `GITHUB_TOKEN`.

Note that the `LOG_LEVEL` environment variable is ignored. Debug logs are not logged by default in GitHub Actions, but can be enabled by creating a `ACTIONS_STEP_DEBUG` repository secret and setting it to 1.

