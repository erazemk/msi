FROM jojomi/hugo AS build

COPY html /website
RUN hugo -s /website

FROM nginx:alpine

COPY --from=build /website/public /usr/share/nginx/html