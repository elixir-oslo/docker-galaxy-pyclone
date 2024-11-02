FROM quay.io/galaxyproject/galaxy-min:23.2.1

ARG SERVER_DIR

# switch to root
USER root

RUN apt-get -qq update && \
    apt-get install -y git pkg-config default-libmysqlclient-dev gcc

# Clone Pyclone-VI tools from GitHUb
RUN git clone https://github.com/jCHENEBY/galaxy-tool-pyclone-vi.git /galaxy/server/tools/pyclone_vi
RUN chown -R galaxy:galaxy /galaxy/server/tools/pyclone_vi

# Clone Cellular prevalence graph tools from GitHub
RUN git clone https://github.com/jCHENEBY/galaxy-tool-plot-cluster-prevalence.git /galaxy/server/tools/plot_clusters_prevalence
RUN chown -R galaxy:galaxy /galaxy/server/tools/plot_clusters_prevalence

# Clone Export timeline to cBioportal tools from GitHub
RUN git clone --branch v1.0.0 https://github.com/jCHENEBY/galaxy-tool-export-cbioportal-timeline.git /galaxy/server/tools/export_cbioportal_timeline
#COPY export_cbioportal_timeline /galaxy/server/tools/export_cbioportal_timeline/
RUN chown -R galaxy:galaxy /galaxy/server/tools/export_cbioportal_timeline

## Copy pyclone_vi tool
#COPY tools/pyclone_vi /galaxy/server/tools/pyclone_vi
#RUN chown -R galaxy:galaxy /galaxy/server/tools/pyclone_vi
#
## Copy Cellular prevalence graph tool
#COPY tools/plot_clusters_prevalence /galaxy/server/tools/plot_clusters_prevalence
#RUN chown -R galaxy:galaxy /galaxy/server/tools/plot_clusters_prevalence

COPY config/tool_conf.xml /galaxy/server/config/tool_conf.xml
RUN chown galaxy:galaxy /galaxy/server/config/tool_conf.xml

# Create database directory
RUN mkdir /database
RUN chown -R galaxy:galaxy /database

# Create a shared study directory
RUN mkdir /study
RUN chown 777 /study

# switch back to galaxy
USER galaxy

RUN sed -i 's/static_enabled\: false/static_enabled: true/' config/galaxy.yml
RUN sed -i 's/bind\: 0.0.0.0\:8080/bind: 0.0.0.0:8081/' config/galaxy.yml
RUN sed -i 's|tool_config_file: /galaxy/server/config/tool_conf.xml.sample|tool_config_file: /galaxy/server/config/tool_conf.xml|' config/galaxy.yml

# Configure Galaxy for external Docker volumes
RUN sed -i 's|data_dir: /galaxy/server/database|data_dir: /database|' config/galaxy.yml
RUN sed -i 's|^[[:space:]]*file_path:.*|#&|' config/galaxy.yml
RUN sed -i 's|^[[:space:]]*job_working_directory:.*|#&|' config/galaxy.yml
RUN sed -i 's|^[[:space:]]*tool_data_path:.*|#&|' config/galaxy.yml
RUN sed -i 's|^[[:space:]]*tool_dependency_dir:.*|#&|' config/galaxy.yml


# Setup PyClone
RUN pip install pandas matplotlib seaborn numpy scipy galaxy-lib numba dsnparse mysqlclient


