set -e
unset PATH
for p in $buildInputs; do
  export PATH=$p/bin${PATH:+:}$PATH
done

mkdir $out
cd $out

tar -xf $src

for d in *; do
  if [ -d "$d" ]; then
    cd "$d"
    break
  fi
done

for d in *; do
  if [ -d "$d" ]; then
    cd "$d"
    break
  fi
done

for d in *; do
  if [ -d "$d" ]; then
    cd "$d"
    break
  fi
done



# # ./configure --prefix=$out # need to define the steps on my own
# unset HOME
# export HOME=$(pwd)/build-home
# mkdir -p $HOME
# opam init -a
# opam install ounit --yes
node2nix -l package-lock.json
# npm install #--ignore-scripts
dune build
# make
# make install