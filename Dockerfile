FROM quay.io/galaxyproject/galaxy-min:23.2.1

ARG SERVER_DIR

# switch to root
USER root

RUN apt-get -qq update


# Copy pyclone_vi tool
COPY tools/pyclone_vi /galaxy/server/tools/pyclone_vi
RUN chown -R galaxy:galaxy /galaxy/server/tools/pyclone_vi

# Copy Cellular prevalence graph tool
COPY tools/plot_clusters_prevalence /galaxy/server/tools/plot_clusters_prevalence
RUN chown -R galaxy:galaxy /galaxy/server/tools/plot_clusters_prevalence

COPY config/tool_conf.xml /galaxy/server/config/tool_conf.xml
RUN chown galaxy:galaxy /galaxy/server/config/tool_conf.xml

# switch back to galaxy
USER galaxy

RUN sed -i 's/static_enabled\: false/static_enabled: true/' config/galaxy.yml
RUN sed -i 's/bind\: 0.0.0.0\:8080/bind: 0.0.0.0:8081/' config/galaxy.yml
RUN sed -i 's|tool_config_file: /galaxy/server/config/tool_conf.xml.sample|tool_config_file: /galaxy/server/config/tool_conf.xml|' config/galaxy.yml


# Setup Py_clone
RUN pip install pandas matplotlib seaborn numpy scipy galaxy-lib numba


