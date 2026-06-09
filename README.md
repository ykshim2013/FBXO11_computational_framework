# FBXO11 Computational Framework

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Computational stability analysis suggesting binding-independent destabilization in pathogenic *FBXO11* variants.

## 📄 Publication

**Title:** Computational stability analysis suggests binding-independent destabilization in pathogenic FBXO11 variants

**Authors:** Youngkyu Shim¹,*, Eungu Kang², Suhyun Kim³,⁴

**Affiliations:**
1. Division of Pediatric Neurology, Department of Pediatrics, Korea University Ansan Hospital, Korea University College of Medicine, Ansan, Gyeonggi-do, Republic of Korea
2. Division of Medical Genetics, Department of Pediatrics, Korea University Ansan Hospital, Korea University College of Medicine, Ansan, Gyeonggi-do, Republic of Korea
3. Department of Convergence Medicine, College of Medicine, Korea University, Seoul, Republic of Korea
4. Zebrafish Translational Medical Research Center, Korea University, Ansan, Gyeonggi-do, Republic of Korea

**Journal:** *Scientific Reports* (accepted, 2026)

## 🔬 Overview

This repository provides **complete computational protocols** and **example scripts** for evaluating the pathogenicity of *FBXO11* missense variants through multi-method stability analysis.

### Key Methods

1. **Multi-conformational stability analysis** using FoldX and Rosetta
2. **AlphaFold3 ensemble generation** for structural diversity sampling
3. **Molecular dynamics simulations** for temporal stability assessment
4. **Statistical frameworks** for variant-level pathogenicity discrimination

### Dataset Summary

- **Variants analyzed:** 44 (23 pathogenic, 21 benign)
- **Structural conformations:** 3 AlphaFold3 seeds per variant
- **Biological contexts:** 2 (monomer, FBXO11-SKP1 complex)
- **Total systems:** 264 Rosetta / 270 FoldX (44 variants × 3 seeds × 2 contexts)
- **MD simulations:** 5 variants × 3 replicates × 20 ns = 300 ns total

## 📁 Repository Structure

```
FBXO11_computational_framework/
├── README.md                    # This file
├── LICENSE                      # MIT License
├── docs/
│   └── METHODS.md              # Complete Supplementary Methods
│
├── scripts/
│   ├── foldx/
│   │   └── run_foldx_analysis.sh        # FoldX stability analysis
│   ├── rosetta/
│   │   └── run_rosetta_ddg.sh           # Rosetta cartesian ddG
│   └── gromacs/
│       ├── run_md_simulation.sh         # MD simulation protocol
│       └── analyze_trajectory.sh        # Trajectory analysis
│
└── data/
    └── variant_list.txt        # List of analyzed variants
```

## 🚀 Quick Start

### Prerequisites

**Required Software:**
- **FoldX 5.1** (academic license: http://foldxsuite.crg.eu/)
- **Rosetta 2023.49** (academic license: https://www.rosettacommons.org/)
- **GROMACS 2024.4** (open source: https://www.gromacs.org/)
- **AlphaFold3 Server** access (https://alphafoldserver.com)

**System Requirements:**
- macOS or Linux operating system
- GPU recommended for MD simulations (NVIDIA with CUDA support or Apple Silicon)
- Multi-core CPU for parallel FoldX/Rosetta analysis
- ~100 GB storage for complete analysis

**Development Platform:**
- Apple Mac Studio (macOS; Apple M4 Max, 16 cores, 64 GB RAM)
- Cloud infrastructure for GPU-accelerated MD simulations

### Installation

1. Clone this repository:
```bash
git clone https://github.com/ykshim2013/FBXO11_computational_framework.git
cd FBXO11_computational_framework
```

2. Install required software (see Prerequisites above)

3. Configure paths in scripts:
```bash
# Edit scripts to set software paths
vi scripts/foldx/run_foldx_analysis.sh     # Set FOLDX_BIN
vi scripts/rosetta/run_rosetta_ddg.sh      # Set ROSETTA_BIN
vi scripts/gromacs/run_md_simulation.sh    # Set GMX path
```

## 📖 Usage

### 1. AlphaFold3 Structure Prediction

Generate structural ensemble using [AlphaFold3 Server](https://alphafoldserver.com):

- Submit FBXO11 sequence (UniProt Q86XK2, 919 amino acids)
- Generate both monomer and FBXO11-SKP1 complex structures
- Select 3 diverse conformational seeds based on pairwise RMSD (>19 Å separation)

See [`docs/METHODS.md`](docs/METHODS.md) Section 2 for detailed protocol.

### 2. FoldX Stability Analysis

Run FoldX analysis for all variant-seed-context combinations:

```bash
cd scripts/foldx
./run_foldx_analysis.sh
```

**Protocol:**
- RepairPDB for structure optimization
- PositionScan for ΔΔG calculation (10 replicates per system)
- Calculate median ± IQR for each system

See [`docs/METHODS.md`](docs/METHODS.md) Section 3 for detailed protocol.

### 3. Rosetta Cartesian ddG Analysis

Run Rosetta analysis for all systems:

```bash
cd scripts/rosetta
./run_rosetta_ddg.sh
```

**Protocol:**
- Pre-minimization with weak constraints (3 cycles)
- Cartesian ddG calculation (10 replicates per system)
- Calculate mean ± SD for each system

See [`docs/METHODS.md`](docs/METHODS.md) Section 4 for detailed protocol.

### 4. Molecular Dynamics Simulations

Run MD simulation for a specific variant:

```bash
cd scripts/gromacs
./run_md_simulation.sh path/to/structure.pdb D910G 1
```

Then analyze the trajectory:

```bash
./analyze_trajectory.sh md_trajectories/D910G/rep1
```

**Protocol:**
- AMBER99SB-ILDN force field with TIP3P water
- NPT ensemble (310 K, 1 bar, physiological conditions)
- 20 ns per replicate × 3 replicates per variant

See [`docs/METHODS.md`](docs/METHODS.md) Section 5 for detailed protocol.

For all reported results, statistical comparisons, ROC analyses, MD trajectories, and the normal-binding subgroup analysis, see the published article and its supplementary materials. This repository provides the methodology and scripts required to reproduce the computational pipeline; the article is the canonical source of the numerical results.

## 📦 Data Availability

### Included in Repository
- Complete computational protocols (Supplementary Methods)
- Example analysis scripts for FoldX, Rosetta, and GROMACS
- Variant classification list

### Manuscript Supplementary Materials
- **S1 Table:** AlphaFold3 structural quality metrics
- **S2 Table:** Complete variant dataset with FoldX and Rosetta ΔΔG values

### Available Upon Request
- MD trajectory files (~55 GB total)
- AlphaFold3 structural models (reproducible via AlphaFold Server)
- Contact: ykshim2013@gmail.com

## 🔧 Computational Methods Summary

| Method | Software | Protocol | Replicates | Statistic |
|--------|----------|----------|------------|-----------|
| **Structure Prediction** | AlphaFold3 | Default settings | 5 ranks/context | pLDDT quality |
| **FoldX** | FoldX 5.1 | RepairPDB + PositionScan | 10/system | Median ± IQR |
| **Rosetta** | Rosetta 2023.49 | cartesian_ddg | 10/system | Mean ± SD |
| **MD Simulation** | GROMACS 2024.4 | NPT, 310 K, 1 bar | 3/variant | Mean ± SD |

### Statistical Analysis
- **Variant-level analysis:** Aggregate across 3 structural seeds (n=88 variant-context pairs)
- **FoldX:** Mann-Whitney U test (non-parametric)
- **Rosetta:** Welch's t-test (parametric)
- **Effect size:** Cohen's d with 95% CI via bootstrap
- **ROC analysis:** Combined logistic regression with DeLong's method for CI

## 📚 Citation

If you use this computational framework, please cite:

```bibtex
@article{shim2026fbxo11,
  title={Computational stability analysis suggests binding-independent
         destabilization in pathogenic FBXO11 variants},
  author={Shim, Youngkyu and Kang, Eungu and Kim, Suhyun},
  journal={Scientific Reports},
  year={2026}
}
```

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Contact

**Corresponding Author:** Youngkyu Shim, M.D.
**Institution:** Korea University Ansan Hospital, Korea University College of Medicine
**Email:** ykshim2013@gmail.com
**ORCID:** 0000-0002-3414-4702

## 🙏 Acknowledgments

- AlphaFold team for academic access to AlphaFold3
- FoldX and Rosetta development teams for academic licenses
- GROMACS development team for open-source MD software

## 🔗 Related Resources

- [AlphaFold Server](https://alphafoldserver.com)
- [FoldX](http://foldxsuite.crg.eu/)
- [Rosetta Commons](https://www.rosettacommons.org/)
- [GROMACS](https://www.gromacs.org/)
- [ClinVar](https://www.ncbi.nlm.nih.gov/clinvar/)

---

**Keywords:** FBXO11, protein stability, missense variants, neurodevelopmental disorder, AlphaFold3, computational structural biology, SCF ubiquitin ligase, variant pathogenicity
