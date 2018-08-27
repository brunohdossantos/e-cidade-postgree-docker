FROM postgres:9.5

RUN apt-get update && apt-get install -y curl

RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i pt_BR -c -f ISO-8859-1 -A /usr/share/locale/locale.alias pt_BR

COPY pt_BR /usr/share/i18n/locales/pt_BR

RUN localedef -i de_DE -c -f ISO-8859-1 -A /usr/share/i18n/locales/pt_BR pt_BR.ISO-8859-1
ENV LANG pt_BR.ISO-8859-1
RUN export LC_ALL=pt_BR
RUN echo LC_ALL=pt_BR >> /etc/environment

RUN chmod 777 /var/lib/postgresql/data



#RUN apt -y install language-pack-gnome-pt language-pack-pt-base myspell-pt myspell-pt-br wbrazilian wportuguese

#RUN apt-get update && apt-get install -y curl

#RUN apt-get install -y locales

#RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
#	&& localedef -i pt_BR -c -f ISO-8859-1 -A /usr/share/locale/locale.alias pt_BR.ISO-8859-1

#RUN export LANG=pt_BR.ISO-8859-1

#ENV LANG pt_BR.ISO-8859-1

#COPY pt_BR /usr/share/i18n/locales/pt_BR


#RUN localedef -i pt_BR -c -f UTF-8 -A /usr/share/locale/locale.alias pt_BR.utf-8
#RUN localedef -i pt_BR -c -f ISO-8859-1 -A /usr/share/locale/locale.alias pt_BR
#RUN locale-gen pt_BR.utf-8

#RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
#    && localedef -i pt_BR -c -f ISO-8859-1 -A /usr/share/locale/locale.alias pt_BR

#RUN locale-gen --purge pt_BR.ISO-8859-1

#RUN echo -e 'LANG="pt_BR.ISO-8859-1"\nLANGUAGE="pt_BR:pt"\n' > /etc/default/locale

#ENV LANG pt_BR.ISO-8859-1

#RUN export LC_CTYPE=pt_BR.ISO-8859-1

#RUN dpkg-reconfigure locales -force

COPY postgresql.conf /setup/postgresql.conf

COPY entrypoint/config-db.sh /docker-entrypoint-initdb.d/
COPY entrypoint/config-roles.sql /docker-entrypoint-initdb.d/
COPY entrypoint/vacuum.sql /docker-entrypoint-initdb.d/

RUN chmod +x /docker-entrypoint-initdb.d/config-db.sh

RUN curl -SL https://github.com/myersBR/e-cidade-postgree-docker/releases/download/2018/e-cidade20182.tar.gz | tar -xz -C /docker-entrypoint-initdb.d/