# Base image of graph-tools
# FROM tiagopeixoto/graph-tool:latest

# FROM continuumio/miniconda3:latest


# RUN conda config --add channels conda-forge
# RUN conda install graph-tool jupyterlab -y


# Graph Analysis Workbench

FROM ubuntu:hirsute

RUN apt-get update && apt-get install --yes --no-install-recommends \
	gnupg2 \
	ca-certificates \
	cmake \
	curl \
	julia \
	graphviz \
	graphviz-dev

# Node.js is required for Jupyter Lab extension
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -
RUN apt-get install -y nodejs

# Install graph-tool and its dependencies
RUN echo "deb [ arch=amd64 ] https://downloads.skewed.de/apt hirsute main" >> /etc/apt/sources.list

RUN apt-key adv --no-tty --keyserver keys.openpgp.org --recv-key 612DEFB798507F25
# RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-key 612DEFB798507F25

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install --yes python3-pip

RUN DEBIAN_FRONTEND=noninteractive apt-get install --yes --no-install-recommends libcairo2-dev python3-gi python3-gi-cairo gir1.2-gtk-3.0
RUN DEBIAN_FRONTEND=noninteractive pip3 install pycairo

RUN apt-get install --yes --no-install-recommends python3-graph-tool python3-matplotlib

RUN pip3 install jupyterlab igraph ipycytoscape
RUN pip3 install networkx[default]
RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager

# Another network analysys lib (NetworkKit)
RUN pip3 install networkit snap-stanford ndex2 pyvis seaborn altair vega_datasets jupyter-dash pygraphviz

RUN jupyter lab build

RUN mkdir /home/notebooks

EXPOSE 8888
EXPOSE 6006

WORKDIR /home/notebooks
CMD [ "jupyter", "lab", "--allow-root", "--ip", "0.0.0.0"]
