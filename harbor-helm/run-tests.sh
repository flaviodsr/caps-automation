#/bin/bash


release_name=$1
namespace=$2

helm3 test -n $namespace $release_name --timeout 30m &
P1=$!

test_pods=$(helm3 status -n $namespace $release_name -o json | jq -r .hooks[].name)
until kubectl exec -n $namespace $test_pods "--" ls /var/lib/harbor-test/report.html &> /dev/null; do
  sleep 1
done

for f in "report.html" "log.html"; do
  kubectl cp -n $namespace $test_pods:/var/lib/harbor-test/$f $f &> /dev/null
done

wait $P1
status=$?

for test_pod in $test_pods; do
  test_containers=$(kubectl -n $namespace get pod $test_pod -o json | jq -r .spec.containers[].name | tac)
  for test_container in $test_containers; do
    echo ""
    echo "#######################################################################"
    echo ""
    echo "Logs from pod/container: "
    echo "  $test_pod/$test_container"
    echo ""
    echo "#######################################################################"
    echo ""
    kubectl -n $namespace logs $test_pod -c $test_container
    echo ""
  done
done

echo "Report: report.html"

exit $status
