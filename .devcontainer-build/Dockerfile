# Build locally as: docker buildx build --build-arg BASE_IMAGE=codespacesx --load -t codespacesx-phylogenetics .
# syntax=docker/dockerfile:1

##############
# BASE IMAGE #
##############
ARG BASE_IMAGE=ghcr.io/oxford-lifelong-learning/codespacesx:latest
FROM ${BASE_IMAGE}

################
# INSTALLATION #
################

WORKDIR /tmp

# BEAST
RUN wget https://github.com/beast-dev/beast-mcmc/releases/download/v1.10.5pre_thorney_v0.1.2/BEASTv1.10.5pre_thorney_0.1.2.tgz \
  && tar -xzvf BEASTv1.10.5pre_thorney_0.1.2.tgz \
  && mv /tmp/BEASTv1.10.5pre_thorney_0.1.2/bin/* /usr/local/bin/ \
  && mv /tmp/BEASTv1.10.5pre_thorney_0.1.2/lib/* /usr/local/lib/ \
  && rm -rf /tmp/BEASTv1.10.5pre_thorney_0.1.2 BEASTv1.10.5pre_thorney_0.1.2.tgz

# Figtree
RUN wget https://github.com/rambaut/figtree/releases/download/v1.4.4/FigTree_v1.4.4.tgz \
  && tar -xzvf FigTree_v1.4.4.tgz \
  && mv /tmp/FigTree_v1.4.4/bin/* /usr/local/bin/ \
  && mv /tmp/FigTree_v1.4.4/lib/* /usr/local/lib/ \
  && chmod +x /usr/local/bin/figtree \
  && sed -i 's+lib+/usr/local/lib+' /usr/local/bin/figtree \
  && rm -rf /tmp/FigTree_v1.4.4 FigTree_v1.4.4.tgz

# ClonalFrameML
RUN git clone --depth 1 https://github.com/xavierdidelot/ClonalFrameML.git /tmp/ClonalFrameML \
  && cd /tmp/ClonalFrameML/src \
  && make \
  && mv /tmp/ClonalFrameML/src/ClonalFrameML /usr/local/bin/ \
  && mv /tmp/ClonalFrameML/src/cfml_results.R /usr/local/bin/ \
  && rm -rf /tmp/ClonalFrameML

# TempEst
RUN wget https://github.com/beast-dev/Tempest/releases/download/v1.5.3/TempEst_v1.5.3.tgz \
  && tar -xzvf TempEst_v1.5.3.tgz \
  && mv /tmp/TempEst_v1.5.3/bin/* /usr/local/bin/ \
  && mv /tmp/TempEst_v1.5.3/lib/* /usr/local/lib/ \
  && chmod +x /usr/local/bin/tempest \
  && rm -rf /tmp/TempEst_v1.5.3 TempEst_v1.5.3.tgz

# Tracer
RUN wget https://github.com/beast-dev/tracer/releases/download/v1.7.1/Tracer_v1.7.1.tgz \
  && tar -xzvf Tracer_v1.7.1.tgz \
  && mv /tmp/Tracer_v1.7.1/bin/* /usr/local/bin/ \
  && mv /tmp/Tracer_v1.7.1/lib/* /usr/local/lib/ \
  && chmod +x /usr/local/bin/tracer \
  && rm -rf /tmp/Tracer_v1.7.1 Tracer_v1.7.1.tgz

# Jalview, MAFFT and PhyML
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    jalview mafft phyml \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

#####################
# MIGRATE RESOURCES #
#####################

# Migrate codespacesx directory contents (NB: overwrites if name conflicts exist)
COPY --chown=${UID}:${GID} ./codespacesx /tmp/codespacesx
RUN mkdir -p /opt/codespacesx/apps.d \
  && mkdir -p /opt/codespacesx/post-entry \
  && cp -a /tmp/codespacesx/apps.d/*.json /opt/codespacesx/apps.d/ \
  && cp -a /tmp/codespacesx/post-create.sh /opt/codespacesx/post-create.sh \
  && cp -a /tmp/codespacesx/post-entry/* /opt/codespacesx/post-entry/ \
  && rm -rf /tmp/codespacesx \
  && chmod -R a+rX /opt/codespacesx \
  && chmod 0755 /opt/codespacesx/post-create.sh

# Register apps as Xpra floating menu entries
COPY ./usr/share/applications/*.desktop /usr/share/applications/
RUN chmod 0644 /usr/share/applications/*.desktop

##########
# DEPLOY #
##########

WORKDIR /home/${USERNAME}

# Use default entrypoint and cmd from codespacesx

# Run locally as:
#   mkdir -p ~/Downloads/teaching-phylogenetics && docker run --publish 14500:14500 --publish 8000:8000 --name codespacesx --rm -v ~/Downloads/teaching-phylogenetics:/home/ubuntu/work -v ~/Documents/GitHub/codespacesx-phylogenetics:/workspaces/codespacesx-phylogenetics -e JUPYTER_LAB_ROUTE="/jupyter/lab/tree/work/practical/practical.ipynb" codespacesx-phylogenetics
# Access it using your browser at: http://localhost:14500/
