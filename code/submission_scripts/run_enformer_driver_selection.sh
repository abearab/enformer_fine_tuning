eval "$(/pollard/home/sdrusinsky/miniforge3/bin/conda shell.bash hook)"
source /pollard/home/sdrusinsky/miniforge3/bin/activate test_pt231

cd "$(dirname "${BASH_SOURCE[0]}")" #cd into the directory containing this script
cd .. #cd into `code` directory

script_path=./select_drivers_enformer.py
for driver_method in "forward_selection_with_only_drivers" "forward_selection"; do
    python $script_path --driver_method $driver_method
done