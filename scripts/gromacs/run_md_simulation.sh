#!/bin/bash
# GROMACS Molecular Dynamics Simulation Script
# Part of FBXO11 Computational Framework
#
# This script performs MD simulations for FBXO11 variants
# following the protocol described in Supplementary Methods Section 5
#
# Requirements:
#   - GROMACS 2024.4 with CUDA support
#   - Input: PDB structure
#   - GPU: Recommended for production runs

# Configuration
GMX="gmx"  # or full path to gmx binary
INPUT_PDB="$1"
VARIANT_NAME="$2"
REPLICATE="$3"
OUTPUT_DIR="md_trajectories/${VARIANT_NAME}/rep${REPLICATE}"

# Simulation parameters
FORCE_FIELD="amber99sb-ildn"
WATER_MODEL="tip3p"
BOX_DISTANCE=1.0  # nm from protein to box edge
SALT_CONC=0.15    # 150 mM NaCl
TEMPERATURE=310   # K (physiological)
PRESSURE=1.0      # bar
MD_TIME=20000     # ps (20 ns)

echo "========================================="
echo "GROMACS MD Simulation for FBXO11"
echo "Variant: ${VARIANT_NAME}"
echo "Replicate: ${REPLICATE}"
echo "========================================="

# Create output directory
mkdir -p ${OUTPUT_DIR}
cd ${OUTPUT_DIR}

# Step 1: Generate topology
echo "Step 1: Generating topology..."
${GMX} pdb2gmx \
    -f ${INPUT_PDB} \
    -o protein.gro \
    -p topol.top \
    -ff ${FORCE_FIELD} \
    -water ${WATER_MODEL}

# Step 2: Define simulation box
echo "Step 2: Defining simulation box..."
${GMX} editconf \
    -f protein.gro \
    -o box.gro \
    -c \
    -d ${BOX_DISTANCE} \
    -bt cubic

# Step 3: Solvate system
echo "Step 3: Solvating system..."
${GMX} solvate \
    -cp box.gro \
    -cs spc216.gro \
    -o solvated.gro \
    -p topol.top

# Step 4: Add ions
echo "Step 4: Adding ions (${SALT_CONC} M NaCl)..."
${GMX} grompp \
    -f ions.mdp \
    -c solvated.gro \
    -p topol.top \
    -o ions.tpr
echo "SOL" | ${GMX} genion \
    -s ions.tpr \
    -o ions.gro \
    -p topol.top \
    -pname NA \
    -nname CL \
    -neutral \
    -conc ${SALT_CONC}

# Step 5: Energy minimization
echo "Step 5: Energy minimization..."
${GMX} grompp \
    -f em.mdp \
    -c ions.gro \
    -p topol.top \
    -o em.tpr
${GMX} mdrun \
    -deffnm em \
    -v

# Step 6: NVT equilibration (100 ps)
echo "Step 6: NVT equilibration (100 ps, ${TEMPERATURE} K)..."
${GMX} grompp \
    -f nvt.mdp \
    -c em.gro \
    -r em.gro \
    -p topol.top \
    -o nvt.tpr
${GMX} mdrun \
    -deffnm nvt \
    -v

# Step 7: NPT equilibration (100 ps)
echo "Step 7: NPT equilibration (100 ps, ${PRESSURE} bar)..."
${GMX} grompp \
    -f npt.mdp \
    -c nvt.gro \
    -r nvt.gro \
    -t nvt.cpt \
    -p topol.top \
    -o npt.tpr
${GMX} mdrun \
    -deffnm npt \
    -v

# Step 8: Production MD (20 ns)
echo "Step 8: Production MD (${MD_TIME} ps)..."
${GMX} grompp \
    -f md.mdp \
    -c npt.gro \
    -t npt.cpt \
    -p topol.top \
    -o md.tpr
${GMX} mdrun \
    -deffnm md \
    -v \
    -nb gpu

echo "========================================="
echo "MD simulation complete!"
echo "Output files:"
echo "  md.xtc  - Trajectory (3.6 GB, 2001 frames)"
echo "  md.tpr  - Run input (16 MB)"
echo "  md.edr  - Energy data (1.4 MB)"
echo "  md.log  - Simulation log (1.3 MB)"
echo "  md.gro  - Final structure (35 MB)"
echo "========================================="
