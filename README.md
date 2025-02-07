<div align="center">
  <img src="https://shared.steamstatic.com/store_item_assets/steam/apps/24960/header.jpg"/>
  <br/>
  <img alt="GitHub License" src="https://img.shields.io/github/license/Laura7089/bfbc2-docker">
</div>

---

A [Docker](https://www.docker.com) image to run a dedicated server for [Battlefield: Bad Company 2](https://en.wikipedia.org/wiki/Battlefield:_Bad_Company_2) using the [Project Rome modding platform](https://veniceunleashed.net/project-rome) and the [BF:BC2 MASE Emulated Server](https://sourceforge.net/projects/battlefieldbadcompany2mase/).
It's broadly based on [this forum post](https://forums.veniceunleashed.net/viewtopic.php?p=60#p60).

## Usage

An example sequence coule be:

```bash
docker build -t bfbc2 https://github.com/Laura7089/bfbc2-docker.git && \
    docker run -d -p 19567:19567 -v $PWD/ServerOptions.ini:/battlefield/server/Instance/ServerOptions.ini:ro bfbc2
```

The image exposes one port at `19567`.
You can override the server configuration file located at `/battlefield/server/Instance/ServerOptions.ini`.

## Licensing

The files in this repo are licensed under the AGPL 3 (or a later).

Battlefield: Bad Company 2 is proprietary software licensed by Electronic Arts.
Battlefield Bad Company 2 MASE is provided by its respective developers.
Project Rome is a proprietary modding platform provided by its respective developers.
No credit is taken for the software in this image.
