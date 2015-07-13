# Dockerized SonarQube with AEM Rules

FROM sonarqube
MAINTAINER Andriy Tarasenko <at@eggs.de>

ENV PLUGINS_PATH ${SONARQUBE_HOME}/extensions/plugins

# Upgrade SonarQube plugins
# - http://docs.sonarqube.org/display/PLUG/Plugin+Version+Matrix
# - http://www.sonarsource.com/category/plugins-news/
WORKDIR ${SONARQUBE_HOME}/lib/bundled-plugins
RUN \
  rm sonar-java-plugin-*.jar && \
  wget http://downloads.sonarsource.com/plugins/org/codehaus/sonar-plugins/java/sonar-java-plugin/3.3/sonar-java-plugin-3.3.jar && \
  rm sonar-scm-svn-plugin-*.jar && \
  wget http://downloads.sonarsource.com/plugins/org/codehaus/sonar-plugins/sonar-scm-svn-plugin/1.1/sonar-scm-svn-plugin-1.1.jar && \
  rm sonar-scm-git-plugin-*.jar && \
  wget http://downloads.sonarsource.com/plugins/org/codehaus/sonar-plugins/sonar-scm-git-plugin/1.1/sonar-scm-git-plugin-1.1.jar

# Add AEM Rules plugin https://github.com/Cognifide/AEM-Rules-for-SonarQube
ADD aemrules-0.4.jar $PLUGINS_PATH/aemrules.jar

WORKDIR $SONARQUBE_HOME