#!/bin/bash
# GROMACS Trajectory Analysis Script
# Part of FBXO11 Computational Framework
#
# Analyzes MD trajectories following Supplementary Methods Section 5.4
#
# Requirements:
#   - GROMACS 2024.4
#   - Completed MD simulation (md.xtc, md.tpr)

GMX="gmx"
TRAJECTORY_DIR="$1"
OUTPUT_DIR="${TRAJECTORY_DIR}/analysis"

echo "========================================="
echo "GROMACS Trajectory Analysis"
echo "Trajectory: ${TRAJECTORY_DIR}"
echo "========================================="

# Create analysis output directory
mkdir -p ${OUTPUT_DIR}
cd ${TRAJECTORY_DIR}

# Analysis 1: RMSD (Backbone stability)
echo "Analysis 1: Calculating RMSD..."
echo "4 4" | ${GMX} rms \
    -s md.tpr \
    -f md.xtc \
    -o ${OUTPUT_DIR}/rmsd.xvg \
    -tu ns

# Analysis 2: RMSF (Per-residue flexibility)
echo "Analysis 2: Calculating RMSF..."
echo "1" | ${GMX} rmsf \
    -s md.tpr \
    -f md.xtc \
    -o ${OUTPUT_DIR}/rmsf.xvg \
    -res

# Analysis 3: Radius of gyration (Compactness)
echo "Analysis 3: Calculating radius of gyration..."
echo "1" | ${GMX} gyrate \
    -s md.tpr \
    -f md.xtc \
    -o ${OUTPUT_DIR}/gyrate.xvg

# Analysis 4: SASA (Surface exposure)
echo "Analysis 4: Calculating SASA..."
echo "1" | ${GMX} sasa \
    -s md.tpr \
    -f md.xtc \
    -o ${OUTPUT_DIR}/sasa.xvg

# Analysis 5: Hydrogen bonds
echo "Analysis 5: Calculating hydrogen bonds..."
echo "1 1" | ${GMX} hbond \
    -s md.tpr \
    -f md.xtc \
    -num ${OUTPUT_DIR}/hbond.xvg

echo "========================================="
echo "Analysis complete!"
echo "Output files in: ${OUTPUT_DIR}"
echo "  rmsd.xvg    - Backbone RMSD vs time"
echo "  rmsf.xvg    - Per-residue flexibility"
echo "  gyrate.xvg  - Radius of gyration"
echo "  sasa.xvg    - Solvent-accessible surface area"
echo "  hbond.xvg   - Hydrogen bond count"
echo "========================================="
echo ""
echo "Next steps:"
echo "  1. Extract mean values from XVG files"
echo "  2. Compare pathogenic vs benign variants"
echo "  3. Generate visualization plots"
