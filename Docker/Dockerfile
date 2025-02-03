# Use Alpine Linux as the base image
FROM alpine:3.16

# Define Nexus version and URLs
ENV NEXUS_VERSION=3.72.0-04 
ENV NEXUS_TARBALL_URL=https://download.sonatype.com/nexus/3/nexus-${NEXUS_VERSION}-unix.tar.gz \
    INSTALL4J_ADD_VM_PARAMS="-Xms1200m -Xmx1200m" \
    INSTALL4J_JAVA_HOME=/usr/lib/jvm/java-17-openjdk 

# Install dependencies including OpenJDK 11
RUN apk add --no-cache --update bash ca-certificates curl wget openjdk17-jre \
  && cd /tmp \
  && wget -O nexus.tar.gz $NEXUS_TARBALL_URL \
  && tar -xf nexus.tar.gz \
  && mkdir -p /opt/sonatype /opt/sonatype-work/nexus3/log /opt/sonatype-work/nexus3/tmp \
  && mv nexus-${NEXUS_VERSION} /opt/sonatype/nexus \
  && adduser -h /nexus-data -DH -s /sbin/nologin nexus \
  && chown -R nexus:nexus /opt/sonatype /opt/sonatype-work \
  && rm -rf /tmp/* /var/cache/apk/*

# Copy configuration and user creation script
COPY nexus-default.properties /opt/sonatype/nexus/etc/nexus-default.properties
COPY create-nexus-users.sh /opt/sonatype/create-nexus-users.sh
COPY entrypoint.sh /opt/sonatype/entrypoint.sh

# Fix permissions for necessary directories
RUN mkdir -p /nexus-data /opt/sonatype-work/nexus3/log /opt/sonatype-work/nexus3/tmp \
  && chown -R nexus:nexus /nexus-data /opt/sonatype-work /opt/sonatype

# Make the entrypoint script executable
RUN chmod +x /opt/sonatype/create-nexus-users.sh /opt/sonatype/entrypoint.sh

# Expose Nexus port
EXPOSE 8081

# Define volumes
VOLUME /nexus-data /opt/sonatype-work

# Set working directory
WORKDIR /opt/sonatype/nexus

# Set the user to non-root user (nexus)
USER nexus

# Use an entrypoint script to start Nexus
ENTRYPOINT ["/opt/sonatype/entrypoint.sh"]
