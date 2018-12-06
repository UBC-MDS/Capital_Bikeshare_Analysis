# Docker file for Captial_Bikeshare_Analysis
# Mike Yuan and Evan Yathon

# use rocker/tidyverse as base
From rocker/tidyverse

# install R pakcage
# lubridate
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
  && install2.r --error \
    --deps TRUE \
    lubridate
# rmarkdown
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
  && install2.r --error \
    --deps TRUE \
    rmarkdown

# pracma
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
  && install2.r --error \
    --deps TRUE \
    pracma

# Install python 3
RUN apt-get update \
  && apt-get install -y python3-pip python3-dev \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 install --upgrade pip

RUN apt-get install -y python3-tk

# install numpy, pandas, and matpotlib
RUN pip3 install numpy
RUN pip3 install pandas
RUN pip3 install sklearn
RUN pip3 install pydotplus
RUN pip3 install graphviz
RUN pip3 install seaborn
Run pip3 install ipython
RUN pip3 install tqdm
RUN apt-get update && \
    pip3 install matplotlib && \
    rm -rf /var/lib/apt/lists/*


# install graphviz
# pracma
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
    graphviz
