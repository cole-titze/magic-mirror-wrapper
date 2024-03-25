FROM arm64v8/alpine:latest as build-env

RUN apk add --no-cache git
RUN apk add --update nodejs npm
WORKDIR /repos
RUN git clone https://github.com/MagicMirrorOrg/MagicMirror
WORKDIR /repos/MagicMirror

RUN npm run install-mm
RUN cp ./config/config.js.sample ./config/config.js
RUN sed -i "s|8080|8082|g" ./config/config.js
RUN sed -i 's|\["127\.0\.0\.1", "::ffff:127\.0\.0\.1", "::1"\]|\[\]|g' ./config/config.js
RUN sed -i 's|localhost|0\.0\.0\.0|g' ./config/config.js

EXPOSE 8082

ENTRYPOINT ["npm", "run", "server"]