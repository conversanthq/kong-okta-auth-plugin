FROM mrsaints/kong-dev

WORKDIR /okta-auth

RUN luarocks install lua-cjson \
    && luarocks install basexx

COPY . .

RUN make install
