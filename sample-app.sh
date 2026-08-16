#!/bin/bash

rm -rf tempdir

mkdir -p tempdir/templates
mkdir -p tempdir/static

cp sample_app.py tempdir/.
cp -r templates/* tempdir/templates/.
cp -r static/* tempdir/static/.

cat > tempdir/Dockerfile <<'EOF'
FROM python:3.9-slim

RUN pip install --no-cache-dir --progress-bar off flask

COPY ./static /app/static/
COPY ./templates /app/templates/
COPY sample_app.py /app/

WORKDIR /app

EXPOSE 8888

CMD ["python", "sample_app.py"]
EOF

cd tempdir

docker build -t evaluacion2 .

docker rm -f evaluacion2 2>/dev/null || true

docker run -d \
    -p 8888:8888 \
    --name evaluacion2 \
    evaluacion2
