# Supplementary Methods

## Abbreviations

- **ΔΔG**: Change in folding free energy upon mutation (kcal/mol)
- **RMSD**: Root mean square deviation (nm)
- **RMSF**: Root mean square fluctuation (nm)
- **SASA**: Solvent-accessible surface area (nm²)
- **pLDDT**: Predicted local distance difference test (AlphaFold3 confidence metric, 0-100 scale)
- **ROC**: Receiver operating characteristic
- **AUC**: Area under the curve
- **MD**: Molecular dynamics
- **IQR**: Interquartile range
- **SD**: Standard deviation

## 1. Variant Dataset Assembly and Clinical Validation

### 1.1 Pathogenic Variant Curation

Pathogenic variants were identified through systematic search of multiple clinical and genomic databases:

- **ClinVar Database**: Accessed September 2025, filtered for FBXO11 (Gene ID: 80317) missense variants classified as "Pathogenic" or "Likely Pathogenic" with review status ≥1 star
- **Published Literature**: Comprehensive PubMed search using terms "FBXO11 AND (pathogenic OR mutation OR variant)" covering publications from 2018–2025
- **Clinical Case Reports**: Manual extraction from Gregor et al. (2018), Gregor et al. (2022), and Gripp et al. (2021)

**Inclusion Criteria:**
- Documented de novo occurrence OR cosegregation with disease in affected families
- Clinical phenotype consistent with FBXO11 neurodevelopmental disorder
- Missense variants only (nonsense, frameshift, and splice-site variants excluded)
- Absence from gnomAD v4.1 population database or allele frequency <0.0001
- Published in peer-reviewed literature or ClinVar with expert review

**Validation Statistics:**
- Total pathogenic variants: 23
- Literature-confirmed with genotype-phenotype data: 22/23 (96%)
- De novo confirmed: 21/23 (91%)

### 1.2 Benign Variant Selection

Due to extreme evolutionary constraint of FBXO11 (pLI=1.0, o/e=0.08), naturally occurring benign missense variants are rare. We employed a two-tier strategy:

**Tier 1: ClinVar-Verified Benign Variants (n=6)**
- Classification: "Benign" or "Likely Benign" with ≥2-star review status and no conflicting interpretations
- Examples: A112V, S831G, M820V, D175G, T126S, Q50P

**Tier 2: Computationally Designed Conservative Substitutions (n=15)**

Following precedent for constrained disease genes, we designed conservative substitutions meeting strict criteria:
- Maintain physicochemical properties (hydrophobic→hydrophobic, polar→polar, no charge reversal)
- Located outside critical functional domains (F-box, leucine-rich repeats)
- High-confidence structural regions (pLDDT >70 in AlphaFold3 models)
- Absent from ClinVar pathogenic classifications
- Show substitution tolerance in vertebrate orthologs

### 1.3 Normal SKP1 Binding Pathogenic Variants

A critical subset of 10 pathogenic variants was previously characterized by Gregor et al. (2022) as retaining normal SKP1 binding capacity in co-immunoprecipitation assays despite showing reduced protein abundance, cytoplasmic aggregation, nuclear exclusion, and clear clinical pathogenicity. These variants (R138G, R138S, Q156R, Y506C, I538V, T623R, S840P, A892D, P905R, D910G) allow evaluation of binding-independent destabilization mechanisms. Notably, none reside within the F-box domain (residues 72-120), potentially explaining preserved binding despite predicted instability.

## 2. AlphaFold3 Structure Prediction

### 2.1 Model Generation

Wild-type FBXO11 structural models were generated using AlphaFold3 Server (https://alphafoldserver.com) accessed August–September 2025 in two biological contexts:
- **Monomer**: FBXO11 alone (UniProt Q86XK2, 919 amino acids)
- **Complex**: FBXO11-SKP1 heterodimer with human SKP1 (UniProt P63208, 163 amino acids)

AlphaFold3 generated 5 ranked predictions per context with default settings (3 recycle iterations, full MSA depth, no custom templates).

### 2.2 Structural Seed Selection

Three structurally diverse seeds were selected from the 5 ranked predictions based on pairwise backbone RMSD analysis to sample coordinate uncertainty:

**Selection Protocol:**
- Calculate per-residue pLDDT scores for quality assessment
- Exclude models with mean pLDDT <70
- Align all models to rank_0 and calculate pairwise backbone RMSD matrix
- Select 3 seeds maximizing RMSD diversity (>19 Å separation)

**Selected Seeds:**
- **Monomer**: rank_0 (pLDDT 84.2), rank_3 (pLDDT 81.7, RMSD 22.3 Å), rank_4 (pLDDT 80.9, RMSD 19.1 Å)
- **Complex**: rank_001 (pLDDT 81.4), rank_003 (pLDDT 78.2, RMSD 21.7 Å), rank_005 (pLDDT 77.1, RMSD 19.8 Å)

All 44 variant positions showed pLDDT >70, with 37/44 (84%) showing pLDDT >80.

### 2.3 Structural Quality Assessment

**pLDDT Domain Analysis:**

| Domain | Residues | Mean pLDDT | High Confidence (>90) | Interpretation |
|--------|----------|------------|----------------------|----------------|
| N-terminal | 1-71 | 62.3 | 8% | Low confidence |
| F-box | 72-120 | 88.7 | 78% | High confidence |
| Linker | 121-350 | 71.4 | 15% | Moderate confidence |
| C-terminal | 351-919 | 81.2 | 42% | Good confidence |
| **Overall** | **1-919** | **77.8** | **35%** | **Mixed confidence** |

The large whole-protein RMSD values (19-22 Å) likely include substantial contributions from low-confidence regions (N-terminal, portions of linker) rather than reflecting genuine conformational diversity. However, variant-induced ΔΔG changes are calculated relative to wildtype within the same seed, minimizing systematic bias from these regions.

### 2.4 Multi-Conformational Design

The multi-seed approach captures structural uncertainty and context-dependent stability effects:
- Single structure predictions may miss conformational ensemble effects
- Protein stability is context-dependent (monomer vs complex)
- AlphaFold3 confidence metrics guide seed selection
- Structural diversity ensures sampling of conformational space

**System Matrix:** 45 variants (44 missense + wildtype) × 3 seeds × 2 contexts = 270 systems (FoldX); 44 variants × 3 seeds × 2 contexts = 264 systems (Rosetta, WT→WT undefined).

## 3. FoldX Computational Stability Analysis

### 3.1 FoldX Methodology

**Software:** FoldX version 5.1 (academic license, https://foldxsuite.crg.eu/)
**Platform:** Apple Mac Studio (macOS; Apple M4 Max, 16 cores, 64 GB RAM)

**Workflow:**
1. **Structure Preparation**: RepairPDB optimizes side-chain conformations and hydrogen bonding using Dunbrack 2010 rotamer library
2. **ΔΔG Calculation**: PositionScan command generates ΔΔG values for all 20 amino acids at each variant position with 10 independent runs per system
3. **Statistical Aggregation**: Calculate median, IQR, min, max for each system; median chosen for robustness against outliers

**Energy Function:** FoldX empirical force field includes VdW interactions (Lennard-Jones), solvation energy (SASA-based), hydrogen bonds (distance/angle-dependent), electrostatics (Coulombic with screening), entropy (side-chain and backbone), and water bridges.

### 3.2 FoldX Dataset

- Total systems analyzed: 270
- Replicates per system: 10
- Total ΔΔG measurements: 16,200 individual calculations
- Computational time: ~22 hours (parallelized across 16 cores)

**PositionScan Details:** Generates ΔΔG for all 20 amino acids per iteration; only target mutation value extracted for analysis.

## 4. Rosetta Computational Stability Analysis

### 4.1 Rosetta Methodology

**Software:** Rosetta 2023.49 (academic license, https://www.rosettacommons.org/)
**Platform:** Apple Mac Studio (macOS; Apple M4 Max, 16 cores, 64 GB RAM)

**Protocol:** Cartesian_ddg performs local backbone and side-chain relaxation in Cartesian space (vs torsion space), providing accurate stability predictions for loop regions, main-chain perturbations (e.g., proline substitutions), and structured cores with rigid geometry.

**Workflow:**
1. **Structure Relaxation**: Weak harmonic constraints to starting coordinates with rotamer expansion (χ1/χ2 extra rotamers), 10 structures generated per system
2. **Cartesian ddG Calculation**: 10 independent iterations with REF2015 scoring function, Cartesian minimization allowing local main-chain relaxation
3. **Statistical Aggregation**: Calculate mean, SD, median, min, max; mean chosen as primary statistic (Gaussian distribution confirmed by Shapiro-Wilk test)

**Energy Function:** REF2015 scoring includes Lennard-Jones (VdW), Lazaridis-Karplus implicit solvent, orientation-dependent hydrogen bonding, Coulombic electrostatics with distance-dependent dielectric, Ramachandran backbone preferences, Dunbrack rotamer probabilities, and amino acid-specific reference energies.

### 4.2 Rosetta Dataset

- Total systems analyzed: 264 (WT-to-WT undefined)
- Replicates per system: 10
- Total ΔΔG measurements: 7,920 individual calculations
- Computational time: ~66 hours (parallelized across 16 cores)

## 5. Molecular Dynamics Simulations

### 5.1 GROMACS Setup

**Software:** GROMACS 2024.4 with CUDA 12.2
**Platform:** Cloud-based Linux server with NVIDIA A100 GPU (40 GB HBM2)
**Force Field:** AMBER99SB-ILDN
**Water Model:** TIP3P

MD simulations were performed on cloud infrastructure with GPU acceleration, while trajectory analysis was conducted locally on Mac Studio (Apple M4 Max, 64 GB RAM).

### 5.2 System Preparation

- Generate topology with GROMACS pdb2gmx
- Define cubic simulation box with 1.0 nm minimum distance to edge
- Solvate system (~25,000-30,000 water molecules)
- Add ions for neutralization and physiological salt concentration (150 mM NaCl)

### 5.3 Simulation Protocol

**Energy Minimization:** Steepest descent algorithm until Fmax < 1000 kJ/mol/nm (typically 5,000-10,000 steps)

**NVT Equilibration (100 ps):** Position restraints on protein, V-rescale thermostat, temperature coupling to 310 K (physiological)

**NPT Equilibration (100 ps):** Maintain position restraints, add Parrinello-Rahman barostat, pressure coupling to 1.0 bar

**Production MD (20 ns):** Remove position restraints, 2 fs timestep with LINCS constraints on H-bonds, frame output every 20 ps (2001 frames total), temperature 310 K, pressure 1.0 bar

### 5.4 Trajectory Analysis

Standard GROMACS analysis tools used to calculate:
- **Backbone RMSD**: Structural deviation from starting structure over time
- **Per-Residue RMSF**: Flexibility profile across protein sequence
- **SASA**: Solvent exposure and burial patterns
- **Radius of Gyration**: Protein compactness measure

### 5.5 MD Dataset

- Variants simulated: 5 (G421R, D910G, R138G pathogenic; I300V benign; WT reference)
- Replicates per variant: 3 (different velocity seeds)
- Duration per replicate: 20 ns
- Total simulation time: 300 ns
- Total frames analyzed: 30,015

**Variant Selection Rationale:** G421R (glycine-to-charged substitution), D910G (charge loss and flexibility increase), R138G (N-terminal destabilization), I300V (conservative benign control), WT (reference baseline).

**Important Limitations:** 20 ns simulation time is insufficient for full equilibration of 919-residue protein (typical requirement: 100-300 ns). These simulations serve as exploratory methodological demonstrations generating testable hypotheses.

## 6. Statistical Analysis

### 6.1 Group Comparisons

**Normality Testing:** Shapiro-Wilk test performed to determine appropriate statistical test selection.

**FoldX Data:** Non-normal distribution (p < 0.001) → Mann-Whitney U test (non-parametric)
**Rosetta Data:** Normal distribution (p > 0.05) → Welch's t-test (parametric)

### 6.2 Effect Size Calculation

**Cohen's d:** Calculated using pooled standard deviation to quantify magnitude of difference between pathogenic and benign groups independent of sample size.

**Interpretation:**
- |d| < 0.2: Small effect
- 0.2 ≤ |d| < 0.5: Medium effect
- 0.5 ≤ |d| < 0.8: Large effect
- |d| ≥ 0.8: Very large effect

### 6.3 Correlation Analysis

**Spearman's Rank Correlation (ρ):** Non-parametric correlation for FoldX-Rosetta method agreement
**Pearson's Correlation (r):** Parametric correlation as complementary measure

**Interpretation:**
- |ρ| < 0.3: Very weak correlation
- 0.3 ≤ |ρ| < 0.5: Weak correlation
- 0.5 ≤ |ρ| < 0.7: Moderate correlation
- |ρ| ≥ 0.7: Strong correlation

Correlation analysis performed on variant-level data (n=88 variant-context pairs for Rosetta, n=90 for FoldX including wildtype) and normal-binding pathogenic subset (n=10 variants).

### 6.4 Classification Performance Analysis

**ROC Analysis:** Receiver operating characteristic curves generated for FoldX ΔΔG, Rosetta ΔΔG, and combined logistic regression model using variant-level data (n=88 variant-context pairs: 46 pathogenic, 42 benign, excluding wildtype). AUC (area under curve) quantifies discriminatory power, with 95% confidence intervals calculated via DeLong's method.

**Precision-Recall Analysis:** With ~52% pathogenic prevalence (46/88 variant-context pairs), precision-recall curves provide balanced performance metric accounting for class distribution.

**Threshold Selection:** Youden's J statistic (J = Sensitivity + Specificity - 1) used to identify optimal ΔΔG thresholds balancing true positive and true negative rates. Threshold analysis performed across ΔΔG values from 0.5 to 3.0 kcal/mol, with fixed thresholds of 1.0 and 2.0 kcal/mol analyzed based on literature precedent for protein stability prediction.

## 7. Software and Computational Environment

### 7.1 Core Software

- Python: 3.10.12 with NumPy 1.24.3, Pandas 2.0.2, SciPy 1.11.1, Matplotlib 3.7.1, Scikit-learn 1.3.0
- FoldX: 5.1
- Rosetta: 2023.49
- GROMACS: 2024.4 with CUDA 12.2
- PyMOL: 2.5.4

### 7.2 Hardware

**Cloud Infrastructure (MD Simulations):** NVIDIA A100 GPU (40 GB HBM2)

**Local Workstation (Analysis):** Apple Mac Studio (M4 Max, 16 cores, 64 GB RAM)

### 7.3 Computational Resources

| Task | Platform | CPU/GPU | Wall Time | Storage |
|------|----------|---------|-----------|---------|
| AlphaFold3 prediction | Server | N/A | ~30 min/run | 500 MB |
| FoldX analysis (270 systems) | Local | M4 Max (16 cores) | 22 hours | 14 GB |
| Rosetta analysis (264 systems) | Local | M4 Max (16 cores) | 66 hours | 24 GB |
| MD simulations (15 trajectories) | Cloud | A100 GPU | 60 hours | 55 GB |
| Trajectory analysis | Local | M4 Max | 8 hours | 5 GB |
| **Total** | - | - | **~156 hours** | **~98 GB** |

## 8. Quality Control

### 8.1 FoldX Quality Control

**Outlier Detection:** Calculate median and IQR for each system's 10 ΔΔG values. Flag systems with IQR > 10 kcal/mol for manual inspection. Assess whether high variance reflects technical error or genuine conformational sampling variability.

### 8.2 Rosetta Quality Control

**Distribution Analysis:** Plot ΔΔG histogram for each system and perform Shapiro-Wilk normality test (α = 0.05). Flag systems with bimodal or non-normal distributions for review. Use parametric statistics (mean ± SD) only for systems passing normality test.

### 8.3 MD Simulation Quality Control

**Energy Drift Monitoring:** Verify total energy drift <0.5% over 20 ns, temperature stable within ±5 K of 310 K, and pressure fluctuation within ±200 bar of 1.0 bar target.

**RMSD Convergence:** Visual inspection of RMSD vs time plots for plateau behavior. Note: 20 ns may be insufficient for full equilibration of 919-residue protein.

## 9. Reproducibility Information

### 9.1 Random Seeds

**FoldX:** Not user-controllable (internal pseudorandom number generator); multiple independent runs account for stochastic variability

**Rosetta:** Controlled via `-jran` flag; different seeds used for each of 10 replicates per system

**GROMACS:** Velocity generation seed controlled via `gen_seed` parameter; Replicate 1 (123456), Replicate 2 (234567), Replicate 3 (345678)

### 9.2 Data Availability

**Supplementary Table S1 (Excel):** AlphaFold3 structural quality metrics for all 44 variants including pLDDT scores, RMSD values, and confidence categories for monomer and complex models

**Supplementary Table S2 (Excel):** Complete variant dataset with FoldX and Rosetta ΔΔG values for all 44 variants analyzed across 3 structural seeds and 2 biological contexts (monomer and complex)

**AlphaFold3 Structures:** Available upon reasonable request (PDB format, ~500 MB total)

**MD Trajectories:** Available upon reasonable request (XTC format, ~55 GB total, requires institutional data transfer agreement)

**Analysis Scripts:** Python scripts and GROMACS workflows available at https://github.com/ykshim2013/FBXO11_computational_framework

## References

All references are listed in the main manuscript.
