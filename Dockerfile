From ubuntu:14.04
MAINTAINER Jimmy Yang <gankkank@gmail.com>

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y openssh-server

RUN mkdir /var/run/sshd

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

RUN mkdir /root/.ssh
RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCvDPNhsFoE6EhnvgbqE6/l28+OBNWEaAngJW+uqML/X6mIrEGudA1gkywtKvXG8WOz+0XmesM7WZ9o9ML4xoqdo2oVHCExxUQJOykTG1HP1biTtqIR/wLt43yfkN95BKUABDP+vpEesuegEkrpEAhiWQi0mqkqAhxcayPfz2oyQAEuDUEKj3KkvNkY64CQyiZvwFgPWSSoTUvZY/Ar5302vzL0R8eKCpm7uPXCS7takF556O1V6vpyPACPUIMCSwB+wAKDHfRfVyqHcEyPbV4Q7WlK2AoKYzk1I+aOMVpq0hbr7h7EWWN3EYwA7Rid1Aytobxoixg1eVZ2Bf/yRgid" > /root/.ssh/authorized_keys


RUN touch /etc/default/locale
RUN locale-gen en_US.UTF-8
RUN echo "LC_ALL=en_US.UTF-8" >> /etc/default/locale
RUN echo "LANG=en_US.UTF-8" >> /etc/default/locale

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
