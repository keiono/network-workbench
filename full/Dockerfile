FROM ubuntu:hirsute

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl \
    python3-pip \
    software-properties-common \
    clang-3.8 \
    cmake \
    libgtk-3-0 \
    wget

### Install Miniconda
RUN cd /opt && wget -nv 'https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh' -O conda.sh \
    && bash conda.sh -b -p /opt/conda \
    && rm conda.sh \
    && ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh

### Install Julia 
RUN wget -nv https://julialang-s3.julialang.org/bin/linux/x64/1.4/julia-1.4.1-linux-x86_64.tar.gz -O julia.tar.gz \
    && tar -xvzf julia.tar.gz \
    && echo 'PATH=$PATH:/opt/julia-1.4.1/bin' >> /etc/profile

SHELL ["/bin/bash", "-c", "source /etc/profile"]
RUN conda activate

### Install LightGraphs
RUN julia -e 'using Pkg; Pkg.add.("BenchmarkTools")'
RUN julia -e 'using Pkg; Pkg.develop.("LightGraphs")'
RUN julia -e 'using Pkg; Pkg.add.("GraphIO")'
RUN julia -e 'using Pkg; Pkg.add.("SortingAlgorithms")'

### Install Igraph
RUN conda create --name igraph
RUN conda activate igraph
RUN conda install -y -c conda-forge python-igraph

### Install Networkx
RUN conda create --name networkx
RUN conda activate networkx
RUN conda install -y -c anaconda networkx

### Install Graph-tool
RUN conda create --name graphtool
RUN conda activate graphtool
RUN conda install -y -c conda-forge graph-tool

### Install Networkit
RUN pip install ipython
RUN conda create --name networkit
RUN conda activate networkit
RUN conda install -y -c conda-forge networkit ipython

### Install Snap
RUN conda create --name snap python=3.7
RUN conda activate snap
RUN pip install snap-stanford

RUN conda install jupyterlab

EXPOSE 8888
EXPOSE 6006

CMD [ "jupyter", "lab", "--allow-root", "--ip", "0.0.0.0"]