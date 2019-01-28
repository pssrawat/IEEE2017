source setup.sh

for d in */ ; do
    ( cd "$d" && source run.sh )
done
