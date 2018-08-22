FROM postgres:9.5

#RUN apt -y install language-pack-gnome-pt language-pack-pt-base myspell-pt myspell-pt-br wbrazilian wportuguese

RUN apt-get update && apt-get install -y curl

COPY pt_BR /usr/share/i18n/locales/pt_BR

RUN localedef -i pt_BR -c -f ISO-8859-1 -A /usr/share/locale/locale.alias pt_BR
RUN locale-gen pt_BR
RUN dpkg-reconfigure locales
#RUN localedef -i de_DE -c -f ISO-8859-1 -A /usr/share/i18n/locales/pt_BR pt_BR.ISO-8859-1
#ENV LANG pt_BR.ISO-8859-1
#RUN export LC_ALL=pt_BR
#RUN echo LC_ALL=pt_BR >> /etc/environment

COPY postgresql.conf /setup/postgresql.conf

COPY entrypoint/config-db.sh /docker-entrypoint-initdb.d/
COPY entrypoint/config-roles.sql /docker-entrypoint-initdb.d/
COPY entrypoint/vacuum.sql /docker-entrypoint-initdb.d/

RUN curl -SL https://github.com/myersBR/e-cidade-postgree-docker/releases/download/2018/e-cidade20182.tar.gz | tar -xz -C /docker-entrypoint-initdb.d/