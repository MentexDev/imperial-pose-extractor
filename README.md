# Imperial imperial-pose-extractor

**Cinema-grade GPU worker for the Imperio Nyemen video/avatar pipeline.**

Role: `DWPose skeleton extractor`. Built atop `runpod/worker-comfyui:5.8.5-base`.

## Image

```
ghcr.io/mentexdev/imperial-pose-extractor:latest
ghcr.io/mentexdev/imperial-pose-extractor:v1
```

## Usage (RunPod template)

Set the template's `imageName` to one of the tags above. The image is public — no `containerRegistryAuthId` needed.

## Pipeline integration

This worker is consumed by the imperial avatar pipeline at `apps/worker/src/lib/{pose-extractor,body-avatar,sam2-background}/`. The dispatchers route to RunPod endpoints that run this image.

## Deploy contract

| Input shape | ComfyUI workflow | Output |
|---|---|---|
| `{ workflow: {...nodes}, images: [{name, image: base64}] }` | Custom-built per call | `{ images: [{ data: base64, type: 'base64', filename }] }` |

## CI/CD

GitHub Actions auto-builds + pushes to GHCR on every commit to `main`. Tags pushed as `vX.Y.Z` produce immutable semver releases. See `.github/workflows/build-push.yml`.

## License

MIT — see LICENSE.

---

**Engineered by HELIOS** | Imperio Nyemen | 2026-05-05
