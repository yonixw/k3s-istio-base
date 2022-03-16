(kubectl apply -f create-user/serviceAccount.yaml || echo "Continue anyway...")

#XXX0
export ID=$GITPOD_WORKSPACE_ID 
#XX1
export URL_POSTFIX=${GITPOD_WORKSPACE_URL:8} 
#XXX2
export TOKEN=$(kubectl get secret $(kubectl get serviceAccount deploy-robot -o=jsonpath={.secrets[*].name}) -o jsonpath={.data.token} | base64 -d)

cat create-user/kubectl.template.yaml | \
    sed "s/XXX0/$ID/g" | \
    sed "s/XXX1/$URL_POSTFIX/g" | \
    sed "s/XXX2/$TOKEN/g" > deploy-robot.kubectl.yaml

echo "$(pwd)/deploy-robot.kubectl.yaml created!!"