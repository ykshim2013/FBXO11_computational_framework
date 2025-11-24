#!/bin/bash
# FoldX Stability Analysis Script
# Part of FBXO11 Computational Framework
#
# This script performs FoldX stability analysis for FBXO11 variants
# following the protocol described in Supplementary Methods Section 3
#
# Requirements:
#   - FoldX 5.1 (academic license required)
#   - Input: PDB structures from AlphaFold3
#   - Output: ΔΔG values for variant stability prediction

# Configuration
FOLDX_BIN="/path/to/foldx"
INPUT_DIR="structures"
OUTPUT_DIR="results/foldx"
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

echo "Starting FoldX analysis for FBXO11 variants..."
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

            # Step 1: RepairPDB - Optimize structure
            echo "  Running RepairPDB..."
            ${FOLDX_BIN} --command=RepairPDB \
                --pdb="${INPUT_PDB}" \
                --output-dir="${OUTPUT_PATH}"

            # Step 2: PositionScan - Calculate ΔΔG
            echo "  Running PositionScan (${REPLICATES} replicates)..."
            ${FOLDX_BIN} --command=PositionScan \
                --pdb="${INPUT_PDB}" \
                --output-dir="${OUTPUT_PATH}" \
                --numberOfRuns=${REPLICATES}

            echo "  ✓ Completed ${SYSTEM_NAME}"
        done
    done
done

echo "FoldX analysis complete!"
echo "Results saved to: ${OUTPUT_DIR}"
echo ""
echo "Next steps:"
echo "  1. Extract ΔΔG values from output files"
echo "  2. Calculate median ± IQR for each system"
echo "  3. Aggregate results across seeds for variant-level statistics"
