ENERGY_FILE="/sys/class/powercap/intel-rapl/intel-rapl:0/energy_uj"

# Read the energy value and calculate power over a 1-second interval
(
  E1=$(cat $ENERGY_FILE);
  T1=$(date +%s%N);
  sleep 1;
  E2=$(cat $ENERGY_FILE);
  T2=$(date +%s%N);

  # Calculate the difference in energy (microjoules) and time (nanoseconds)
  ENERGY_DIFF=$((E2 - E1));
  TIME_DIFF_S=$(echo "scale=3; ($T2 - $T1) / 1000000000" | bc);

  # Calculate Power in Watts: (Energy_diff / Time_diff) / 1,000,000
  POWER_W=$(echo "scale=3; ($ENERGY_DIFF / $TIME_DIFF_S) / 1000000" | bc);

  echo "Current CPU Power Draw: ${POWER_W} W"
)
