FROM quay.io/galaxyproject/galaxy-min:24.2.3

ARG SERVER_DIR

# switch to root
USER root

RUN apt-get -qq update && \
    apt-get install -y git pkg-config default-libmysqlclient-dev gcc ca-certificates mercurial 

# Clone Pyclone-VI tools from GitHUb
RUN git clone https://github.com/elixir-oslo/galaxy-tool-pyclone-vi.git /galaxy/server/tools/pyclone_vi
RUN chown -R galaxy:galaxy /galaxy/server/tools/pyclone_vi

# Clone Cellular prevalence graph tools from GitHub
RUN git clone --branch v1.2.3 https://github.com/elixir-oslo/galaxy-tool-plot-cluster-prevalence.git /galaxy/server/tools/plot_clusters_prevalence
#COPY plot_clusters_prevalence /galaxy/server/tools/plot_clusters_prevalence/
RUN chown -R galaxy:galaxy /galaxy/server/tools/plot_clusters_prevalence

# Clone Export timeline to cBioportal tools from GitHub
RUN git clone https://github.com/elixir-oslo/galaxy-tool-export-cbioportal-timeline.git /galaxy/server/tools/export_cbioportal_timeline
#COPY export_cbioportal_timeline /galaxy/server/tools/export_cbioportal_timeline/
RUN chown -R galaxy:galaxy /galaxy/server/tools/export_cbioportal_timeline

# Clone Export image to cBioportal tools from GitHub
RUN git clone https://github.com/elixir-oslo/galaxy-tool-export-cbioportal-image.git /galaxy/server/tools/export_cbioportal_image
#COPY export_cbioportal_image /galaxy/server/tools/export_cbioportal_image/
RUN chown -R galaxy:galaxy /galaxy/server/tools/export_cbioportal_image

# Clone Query tabular from IUC
RUN hg clone https://toolshed.g2.bx.psu.edu/repos/iuc/query_tabular /galaxy/server/tools/query_tabular
RUN chown -R galaxy:galaxy /galaxy/server/tools/query_tabular

# Copy CT scan tools from GitHub
RUN git clone https://github.com/elixir-oslo/galaxy-tool-eosc4canccer-2.2.git /galaxy/server/tools/ct_scan
# COPY galaxy-tool-eosc4canccer-2.2 /galaxy/server/tools/ct_scan
RUN chown -R galaxy:galaxy /galaxy/server/tools/ct_scan

# Clone XNAT tools from GitLab at the develop branch and commit 9337b9bb3f1e37e81b2698dbcf82aa07c5d6ba96
RUN git clone --branch develop https://gitlab.com/radiology/infrastructure/resources/galaxy_xnat_tool.git /galaxy/server/tools/xnat && \
    cd /galaxy/server/tools/xnat && \
    git checkout 9337b9bb3f1e37e81b2698dbcf82aa07c5d6ba96
    
# COPY galaxy_xnat_tool /galaxy/server/tools/xnat
RUN chown -R galaxy:galaxy /galaxy/server/tools/xnat

## Copy pyclone_vi tool
#COPY tools/pyclone_vi /galaxy/server/tools/pyclone_vi
#RUN chown -R galaxy:galaxy /galaxy/server/tools/pyclone_vi
#
## Copy Cellular prevalence graph tool
#COPY tools/plot_clusters_prevalence /galaxy/server/tools/plot_clusters_prevalence
#RUN chown -R galaxy:galaxy /galaxy/server/tools/plot_clusters_prevalence

COPY config/tool_conf.xml /galaxy/server/config/tool_conf.xml
RUN chown galaxy:galaxy /galaxy/server/config/tool_conf.xml

COPY config/galaxy.yml /galaxy/server/config/galaxy.yml
RUN chown galaxy:galaxy /galaxy/server/config/galaxy.yml

COPY config/user_preferences_extra_conf.yml /galaxy/server/config/user_preferences_extra_conf.yml
RUN chown galaxy:galaxy /galaxy/server/config/user_preferences_extra_conf.yml

# Create database directory
RUN mkdir /database
RUN chown -R galaxy:galaxy /database

# Create a shared config directory
RUN mkdir /config
RUN chown -R galaxy:galaxy /config

# Create a shared study directory
RUN mkdir /study
RUN chown 777 /study

# Import the entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN  chmod +x /entrypoint.sh
RUN  chown galaxy:galaxy /entrypoint.sh


# switch back to galaxy
USER galaxy
ENV HOME=/galaxy

# Install miniforge
RUN mkdir -p /galaxy/miniconda3
RUN curl -o /galaxy/miniconda3/miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN bash /galaxy/miniconda3/miniconda.sh -b -u -p /galaxy/miniconda3
RUN rm /galaxy/miniconda3/miniconda.sh
# RUN source /galaxy/miniconda3/bin/activate
# RUN conda init --all


# RUN sed -i 's/static_enabled\: false/static_enabled: true/' config/galaxy.yml
# RUN sed -i 's/bind\: 0.0.0.0\:8080/bind: 0.0.0.0:8081/' config/galaxy.yml
# RUN sed -i 's|tool_config_file: /galaxy/server/config/tool_conf.xml.sample|tool_config_file: /galaxy/server/config/tool_conf.xml|' config/galaxy.yml

# # Configure Galaxy for external Docker volumes
# RUN sed -i 's|data_dir: /galaxy/server/database|data_dir: /database|' config/galaxy.yml
# RUN sed -i 's|^[[:space:]]*file_path:.*|#&|' config/galaxy.yml
# RUN sed -i 's|^[[:space:]]*job_working_directory:.*|#&|' config/galaxy.yml
# RUN sed -i 's|^[[:space:]]*tool_data_path:.*|#&|' config/galaxy.yml
# RUN sed -i 's|^[[:space:]]*tool_dependency_dir:.*|#&|' config/galaxy.yml


# Setup PyClone
RUN pip install pandas matplotlib seaborn numpy scipy galaxy-lib numba dsnparse mysqlclient python-dotenv




