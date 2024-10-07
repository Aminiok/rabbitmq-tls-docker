FROM rabbitmq:4.0.2

# This explicit definition is required to monitor start in the init script later
# ENV RABBITMQ_PID_FILE /var/lib/rabbitmq/mnesia/rabbitmq

# Update package repos
RUN apt-get update

# Copy config file
COPY rabbitmq.conf /etc/rabbitmq/rabbitmq.conf

# Copy init script
RUN mkdir -p /home/myhome
COPY init.sh /home/myhome
RUN chmod +x /home/myhome/init.sh

# Expose ports and initialize
EXPOSE 5671
CMD ["/home/myhome/init.sh"]
