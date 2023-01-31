# Personal Website

This repository contains the source code for my [website](https://mirceanton.com), built with [hugo](https://gohugo.io/), using the [blowfish theme](https://github.com/nunocoracao/blowfish), hosted via [CloudFlare Pages](https://pages.cloudflare.com/).

## 📁 Repository Structure

```bash
.
├── README.md
├── functions -> edge functions handled by cloudflare workers
├── package.json -> npm scripts mostly
├── scripts -> various scripts used
└── website -> the source files for the hugo site
```

## ☁️ CloudFlare Setup

**Project Setup**:

1. Configure a new CloudFlare Pages project via Git
2. Set up the build command as: `npm run build`
3. Set up the publish directory as `public/`
4. Go into the project settings and configure the env vars as follows:
    - `HUGO_VERSION`: `0.110.0`
    - `NODE_VERSION`: `v17.9.1`
