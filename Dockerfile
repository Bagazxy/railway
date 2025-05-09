FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    wget curl unzip xvfb x11-utils gnupg2 sudo \
    software-properties-common xfce4 desktop-base xscreensaver \
    dbus-user-session

# Tambahkan user
RUN useradd -m chromeuser && \
    usermod -a -G chrome-remote-desktop chromeuser && \
    echo "exec /usr/bin/xfce4-session" > /home/chromeuser/.chrome-remote-desktop-session && \
    chown chromeuser:chromeuser /home/chromeuser/.chrome-remote-desktop-session

# Install Chrome
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    dpkg -i google-chrome*.deb || apt --fix-broken install -y && \
    rm google-chrome*.deb

# Install CRD
RUN wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb && \
    dpkg -i chrome-remote-desktop*.deb || apt --fix-broken install -y && \
    rm chrome-remote-desktop*.deb

# Copy script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
