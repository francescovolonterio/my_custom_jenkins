FROM jenkins/jenkins
USER root
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
ENV CASC_JENKINS_CONFIG /var/jenkins_home/casc.yaml
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt
COPY casc.yaml /var/jenkins_home/casc.yaml
RUN curl -L https://github.com/OctopusDeploy/cli/raw/main/scripts/install.sh | bash
RUN mkdir -p /usr/share/dotnet
RUN curl -L https://dot.net/v1/dotnet-install.sh >> dotnetinstall.sh
RUN chmod 777 dotnetinstall.sh
RUN ./dotnetinstall.sh --version latest --install-dir /usr/share/dotnet
RUN chmod -R 777 /usr/share/dotnet
RUN ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet
RUN apt-get update
RUN apt-get install -y libicu-dev
