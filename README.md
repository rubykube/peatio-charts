# Peatio Helm Charts

Official peatio.tech helm charts repository.

## How-to

### Adding this repo to helm

```bash
# add the repo
$ helm repo add peatio https://apps.peatio.com

# check for it
$ helm repo list
```

### Installing a single chart

```bash
# list all charts
$ helm search

# list only peatio charts
$ helm search peatio

# install a chart
$ helm install peatio/gerrit

# update repo index
$ helm repo update
```

### Contributing

```bash
# create base with helm
$ helm create stable/my-awesome-peatio-chart

# modify it
$ ...

# test changes locally
$ make index
$ helm install packages/my-awesome-chart-0.1.0.tgz

# deploy
$ make deploy
```
