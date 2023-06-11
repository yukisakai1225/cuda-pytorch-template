# イメージベースを指定
FROM nvidia/cuda:11.8.0-base-ubuntu18.04

# パッケージ類のインストール
RUN apt update && apt install -y curl \
    xvfb \
    x11vnc

ENV HOME=/home
WORKDIR /home

# Install Miniconda
RUN curl -so ~/miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && chmod +x ~/miniconda.sh \
    && ~/miniconda.sh -b -p ~/miniconda \
    && rm ~/miniconda.sh
ENV PATH=/home/miniconda/bin:$PATH
ENV CONDA_AUTO_UPDATE_CONDA=false

# # Create a Python 3.8 environment
RUN conda install conda-build \
    && conda create -y --name py38 python=3.8.0 \
    && conda clean -ya
ENV CONDA_DEFAULT_ENV=py38
ENV CONDA_PREFIX=/home/miniconda/envs/$CONDA_DEFAULT_ENV
ENV PATH=$CONDA_PREFIX/bin:$PATH

# # # PyTorch with CUDA 11 installation
RUN conda install -y pytorch \ 
    torchvision \
    torchaudio \ 
    pytorch-cuda=11.8 \
    -c pytorch -c nvidia

# ready for bind mounts
RUN mkdir /home/src