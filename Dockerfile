# Imperial Pose Extractor — DWPose on top of runpod/worker-comfyui
# Engineered by HELIOS | 2026-04-27 | Fase 1 GPU deploy cinema-grade
#
# Extends the official runpod/worker-comfyui:5.8.5-base image with the
# `comfyui_controlnet_aux` custom node pack (DWPreprocessor, OpenposePreprocessor)
# + DW pose checkpoints pre-downloaded so cold starts are fast.

FROM runpod/worker-comfyui:5.8.5-base

# Install controlnet_aux pack + its deps via the worker-comfyui CLI helper.
# This is the OFFICIAL supported install mechanism per
# https://github.com/runpod-workers/worker-comfyui/blob/main/docs/customization.md
RUN comfy-node-install comfyui_controlnet_aux

# Install wget (curl missing in slim base) + pre-download DWPose checkpoints.
# The detector + estimator are ~250 MB combined.
RUN apt-get update && apt-get install -y --no-install-recommends wget ca-certificates && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /comfyui/custom_nodes/comfyui_controlnet_aux/ckpts/yzd-v/DWPose && \
    cd /comfyui/custom_nodes/comfyui_controlnet_aux/ckpts/yzd-v/DWPose && \
    wget -q -O yolox_l.onnx \
      https://huggingface.co/yzd-v/DWPose/resolve/main/yolox_l.onnx && \
    wget -q -O dw-ll_ucoco_384.onnx \
      https://huggingface.co/yzd-v/DWPose/resolve/main/dw-ll_ucoco_384.onnx

# Smoke marker so we can verify the right image is running
RUN echo "imperial-pose-extractor v1 (HELIOS 2026-04-27)" > /imperial-build-info.txt

LABEL imperial.role=pose-extractor
LABEL imperial.version=1.0.0
LABEL imperial.maintainer=helios
