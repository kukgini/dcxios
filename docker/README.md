```
docker run --mount type=bind,source=$(pwd)/dcx.json,target=/data,readonly -p 3000:3000 mockoon/cli:latest --data data --port 3000
```
