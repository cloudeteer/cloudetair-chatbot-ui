<!-- markdownlint-disable first-line-h1 no-inline-html -->

> [!NOTE]
> This repository is publicly accessible as part of our open-source initiative. We welcome contributions from the community alongside our organization's primary development efforts.

---

# cloudetair-chatbot-frontend

The <font color="#2f4b94">CLOUDET<font color="#c6c6c6"><i>ai</i></font>R</font> chatbot frontend builds on [LibreChat](https://github.com/danny-avila/LibreChat), using the official stable LibreChat container images as the [Dockerfile](./Dockerfile) base.

Many thanks to the LibreChat team for providing a solid foundation! :heart:

## Features

- Builds a customized Docker image on top of the official LibreChat image.
- Pushes the customized image to GitHub Container Registry.
- Fully automated via GitHub Actions workflows.
- Serves as a reusable base for further customizations.

## Default Configuration

This repository includes a default [librechat.yaml](librechat.yaml) configuration that adds support for an Azure OpenAI endpoint.
The endpoint parameters are provided through the environment variables:

- `AZURE_OPENAI_INSTANCE_NAME`
- `AZURE_OPENAI_API_KEY`

## Development

This project extends the official LibreChat container image. There is no separate app codebase; development focuses on customizing the container and deployment.

```shell
# Build the container image
docker compose build

# Start the containers in detached mode
docker compose up --detach

# The frontend will be available at http://localhost:3080

# Stop containers and remove volumes
docker compose down --volumes
```
