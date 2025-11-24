#!/bin/bash
# Rosetta Cartesian ddG Analysis Script
# Part of FBXO11 Computational Framework
#
# This script performs Rosetta cartesian_ddg stability analysis
# following the protocol described in Supplementary Methods Section 4
#
# Requirements:
#   - Rosetta 2023.49 (academic license required)
#   - Input: PDB structures from AlphaFold3
#   - Output: ΔΔG values for variant stability prediction

# Configuration
ROSETTA_BIN="/path/to/rosetta_scripts.default.linuxgccrelease"
ROSETTA_DB="/path/to/rosetta/database"
INPUT_DIR="structures"
OUTPUT_DIR="results/rosetta"
REPLICATES=10

# Variant list (example)
VARIANTS=(
    "A112V"
    "R138G"
    "K135R"
    "D910G"
    # Add more variants as needed
)

# System types
SYSTEMS=("monomer" "complex")
SEEDS=("seed1" "seed2" "seed3")

echo "Starting Rosetta cartesian_ddg analysis for FBXO11 variants..."
echo "Replicates per system: ${REPLICATES}"

# Loop through each variant, system type, and seed
for variant in "${VARIANTS[@]}"; do
    for system in "${SYSTEMS[@]}"; do
        for seed in "${SEEDS[@]}"; do

            SYSTEM_NAME="${system}_${variant}_${seed}"
            INPUT_PDB="${INPUT_DIR}/${SYSTEM_NAME}.pdb"
            OUTPUT_PATH="${OUTPUT_DIR}/${SYSTEM_NAME}"

            echo "Processing: ${SYSTEM_NAME}"

            # Create output directory
            mkdir -p "${OUTPUT_PATH}"

            # Extract mutation position from variant (example: A112V -> position 112)
            POSITION=$(echo ${variant} | sed 's/[A-Z]//g')
            MUTANT_AA=$(echo ${variant} | sed 's/[0-9]*//g' | tail -c 2)

            # Step 1: Pre-minimization (3 cycles)
            echo "  Running pre-minimization..."
            ${ROSETTA_BIN} \
                -database ${ROSETTA_DB} \
                -s ${INPUT_PDB} \
                -out:path:all ${OUTPUT_PATH} \
                -parser:protocol cartesian_relax.xml \
                -nstruct 3 \
                -relax:cartesian \
                -beta

            # Step 2: Cartesian ddG calculation
            echo "  Running cartesian_ddg (${REPLICATES} replicates)..."
            ${ROSETTA_BIN} \
                -database ${ROSETTA_DB} \
                -s ${OUTPUT_PATH}/relaxed_*.pdb \
                -out:path:all ${OUTPUT_PATH} \
                -parser:protocol cartesian_ddg.xml \
                -ddg::mut_file ${OUTPUT_PATH}/mutations.txt \
                -ddg:weight_file ref2015 \
                -ddg:iterations ${REPLICATES} \
                -ddg:dump_pdbs false \
                -ddg:cartesian

            echo "  ✓ Completed ${SYSTEM_NAME}"
        done
    done
done

echo "Rosetta analysis complete!"
echo "Results saved to: ${OUTPUT_DIR}"
echo ""
echo "Next steps:"
echo "  1. Extract ΔΔG values from score files"
echo "  2. Calculate mean ± SD for each system"
echo "  3. Aggregate results across seeds for variant-level statistics"
