
#FROM andrewosh/binder-base

FROM ubuntu:latest

#MAINTAINER Enric Tejedor Saavedra <enric.tejedor.saavedra@cern.ch>

USER root
RUN \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y byobu curl git htop man unzip vim wget


# Install ROOT prerequisites
RUN apt-get update
RUN apt-get install -y \
   # libx11-6 \
  #  libxext6 \
  #  libxft2 \
  #  libxpm4  \
    git \
    dpkg-dev \
    cmake \
    g++ \
    gcc \
    binutils \
    libx11-dev \
    libxpm-dev \
    libxft-dev \
    libxext-dev
    
    
#Install Pip
RUN apt-get install -y python2.7
RUN apt-get install -y python-pip
    
    
    
# Install ROOT additional libraries
RUN apt-get install -y \
    r-base \
    r-base-dev

# Install R packages
#RUN R -e "install.packages(c('Rcpp','RInside'), repos = \"http://cran.case.edu\")"

# Download and install ROOT master
WORKDIR /opt
RUN wget https://root.cern.ch/download/root_v6.08.06.source.tar.gz
#//root.cern.ch/notebooks/rootbinderdata/root.tar.gz 
RUN tar xzf root_v6.08.06.source.tar.gz
RUN rm root_v6.08.06.source.tar.gz

# Download and install Fastjet
#RUN wget http://root.cern.ch/notebooks/rootbinderdata/fastjet.tar.gz 
#RUN tar xzf fastjet.tar.gz
#RUN rm fastjet.tar.gz

#RUN apt-get install python2.7
#RUN apt-get install python-pip


#USER main

# Set ROOT environment
ENV ROOTSYS         "/opt/root-6.08.06"
ENV PATH            "$ROOTSYS/bin:$ROOTSYS/bin/bin:$PATH"
ENV LD_LIBRARY_PATH "$ROOTSYS/lib:$LD_LIBRARY_PATH"
ENV PYTHONPATH      "$ROOTSYS/lib:PYTHONPATH"

# Set ROOT environment for Fastjet
#ENV LD_LIBRARY_PATH "/opt/fastjet/lib:$LD_LIBRARY_PATH"
#ENV ROOT_INCLUDE_PATH "/opt/fastjet/include"

# Customise the ROOTbook #issues here
RUN pip install --upgrade pip
RUN pip install metakernel

ENV ChirSYS         "/opt/root-6.08.06"


RUN mkdir -p                                 $HOME/.ipython/kernels
RUN cp -r $ROOTSYS/etc/notebook/kernels/root $HOME/.ipython/kernels
RUN mkdir -p                                 $HOME/.ipython/profile_default/static
RUN cp -r $ROOTSYS/etc/notebook/custom       $HOME/.ipython/profile_default/static

ENV UDUDDUDUDUUDUDU         "/opt/root-6.08.06"
