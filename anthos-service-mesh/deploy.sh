#!/bin/bash

if [[ "${BASH_VERSINFO:-0}" -lt 4 ]]; then
  cat << EOF | color warn 
Warning: this component can be only installed on bash v4.0+

We cannot guarantee the correct work of anthos. To confirm successful installation please run

  kubectl get deploy -n istio-system -l app=istiod

TODO: We may consider to fail deployment at this stage! Moving on for now!

EOF
fi

curl -sLo "asmcli" "$ASMCLI_URL"

chmod +x asmcli

./asmcli install \
  --project_id "$PROJECT" \
  --cluster_name "$CLUSTER" \
  --cluster_location "$ZONE" \
  --enable_all

gcloud container clusters get-credentials "$CLUSTER" --zone "$ZONE"
kubectl config delete-context "$DOMAIN_NAME" > /dev/null 2>&1 
kubectl config rename-context gke_"$PROJECT"_"$ZONE"_"$CLUSTER" "$DOMAIN_NAME"

NAMESPACE="$(kubectl get namespace -l hub.gke.io/project)"
if test -z "$NAMESPACE"; then
  NAMESPACE="istio-system"
fi

ISTIO_REV=$(kubectl --context="$DOMAIN_NAME" get deploy -n istio-system -l app=istiod -o jsonpath=\{.items[*].metadata.labels.'istio\.io\/rev'\})

cat << EOF

Outputs:
  asm_rev = $ISTIO_REV

EOF
