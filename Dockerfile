
#FROM andrewosh/binder-base
#FROM aphecetche/root6
FROM andrewosh/binder-python-2.7
ARG version="6.12.06"

#MAINTAINER Enric Tejedor Saavedra <enric.tejedor.saavedra@cern.ch>
USER root
RUN conda env list
RUN conda list
RUN conda info
Run conda list
#Run conda install ROOT={6.04.08}
Run conda install -c anaconda jupyterlab
#RUN conda create --name=testenv root=6 python=3
Run conda list
#RUN conda update conda
#RUN conda install python=2.7.13

# Install ROOT prerequisites
RUN apt-get update
RUN apt-get install -y \
    libx11-6 \
    libxext6 \
    libxft2 \
    libxpm4
    
# Install ROOT additional libraries
RUN apt-get install -y \
    r-base \
    r-base-dev \
    git-all
    
ADD https://root.cern.ch/download/root_v${version}.Linux-ubuntu16-x86_64-gcc5.4.tar.gz /var/tmp/root.tar.gz
RUN tar xzf /var/tmp/root.tar.gz -C /opt && rm /var/tmp/root.tar.gz

USER main

# Set ROOT environment
ENV ROOTSYS         "/opt/root"
ENV PATH            "$ROOTSYS/bin:$ROOTSYS/bin/bin:$PATH"
ENV LD_LIBRARY_PATH "$ROOTSYS/lib:$LD_LIBRARY_PATH"
ENV PYTHONPATH      "$ROOTSYS/lib:PYTHONPATH"

# Set ROOT environment for Fastjet
#ENV LD_LIBRARY_PATH "/opt/fastjet/lib:$LD_LIBRARY_PATH"
#ENV ROOT_INCLUDE_PATH "/opt/fastjet/include"

# Customise the ROOTbook
#RUN pip install --upgrade pip
#RUN pip install metakernel
RUN mkdir -p                                 $HOME/.ipython/kernels
RUN cp -r $ROOTSYS/etc/notebook/kernels/root $HOME/.ipython/kernels
RUN mkdir -p                                 $HOME/.ipython/profile_default/static
RUN cp -r $ROOTSYS/etc/notebook/custom $HOME/.ipython/profile_default/static
