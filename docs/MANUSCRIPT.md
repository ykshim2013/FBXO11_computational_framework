# Computational stability analysis suggests binding-independent destabilization in pathogenic FBXO11 variants

Youngkyu Shim¹,*, Eungu Kang², Suhyun Kim³,⁴

¹ Division of Pediatric Neurology, Department of Pediatrics, Korea University Ansan Hospital, Korea University College of Medicine, Ansan, Gyeonggi-do, Republic of Korea
² Division of Medical Genetics, Department of Pediatrics, Korea University Ansan Hospital, Korea University College of Medicine, Ansan, Gyeonggi-do, Republic of Korea
³ Department of Convergence Medicine, College of Medicine, Korea University, Seoul, Republic of Korea
⁴ Zebrafish Translational Medical Research Center, Korea University, Ansan, Gyeonggi-do, Republic of Korea

*Corresponding author: ykshim2013@gmail.com

---

## Abstract

*FBXO11* binds SKP1 within an SCF E3 ubiquitin ligase complex, where it recognizes substrates for ubiquitination and degradation. Pathogenic *FBXO11* variants cause neurodevelopmental disorders, yet several retain normal SKP1 binding, indicating that disrupted SKP1 binding alone cannot account for disease. We integrated multi-conformational AlphaFold3 models with FoldX and Rosetta stability predictions to evaluate 44 missense variants (23 pathogenic, 21 benign). Pathogenic variants showed greater predicted destabilization than benign controls by both methods (FoldX 1.86 vs. 0.54 kcal/mol, Cohen's d = 0.50; Rosetta 6.85 vs. 1.31 kcal/mol, Cohen's d = 0.78; both p < 0.01, FDR-corrected). Discrimination was consistent in both the *FBXO11* monomer and the *FBXO11*–SKP1 complex contexts. Among ten pathogenic variants with experimentally validated normal SKP1 binding, 9/10 by FoldX and 8/10 by Rosetta exceeded a 1.0 kcal/mol threshold (10/10 by either method). Benchmarking against AlphaMissense, REVEL, and CADD indicated that physics-based ΔΔG provides complementary mechanistic information to existing predictors. Exploratory molecular dynamics simulations (300 ns total) suggested elevated backbone RMSD in pathogenic variants. These findings support a hypothesis of binding-independent destabilization in *FBXO11*-associated pathogenesis, although requiring further computational analysis and experimental validation.

---

## Introduction

*FBXO11* (F-box only protein 11) encodes the substrate recognition subunit of the SCF (SKP1–CUL1–F-box) E3 ubiquitin ligase complex, which directs ubiquitination and proteasomal degradation of the transcriptional repressor BCL6¹⁻⁴. Pathogenic *FBXO11* variants cause a neurodevelopmental disorder characterized by intellectual disability, developmental delay, and behavioral abnormalities⁵,⁶. The gene exhibits extreme evolutionary constraint (pLI = 1.0; missense z-score = 4.02)⁷, indicating strong intolerance to functional perturbations.

Three distinct molecular properties are relevant to understanding FBXO11 variant pathogenicity: (i) binding affinity, the strength of protein–protein interactions such as the FBXO11–SKP1 interface; (ii) thermodynamic folding stability, the intrinsic free energy difference between folded and unfolded states; and (iii) cellular protein homeostasis, the balance between protein synthesis, folding, trafficking, and degradation. Binding assays measure only the first property; variants that retain normal binding may nevertheless be destabilized in ways that disrupt folding stability or protein homeostasis.

A key mechanistic puzzle emerged from experimental studies: several pathogenic missense variants retain normal SKP1 binding capacity in co-immunoprecipitation assays despite clear clinical pathogenicity⁵,⁸. These same variants show reduced protein abundance, cytoplasmic aggregation, and nuclear exclusion⁸—phenotypes that are hallmarks of impaired protein homeostasis, typically resulting from protein misfolding, recognition by protein quality control machinery (chaperones, ubiquitin-proteasome system), accelerated proteasomal or autophagic degradation, or disrupted subcellular trafficking⁹. This constellation of phenotypes suggests that protein destabilization—rather than impaired complex assembly—may contribute to pathogenesis through binding-independent mechanisms.

FBXO11 (927 residues) comprises an N-terminal F-box domain (residues 72–120) mediating SKP1 interaction, two CASH (CARDB and SPla/RYanodine receptor SPRY) domains involved in substrate recognition and protein–protein interactions, and extended C-terminal regions (Fig. 1a). Pathogenic variants are distributed across the entire protein, while most ClinVar-validated benign variants and computational control substitutions are positioned outside recognized functional domains (Supplementary Table S1).

Computational structural biology offers tools to probe molecular properties that binding assays cannot access. High-quality structural models from AlphaFold3¹⁰⁻¹² serve as input for physics-based ΔΔG estimation (FoldX¹³, Rosetta¹⁴), yielding stability metrics independent of binding behaviour¹⁵⁻¹⁷, while molecular dynamics (MD) simulations sample conformational dynamics on biologically relevant timescales¹⁸,¹⁹. Machine-learning variant effect predictors—AlphaMissense²⁰, REVEL²¹, and CADD²²—integrate evolutionary, structural, and sequence-based features to assign pathogenicity scores. Together these complementary approaches provide a framework for testing whether a variant disrupts stability, dynamics, or both.

Here, we present the first systematic computational structural analysis of FBXO11 missense variants, integrating multi-conformational AlphaFold3 structural modeling with dual-method stability predictions (FoldX and Rosetta), complemented by exploratory molecular dynamics simulations. The multi-conformational approach—using three structurally distinct AlphaFold3 seeds—explicitly samples modeling uncertainty, while the dual-method design provides orthogonal stability estimates based on different energy functions and sampling strategies. This framework was designed to test whether pathogenic *FBXO11* variants demonstrate predicted thermodynamic destabilization despite preserved SKP1 interaction, addressing a specific clinical puzzle with direct implications for variant interpretation in this rare disorder.

---

## Results

### Interpretation framework for stability predictions

Before presenting stability predictions, we note that ΔΔG values from physics-based force fields should be interpreted as ordinal destabilization scores—indicating the relative magnitude and direction of predicted stability change—rather than quantitative experimental free energy measurements. While computational ΔΔG values correlate with experimental stability measurements¹⁵⁻¹⁷, absolute magnitudes frequently differ from calorimetric values due to force field approximations. We therefore emphasize comparative ranking between pathogenic and benign groups over absolute thermodynamic quantification.

### AlphaFold3 structural model quality

Three structurally distinct conformational seeds were selected with mean pLDDT scores of 82.3 ± 5.1 (monomer) and 78.9 ± 6.3 (complex), indicating high-confidence predictions. Pairwise backbone RMSD exceeded 19 Å between seeds 1 and 3, consistent with sampling distinct conformational states. The large inter-seed RMSD primarily reflects conformational variation in the disordered linker regions and low-confidence loops (pLDDT <70, comprising 20.4% of chain A residues), rather than alternative folded states of structured domains. Analysis of residues with pLDDT >70 (738/927 residues, 79.6% of chain A) showed reduced RMSD, indicating that core folded domains are consistent across seeds while peripheral regions sample distinct conformations. Quality metrics are detailed in Supplementary Table S2.

Variant and wild-type models (n=45; 44 missense variants + wild type) spanned a wide range of pLDDT confidence at the mutated residue position (or matched position for wild type) (24.3–97.7; median 91.3), with 72.7% (32/44) achieving pLDDT >70 and 59.1% (26/44) exceeding pLDDT >90. Low-confidence positions (pLDDT <70) were concentrated at the predicted disordered N-terminus (residues 48–150) and C-terminus (residues 905–910). Among the 44 missense variants, pathogenic and benign groups showed comparable pLDDT distributions (pathogenic mean 76.4 ± 26.2 vs. benign 76.4 ± 25.8; p=0.76, Mann-Whitney U), indicating no systematic bias toward lower-confidence regions. Stability predictions for positions in low-confidence regions should be interpreted with additional caution, as structural uncertainty may reduce prediction accuracy.

### Pathogenic variants show statistically significant predicted destabilization

Variant-level analysis of 88 variant-context pairs (n=46 pathogenic, n=42 benign, excluding wildtype) demonstrated statistically significant differences between pathogenic and benign groups (Fig. 2a,b). FoldX analysis showed pathogenic median ΔΔG 1.86 ± 3.63 kcal/mol (IQR) versus benign 0.54 ± 1.76 kcal/mol (p=1.85×10⁻³, Mann-Whitney U, Cohen's d=0.50, 95% CI: 0.14–0.86). Rosetta analysis showed pathogenic mean ΔΔG 6.85 ± 9.28 kcal/mol versus benign 1.31 ± 2.91 kcal/mol (p=2.39×10⁻⁴, Welch's t-test, Cohen's d=0.78, 95% CI: 0.38–1.18). All statistical comparisons remained significant after Benjamini-Hochberg FDR correction (q<0.05 for all 8 tests).

The two methods showed positive correlation at variant level (Spearman's ρ=0.60, p=3.10×10⁻¹⁰; Pearson's r=0.74, p=9.26×10⁻¹⁷) (Fig. 2c).

The benign group comprised two subsets: six ClinVar-validated benign variants (median ΔΔG 0.49 kcal/mol by FoldX, mean 0.94 kcal/mol by Rosetta) and fifteen computational control variants designed as conservative substitutions (median 0.62 kcal/mol by FoldX, mean 1.46 kcal/mol by Rosetta). The <0.5 kcal/mol mean difference between these subsets supports their combined use as a benign reference group.

### ClinVar-validated benign subgroup analysis

To assess whether the primary findings depend on the inclusion of computational control variants, we performed a subgroup analysis comparing 23 pathogenic variants against only the 6 ClinVar-validated benign variants (D175G, M820V, P48L, Q50P, S831G, T126S). At variant level (mean across monomer and complex contexts), Rosetta maintained statistical significance (pathogenic mean 7.40 kcal/mol vs. ClinVar benign 0.94 kcal/mol; Welch's t-test p=0.008, Cohen's d=0.75), while FoldX showed borderline significance (pathogenic mean 5.86 kcal/mol vs. ClinVar benign 0.45 kcal/mol; Mann-Whitney U p=0.050, Cohen's d=0.46), consistent with reduced statistical power (n=6 benign comparators) rather than loss of discrimination signal.

At the 1.0 kcal/mol threshold with ClinVar-only benign variants, FoldX specificity improved substantially from 29% to 83% (5/6 ClinVar benign variants below threshold), indicating that the low specificity in the full analysis was driven by computational control variants rather than a fundamental limitation of the method. Rosetta specificity was 33% (2/6), as two ClinVar benign variants (D175G: 5.08 kcal/mol; S831G: 2.32 kcal/mol) showed elevated Rosetta predictions. These results confirm that the core finding of significantly greater predicted destabilization in pathogenic variants is not an artifact of the computational control design.

### Context-specific analysis shows discrimination in both biological states

Both monomer and complex contexts showed significant pathogenic-benign discrimination (Fig. 2d). For monomer context (n=44 variants): FoldX showed pathogenic median 1.26 vs. benign −0.08 kcal/mol (p=5.44×10⁻², Cohen's d=0.50); Rosetta showed pathogenic mean 7.34 ± 9.42 vs. benign 1.22 ± 2.88 kcal/mol (p=1.07×10⁻², Cohen's d=0.78). For complex context (n=44 variants): FoldX showed pathogenic median 2.95 vs. benign 1.06 kcal/mol (p=1.62×10⁻², Cohen's d=0.56); Rosetta showed pathogenic mean 7.45 ± 9.51 vs. benign 1.40 ± 3.01 kcal/mol (p=1.03×10⁻², Cohen's d=0.83). No significant difference was observed between monomer and complex discrimination capacity (p=0.94).

### Threshold-based classification and ROC analysis

The 1.0 kcal/mol destabilization threshold represents a commonly used guideline in the computational stability prediction literature¹⁶,¹⁷,²³, reflecting the approximate magnitude at which predicted destabilization exceeds typical prediction error (~1 kcal/mol). This value should be interpreted as a practical classification guideline rather than a strict biological cutoff, as the true stability tolerance of individual proteins varies. As an interpretive frame, thermal fluctuations at body temperature (310 K) carry an energy of order ~1 kcal/mol, which is also the conventional error tolerance of free-energy calculations in protein MD simulations; predicted destabilizations exceeding ~1 kcal/mol are therefore regarded as significant rather than within statistical noise.

At 1.0 kcal/mol threshold, either-method criterion (FoldX OR Rosetta) achieved 85% sensitivity and 29% specificity, while both-methods criterion achieved 60% sensitivity and 71% specificity. When restricted to ClinVar-validated benign variants only, FoldX specificity at 1.0 kcal/mol improved to 83% (Supplementary Table S3). At 2.0 kcal/mol, these values were 71%/48% (either-method) and 38%/86% (both-methods), respectively. Threshold analysis was performed across ΔΔG values from 0.5–3.0 kcal/mol (Supplementary Table S3).

ROC analysis yielded modest discriminatory power with AUC values of 0.68 (95% CI: 0.52–0.82, FoldX), 0.68 (95% CI: 0.53–0.83, Rosetta), and 0.69 (95% CI: 0.52–0.84, combined logistic regression model). All three methods performed significantly above random chance (AUC=0.5, p<0.05) but below levels appropriate for clinical diagnosis.

### Data-driven thresholds, calibration, and decision-curve analysis

Youden-optimal thresholds were derived by stratified non-parametric bootstrap (n = 2,000 resamples; Supplementary Table S4). The FoldX optimum (1.54 kcal/mol, 95% CI 0.30–3.48) encompassed the 1.0 kcal/mol convention, while the Rosetta optimum (5.32 kcal/mol, 95% CI 1.24–5.87) yielded substantially higher specificity (0.95 vs 0.29 at 1.0 kcal/mol) at the cost of sensitivity for moderately destabilizing variants. This contrast reflects different absolute energy scales between the two force fields rather than weaker Rosetta discrimination, as the two AUCs are statistically indistinguishable (DeLong p = 0.852), consistent with our emphasis on ordinal interpretation of ΔΔG.

Bootstrap 95% CIs for the AUCs (FoldX 0.683 [0.520–0.826]; Rosetta 0.673 [0.503–0.828]) approached 0.5 at the lower bound, indicating modest above-chance discrimination with substantial uncertainty. Precision–recall analysis (pathogenic as positive class; no-skill baseline = 0.523) gave AUCPR 0.755 [0.627–0.878] for FoldX and 0.770 [0.656–0.884] for Rosetta. A 10,000-iteration label-permutation null confirmed that both AUCs exceeded chance, though the Rosetta result was borderline (FoldX one-sided p = 0.020; Rosetta p = 0.024). A paired DeLong test showed no significant difference between the two AUCs (ΔAUC = +0.010, p = 0.852).

Calibration of the combined LOOCV logistic-regression model gave a Brier score of 0.224 (skill score 0.10 above the climatological baseline of 0.250), with monotonically increasing observed prevalence across predicted-probability bins. Decision curve analysis (Vickers & Elkin²⁴) yielded positive net benefit relative to "treat-none" across threshold probabilities of ≈0.45–0.95, supporting the framework as a hypothesis-generating prioritization tool rather than as a clinical triage instrument.

### Benchmarking against established variant effect predictors

To position physics-based ΔΔG within the variant-interpretation landscape, we retrieved AlphaMissense²⁰, REVEL²¹, and CADD PHRED²² scores from the Ensembl VEP REST API (build GRCh38, canonical transcript ENST00000403359). Scores were available for 43/44 variants; R800K, a computational control requiring two simultaneous nucleotide substitutions (CGG → AAG), is not represented in single-nucleotide variant databases. On this common subset, AlphaMissense achieved the highest discrimination (AUC 0.839 [0.698–0.946]), followed by REVEL (0.776 [0.626–0.911]); FoldX (0.683 [0.520–0.826]), Rosetta (0.673 [0.503–0.828]), and CADD PHRED (0.685 [0.523–0.830]) showed no significant pairwise differences (DeLong p > 0.79). The Rosetta versus AlphaMissense comparison reached borderline significance (ΔAUC = −0.176, p = 0.051). Forest plots of AUC and AUCPR are shown in Supplementary Fig. S3a.

The pairwise Spearman rank-correlation matrix (Supplementary Fig. S3b) showed a clear block structure: physics-based methods correlated within group (FoldX–Rosetta ρ = 0.77), as did ML predictors (AlphaMissense–REVEL ρ = 0.81; REVEL–CADD ρ = 0.78), whereas cross-group correlations were substantially lower (FoldX–AlphaMissense ρ = 0.31; Rosetta–AlphaMissense ρ = 0.48). Physics-based ΔΔG thus contributes mechanistically interpretable thermodynamic information complementary to ML-based pathogenicity scores.

### Cross-validation and machine learning classification

To assess generalizability, we performed leave-one-out cross-validation (LOOCV) on the 44 missense variants (23 P/LP, 21 B/LB); the wild-type model was used only as a structural reference and was not included as a classification instance. The logistic regression model showed training AUC 0.69 and LOOCV AUC 0.62, with an overfit gap of 0.07 consistent with the small sample size (n=44). The LOOCV accuracy was 59.1% (26/44). As an orthogonal machine learning approach, Random Forest classification (100 trees) achieved LOOCV AUC 0.72 and accuracy 70.5% (31/44), with feature importance analysis showing comparable contributions from FoldX (45.1%) and Rosetta (54.9%) features. Calibration analysis yielded Brier scores of 0.224 (logistic regression) and 0.217 (Random Forest), both improving over the climatological baseline (Brier skill scores 0.10 and 0.13, respectively).

### Seed-to-seed convergence analysis

To assess the robustness of stability predictions to structural seed selection, we calculated variant-level mean ΔΔG for seven seed subsets (each individual seed, all three pairwise combinations, and all seeds combined) and tested pathogenic-benign group differences for each. Rosetta predictions showed robust statistical significance across all seven seed subsets (p<0.05 for all), with consistent mean pathogenic-benign ΔΔG differences (range 5.51–6.15 kcal/mol). FoldX showed seed-dependent sensitivity, with significance in some subsets (seed2 only: p=3.07×10⁻³; seeds 2+3: p=1.40×10⁻³; all seeds: p=3.87×10⁻²) but not others, reflecting higher variance in FoldX predictions. Bootstrap analysis (10,000 iterations) confirmed that group-level mean differences are significantly different from zero for both methods (FoldX: 5.10 kcal/mol, 95% CI [0.76, 11.21]; Rosetta: 5.76 kcal/mol, 95% CI [2.10, 9.82]). We additionally quantified across-seed reliability with the two-way random-effects, single-measurement, absolute-agreement intraclass correlation coefficient (ICC(2,1)²⁵,²⁶). Both methods achieved excellent reliability (FoldX ICC(2,1) = 0.901; Rosetta ICC(2,1) = 0.980), and cumulative-seed Spearman rank stability ρ(1→3 seeds) was 0.835 for FoldX and 0.974 for Rosetta (all p ≤ 1.6 × 10⁻¹²), indicating that variant-level ΔΔG estimates are highly consistent across independent AlphaFold3 structural seeds and that rankings essentially saturate after two seeds.

### Exploratory molecular dynamics observations

Five variants were selected for exploratory MD simulations to represent distinct categories: three pathogenic variants spanning different mutation types and protein regions (G421R, a charge-introducing glycine substitution in the central CASH domain; D910G, a charge-removing substitution in the C-terminal low-confidence region; R138G, a charge-removing substitution in the N-terminal low-confidence region), one computationally designed benign control (I300V, a conservative hydrophobic substitution), and wildtype as reference.

Short-timescale MD simulations (20 ns per replicate, 15 trajectories, 300 ns aggregate) were performed as exploratory probes of early conformational dynamics (Supplementary Fig. S1). These short runs additionally serve as a structural relaxation probe: residual steric clashes or unphysical conformations introduced during modelling would manifest as drastic backbone fluctuations readily detectable by standard trajectory analyses such as RMSD and RMSF. However, these simulations are insufficient for equilibrium sampling—equilibration of 927-residue proteins typically requires 100–300 ns¹⁸,¹⁹—and should be interpreted as hypothesis-generating, not as quantitative stability measurements.

During this short observation window, pathogenic variants exhibited elevated mean backbone RMSD (3.6 ± 1.4 nm, n=9 trajectories) compared to benign I300V (2.86 ± 1.68 nm, n=3) and wildtype (2.61 ± 1.48 nm, n=3). Per-residue RMSF showed modest increases in pathogenic variants (1.05–1.20-fold vs. wildtype) compared to benign I300V (0.86-fold). Additional metrics (SASA, radius of gyration, hydrogen bonds) showed minimal variation (±3.6% of wildtype). These observations suggest potential dynamical differences warranting validation with longer equilibrium simulations. Extended simulations (100 ns per replicate) are in progress and will be reported in a subsequent dynamics-focused study. Complete MD analysis is presented in Supplementary Text S1.

### Systematic analysis of experimentally validated normal-binding variants

Of 10 pathogenic variants with experimentally confirmed normal SKP1 binding⁸, FoldX identified 9/10 (90%) and Rosetta identified 8/10 (80%) as exceeding the 1.0 kcal/mol guideline threshold, with complementary sensitivity achieving 10/10 (100%) detection by either method, while 7/10 (70%) exceeded threshold by both methods (Fig. 3, Table 1). Mean ΔΔG values were 1.77 ± 1.15 kcal/mol (FoldX, median 1.45, range 0.45–4.54) and 3.83 ± 4.43 kcal/mol (Rosetta, median 2.87, range −0.78 to 15.05). Structural mapping revealed that none of these 10 variants reside within the F-box domain (residues 72–120) or the SKP1 interface, consistent with preserved binding despite predicted thermodynamic instability (Fig. 1b,c).

FoldX identified 9/10 variants (90%) as destabilized, with only D910G below threshold (0.45 kcal/mol). Rosetta identified 8/10 (80%), with Q156R (−0.78 kcal/mol) and R138S (−0.65 kcal/mol) showing slightly stabilizing predictions. The methods showed complementary sensitivity: D910G exceeded threshold by Rosetta (4.48 kcal/mol), while Q156R and R138S exceeded by FoldX (1.87 and 1.25 kcal/mol).

---

## Discussion

This computational framework suggests that pathogenic *FBXO11* missense variants exhibit statistically significant greater predicted thermodynamic destabilization than benign variants (FoldX p=1.85×10⁻³, Cohen's d=0.50, 95% CI: 0.14–0.86; Rosetta p=2.39×10⁻⁴, Cohen's d=0.78, 95% CI: 0.38–1.18), with all comparisons remaining significant after Benjamini-Hochberg FDR correction. Critically, this destabilization was observed in variants with experimentally confirmed normal SKP1 binding, supporting the hypothesis that structural stability and binding affinity, while generally interrelated, can be differentially affected by missense variants—such that variants preserving binding may nevertheless compromise thermodynamic stability.

The central motivation for this study was the apparent discrepancy reported by Gregor et al.⁸: pathogenic variants retain SKP1 binding despite clear pathogenicity. Our analysis of all 10 experimentally validated normal-binding variants showed that the majority exceeded the 1.0 kcal/mol destabilization guideline threshold by either or both methods (Table 1), with mean ΔΔG values indicating moderate-to-strong predicted destabilization. Structural mapping showed that none of these variants reside within the F-box domain (residues 72–120) (Fig. 1c), potentially explaining preserved binding despite predicted instability. These findings suggest that binding-independent destabilization—potentially leading to accelerated degradation, misfolding, or altered subcellular localization—may contribute to pathogenesis (Fig. 4), consistent with experimental observations of reduced protein levels, cytoplasmic aggregation, and nuclear exclusion⁸. This hypothesis aligns with broader protein quality control mechanisms⁹ and warrants direct experimental validation through thermal shift assays, cycloheximide chase experiments, and localization studies.

The two methods showed complementary sensitivity patterns, with method-discordant predictions in specific cases (e.g., D910G exceeded threshold only by Rosetta, while Q156R and R138S exceeded only by FoldX). The methods showed significant Pearson correlation (r=0.759, p=0.011) but weak Spearman correlation (ρ=0.200, p=0.580), indicating rank-order divergence partly due to Rosetta outliers (>10–15 kcal/mol) exceeding typical experimental ranges¹⁶,²⁷. Such extreme values should be interpreted qualitatively as "strongly destabilizing" rather than precise thermodynamic predictions, reinforcing our emphasis on ordinal ranking over absolute quantification.

Subgroup analysis restricted to the 6 ClinVar-validated benign variants—excluding the 15 computational control variants—confirmed that pathogenic variants show significantly greater predicted destabilization (Rosetta p=0.008, Cohen's d=0.75). FoldX showed borderline significance (p=0.050, Cohen's d=0.46), consistent with reduced statistical power (n=6) rather than loss of signal. Importantly, FoldX specificity at the 1.0 kcal/mol threshold improved from 29% with all benign variants to 83% with ClinVar-only benign variants, indicating that the low specificity in the full analysis was largely attributable to computational control variants that, while designed to be conservative, sometimes produced elevated ΔΔG values. These results demonstrate that the core discrimination between pathogenic and benign variants is not an artifact of the computational control design.

The combined logistic regression model achieved training AUC 0.69 and leave-one-out cross-validated AUC 0.62, with the modest overfitting gap (0.07) consistent with the small sample size. Random Forest classification achieved somewhat higher LOOCV AUC (0.72), suggesting nonlinear feature interactions contribute to classification. Both models yielded similar Brier scores (~0.22), with comparable calibration above the climatological baseline. These values fall well below thresholds appropriate for clinical diagnostic use (typically AUC>0.90 for actionable tests)²⁸. These modest discriminatory values reflect inherent challenges in *FBXO11* variant classification: (1) extreme evolutionary constraint limiting naturally occurring benign variants, necessitating computationally designed controls; (2) force field approximations in energy calculations; (3) structural model uncertainty, particularly for positions in low-confidence AlphaFold3 regions; and (4) the small sample size of 44 variants. This computational framework provides mechanistic hypothesis generation rather than diagnostic classification. Clinical variant interpretation requires multi-dimensional evidence integration including functional assays, segregation analysis, case reports, and computational predictions²⁹—no single computational method suffices for pathogenicity determination. However, the statistically significant group differences (Cohen's d 0.50–0.78) establish computational destabilization as a mechanistically informative signal suitable for hypothesis generation and experimental prioritization.

Benchmarking against three established machine-learning variant effect predictors clarifies the appropriate scientific role of our framework. AlphaMissense outperforms physics-based ΔΔG for overall classification at this locus (AUC 0.84 vs 0.68–0.69), and REVEL is intermediate, while CADD PHRED, FoldX, and Rosetta show no significant pairwise differences in AUC. However, the modest cross-method Spearman correlations (FoldX–AlphaMissense ρ = 0.31; Rosetta–AlphaMissense ρ = 0.48) indicate that physics-based stability scores capture orthogonal signal not encoded by machine-learning predictors. One caveat to this benchmark warrants emphasis: although AlphaMissense was not directly supervised on ClinVar labels during its primary model training, its final pathogenicity score calibration and categorical thresholds involve ClinVar-derived data; comparisons against ClinVar classifications may therefore be partially affected by benchmark circularity, and AlphaMissense should be regarded here as supportive computational evidence rather than as an independent ground-truth classifier. Our framework is therefore not positioned to supersede ML-based classifiers, but to provide interpretable thermodynamic context for variant interpretation, particularly for the binding-independent destabilization hypothesis that motivated this study.

Seed-to-seed convergence analysis demonstrated that Rosetta predictions are robust across all seed subsets tested (p<0.05 for all seven subsets), while FoldX showed greater seed sensitivity, achieving significance in some but not all individual seed subsets. This indicates that Rosetta's cartesian_ddg protocol is more robust to the specific conformational input, whereas FoldX predictions are more seed-dependent. Bootstrap analysis confirmed that the mean pathogenic-benign ΔΔG difference is significantly different from zero for both methods, with 95% confidence intervals excluding zero (FoldX: [0.76, 11.21] kcal/mol; Rosetta: [2.10, 9.82] kcal/mol). Across-seed ICC(2,1) values of 0.901 (FoldX) and 0.980 (Rosetta) confirm excellent reliability of variant-level estimates²⁵,²⁶, and cumulative-seed Spearman rank stability indicates that variant rankings are essentially saturated after two seeds. These observations together provide an empirical justification for the three-seed conformational ensemble used in this study.

Short-timescale MD simulations suggested elevated RMSD in pathogenic variants compared to benign and wildtype controls, but critical limitations constrain interpretation. The 20 ns per-trajectory simulation time represents exploratory probing of early-timescale dynamical tendencies rather than equilibrium stability assessment¹⁸,¹⁹, and inter-replicate variance limits quantitative conclusions; the MD data therefore provide preliminary supporting evidence only and are not load-bearing for the core conclusions of this study. Extended simulations (100 ns per replicate) are in progress and will be reported in a subsequent dynamics-focused study.

The multi-conformational computational pipeline developed here is readily generalizable to other F-box family proteins and SCF-related disorders. The SCF ubiquitin ligase superfamily comprises ~69 human F-box proteins³,⁴, many implicated in disease: *FBXW7* (cancer)³⁰, *FBXO7* (Parkinson's disease)³¹, *FBXL4* (mitochondrial encephalopathy)³², and *FBXO38* (distal spinal muscular atrophy)³³. These genes share structural architecture—an F-box domain for SKP1 binding plus substrate recognition domains—making the framework directly applicable. Future work could leverage this framework to predict novel FBXO11 substitutions with specific stability profiles—both destabilizing and stabilizing—and validate these predictions experimentally, providing a direct test of the framework's predictive power beyond retrospective classification.

Strengths of this study include near-comprehensive coverage of clinically validated *FBXO11* missense variants, a multi-conformational AlphaFold3 approach that explicitly samples structural uncertainty, dual-method ΔΔG estimation, and a comprehensive statistical framework comprising cross-validation, FDR correction, bootstrap 95% CIs, a label-permutation null, DeLong-paired AUC comparison, data-driven Youden-optimal thresholds (Supplementary Table S4), calibration and decision-curve analysis, across-seed ICC(2,1) reliability (FoldX 0.901; Rosetta 0.980), and head-to-head benchmarking against AlphaMissense, REVEL, and CADD (Supplementary Fig. S3). However, important limitations warrant consideration. First, variant and wild-type models span a wide range of AlphaFold3 confidence, with 27% of modeled positions in low-pLDDT regions (<70), though pathogenic and benign groups show comparable pLDDT distributions (p=0.76). Second, while 6 ClinVar-verified benign variants strengthen the study, 15 computationally designed controls lack direct clinical validation, necessitated by *FBXO11*'s extreme constraint (pLI=1.0, o/e=0.08); however, subgroup analysis excluding computational controls confirms that the core finding persists with ClinVar-validated benign variants alone (Rosetta p=0.008). Third, the binding-independent destabilization hypothesis requires direct experimental testing through protein stability assays, degradation kinetics, and localization studies. Fourth, our analysis focused on *FBXO11*-SKP1 interaction; substrate recognition (BCL6) and complete SCF complex assembly remain unexplored. Fifth, the dataset is constrained by the number of clinically classified FBXO11 variants available under our prespecified inclusion criteria (n = 23 pathogenic and n = 21 benign), making prospective sample-size determination inapplicable; statistical uncertainty was therefore quantified through stratified bootstrap confidence intervals, label-permutation testing, paired DeLong comparison, and across-seed ICC rather than through power analysis. The observed effect sizes (Cohen's d = 0.78 for Rosetta and 0.50 for FoldX) indicate moderate group separation for FoldX alone, and our principal conclusions accordingly rely on Rosetta and on the convergence between FoldX and Rosetta rather than FoldX alone.

In conclusion, this computational framework suggests statistically significant predicted structural destabilization in pathogenic *FBXO11* variants compared to benign controls, including variants with experimentally preserved SKP1 binding. While the modest discriminatory power (LOOCV AUC 0.62–0.72) precludes diagnostic application, these findings support the hypothesis—requiring experimental validation—that protein instability may contribute to pathogenesis through binding-independent mechanisms, providing a mechanistically informative framework for future experimental studies. Within the broader variant-interpretation landscape, physics-based ΔΔG complements rather than competes with machine-learning predictors such as AlphaMissense, contributing orthogonal thermodynamic information that meaningfully improves integrated classification.

---

## Methods

### Variant dataset assembly

We curated 44 missense variants plus wildtype reference from published clinical reports and ClinVar³⁴ (accessed September 2025): 23 pathogenic/likely pathogenic (P/LP) and 21 benign/likely benign (B/LB) variants. This dataset represents substantial coverage of clinically validated *FBXO11* missense variants, with the pathogenic subset including 10 variants previously shown to retain normal SKP1 binding⁸.

The benign group comprised two distinct subsets: (1) six ClinVar-validated benign/likely benign variants (D175G, M820V, P48L, Q50P, S831G, T126S) with multiple submitters and no conflicts; and (2) fifteen computationally designed conservative amino acid substitutions. Computational controls were designed to maintain biochemical similarity (charge, hydrophobicity, size), reside outside critical functional domains, and be absent from ClinVar pathogenic classifications. All computational control substitutions were designed at positions outside the F-box domain (residues 72–120), the SKP1 interface, and known substrate-recognition motifs. None coincide with positions reported as pathogenic in ClinVar or literature. Domain annotations for all variant positions are provided in Supplementary Table S1. This dual strategy was necessitated by *FBXO11*'s extreme evolutionary constraint (pLI=1.0, o/e=0.08), which limits naturally occurring benign missense variants. Primary statistical analyses were performed on the full dataset (23 pathogenic vs. 21 benign), with ClinVar-only subgroup analysis (23 pathogenic vs. 6 ClinVar benign) presented separately to confirm that findings do not depend on computational control inclusion. Complete variant details are provided in Supplementary Table S1.

### Protein structure prediction

Wild-type *FBXO11* structural models were generated using AlphaFold3 Server (https://alphafoldserver.com)¹⁰⁻¹² in two biological contexts: (1) monomeric *FBXO11* (UniProt Q86XK2, 927 amino acids) and (2) *FBXO11*–SKP1 heterodimeric complex (SKP1: UniProt P63208, 163 amino acids). Three structurally distinct conformational seeds were selected from five AlphaFold3 predictions based on whole-protein backbone RMSD analysis (RMSD >19 Å between seeds 1 and 3). Structure quality was assessed using pLDDT (predicted Local Distance Difference Test) scores. Chain A residues with pLDDT >70 comprised 79.6% (738/927) of the structure, with low-confidence regions concentrated at the N-terminus (residues 1–65) and C-terminus (residues 880–927)¹¹,¹².

### Computational stability analysis

Thermodynamic stability changes (ΔΔG = ΔG_mutant − ΔG_wildtype) were calculated using FoldX version 5.1¹³ and Rosetta macromolecular modeling suite version 2023.49¹⁴. The multi-conformational design yielded 270 total systems for FoldX (45 variants including wildtype × 3 seeds × 2 contexts) and 264 systems for Rosetta (44 variants × 3 seeds × 2 contexts, excluding wildtype as WT→WT is undefined).

**FoldX analysis.** Structures underwent repair using RepairPDB to optimize side-chain conformations, followed by 10 independent PositionScan calculations per system (16,200 total calculations). Statistics reported as median ± IQR to provide robust estimates resistant to outliers.

**Rosetta analysis.** Employed cartesian_ddg protocol with REF2015 scoring function, generating 30 measurements per variant (7,920 total calculations). Statistics reported as mean ± SD.

**Interpretation.** ΔΔG values from these physics-based force fields should be interpreted as ordinal destabilization scores (higher values indicate greater predicted instability) rather than quantitative experimental free energy predictions. While computational ΔΔG values correlate with experimental stability measurements¹⁵⁻¹⁷, absolute magnitudes often differ from calorimetric or thermal shift assays due to force field approximations and implicit solvation models. We therefore emphasize comparative ranking (pathogenic vs. benign) over precise thermodynamic quantification.

Complete protocols are provided in Supplementary Text S1.

### Molecular dynamics simulations

All-atom MD simulations were performed for five variants selected to represent distinct categories within our dataset: three pathogenic variants (G421R, a severely destabilizing glycine-to-arginine substitution in the central CASH domain; D910G, a C-terminal variant with method-discordant predictions and experimentally confirmed normal SKP1 binding, located in a low-pLDDT region; R138G, an N-terminal variant in a low-confidence region with experimentally confirmed normal SKP1 binding), one computationally designed benign control (I300V, a conservative hydrophobic substitution), and wildtype reference. Systems were prepared from AlphaFold3 seed_1 monomer structures and simulated in triplicate for 20 ns per replicate using GROMACS 2024.4³⁵ with the AMBER99SB-ILDN force field at 310 K and 1 bar (NPT ensemble, 150 mM NaCl, TIP3P water model), yielding 300 ns aggregate simulation time. Analyses included backbone RMSD, per-residue RMSF, SASA, radius of gyration, and hydrogen-bond occupancy. The 20 ns per-replicate duration is exploratory and insufficient for equilibrium sampling. Complete simulation parameters are provided in Supplementary Text S1.

### Statistical analysis

Pathogenic-versus-benign comparisons used the Mann–Whitney U test (FoldX) and Welch's t-test (Rosetta), with Cohen's d³⁶,³⁷ effect sizes and bootstrap 95% CIs (10,000 iterations). Method correlation was assessed by Spearman's ρ and Pearson's r. Variant-level ΔΔG was aggregated across three structural seeds (n = 88 for Rosetta, n = 90 for FoldX including wildtype). The eight pathogenic-vs-benign tests across monomer, complex, combined, and variant-level analyses were Benjamini–Hochberg FDR corrected. A subgroup analysis restricted to the six ClinVar-validated benign variants tested robustness to computational controls. The 1.0 kcal/mol threshold¹⁶,¹⁷,²³ is the conventional stability-prediction guideline, approximately matching typical prediction error.

Classification analyses (ROC, LOOCV) were performed on the 44 missense variants (23 P/LP, 21 B/LB); the wild-type model served only as a structural reference, and LOOCV refit feature standardisation within each fold. AUC and AUCPR were reported with stratified non-parametric bootstrap 95% CIs (n = 2,000 resamples preserving the pathogenic/benign ratio; pathogenic positive class; AUCPR no-skill baseline = positive-class prevalence). AUC significance was tested by 10,000-iteration label permutation; paired AUC comparisons used DeLong's nonparametric test³⁸ in the Sun–Xu formulation³⁹. Random Forest (100 trees, random_state = 42) provided an orthogonal nonlinear classifier with feature importance by mean decrease in impurity. Data-driven thresholds were derived from Youden's J statistic with bootstrap CIs. Calibration used the Brier score, Brier skill score, and a 5-bin reliability curve; net clinical benefit was evaluated by decision curve analysis²⁴. AlphaMissense²⁰, REVEL²¹, and CADD PHRED²² scores were retrieved from the Ensembl VEP REST API (GRCh38, canonical transcript ENST00000403359) for 43/44 variants; R800K requires two simultaneous nucleotide substitutions (CGG → AAG) and is not represented in single-nucleotide VEP databases.

Across-seed reliability was quantified by ICC(2,1)²⁵,²⁶ and cumulative-seed Spearman rank stability over k = 1–3 seeds. Technical-replicate convergence was assessed from per-replicate Rosetta ΔΔG (1,170 measurements; SEM as a function of cumulative N); FoldX per-replicate variance is reported in Supplementary Table S1.

Significance threshold α = 0.05. Analyses were performed in Python 3.14 with scipy.stats, scikit-learn, and statsmodels; structural visualisations (Figs. 1, S1) used UCSF ChimeraX 1.10.1⁴⁰. Complete analysis scripts are deposited alongside the manuscript.

### Ethics declarations

This study involved computational analysis of publicly available protein sequences and structures. No human subjects, animals, or clinical samples were used. All variant data were obtained from published literature and public databases (ClinVar).

---

## Data availability

All computational data including FoldX and Rosetta ΔΔG values for all systems are provided in Supplementary Table S1. AlphaFold3 structural models can be reproduced using AlphaFold Server (https://alphafoldserver.com) with protein sequences provided in Methods. Analysis scripts are available at https://ykshim2013.github.io/FBXO11_computational_framework/. MD trajectory files (~55 GB) available upon reasonable request to the corresponding author.

---

## Acknowledgements

We acknowledge the AlphaFold team for academic access to the AlphaFold3 server, the FoldX and Rosetta development teams for supporting academic use of their structural modeling platforms, the UCSF ChimeraX development team for molecular visualization software, and the GROMACS development team for providing GPU-accelerated molecular dynamics software for academic research. We thank the Ensembl Variant Effect Predictor team for providing public REST access to AlphaMissense, REVEL, and CADD scores.

---

## Author contributions

Y.S. conceived the study, performed all computational analyses, and wrote the manuscript. E. and K. contributed to data interpretation and critically revised the manuscript. All authors approved the final version.

---

## Competing interests

The authors declare no competing interests.

---

## References

1. Duan, S. *et al.* FBXO11 targets BCL6 for degradation and is inactivated in diffuse large B-cell lymphomas. *Nature* **481**, 90–93 (2012).

2. Schneider, C. *et al.* FBXO11 inactivation leads to abnormal germinal-center formation and lymphoproliferative disease. *Blood* **128**, 660–666 (2016).

3. Zheng, N. & Shabek, N. Ubiquitin ligases: structure, function, and regulation. *Annu. Rev. Biochem.* **86**, 129–157 (2017).

4. Skaar, J. R., Pagan, J. K. & Pagano, M. SCF ubiquitin ligase-targeted therapies. *Nat. Rev. Drug Discov.* **13**, 889–903 (2014).

5. Gregor, A. *et al.* De novo variants in the F-box protein FBXO11 in 20 individuals with a variable neurodevelopmental disorder. *Am. J. Hum. Genet.* **103**, 305–316 (2018).

6. Jansen, S. *et al.* De novo variants in FBXO11 cause a syndromic form of intellectual disability with behavioral problems and dysmorphisms. *Eur. J. Hum. Genet.* **27**, 738–746 (2019).

7. Karczewski, K. J. *et al.* The mutational constraint spectrum quantified from variation in 141,456 humans. *Nature* **581**, 434–443 (2020).

8. Gregor, A. *et al.* De novo missense variants in FBXO11 alter its protein expression and subcellular localization. *Hum. Mol. Genet.* **31**, 440–454 (2022).

9. Pohl, C. & Dikic, I. Cellular quality control by the ubiquitin-proteasome system and autophagy. *Science* **366**, 818–822 (2019).

10. Abramson, J. *et al.* Accurate structure prediction of biomolecular interactions with AlphaFold 3. *Nature* **630**, 493–500 (2024).

11. Jumper, J. *et al.* Highly accurate protein structure prediction with AlphaFold. *Nature* **596**, 583–589 (2021).

12. Tunyasuvunakool, K. *et al.* Highly accurate protein structure prediction for the human proteome. *Nature* **596**, 590–596 (2021).

13. Delgado, J., Radusky, L. G., Cianferoni, D. & Serrano, L. FoldX 5.0: working with RNA, small molecules and a new graphical interface. *Bioinformatics* **35**, 4168–4169 (2019).

14. Park, H. *et al.* Simultaneous optimization of biomolecular energy functions on features from small molecules and macromolecules. *J. Chem. Theory Comput.* **12**, 6201–6212 (2016).

15. Rodrigues, C. H. M., Pires, D. E. V. & Ascher, D. B. DynaMut: predicting the impact of mutations on protein conformation, flexibility and stability. *Nucleic Acids Res.* **46**, W350–W355 (2018).

16. Casadio, R. *et al.* Correlating disease-related mutations to their effect on protein stability: a large-scale analysis of the human proteome. *Hum. Mutat.* **32**, 1161–1170 (2011).

17. Potapov, V., Cohen, M. & Schreiber, G. Assessing computational methods for predicting protein stability upon mutation: good on average but not in the details. *Protein Eng. Des. Sel.* **22**, 553–560 (2009).

18. Karplus, M. & McCammon, J. A. Molecular dynamics simulations of biomolecules. *Nat. Struct. Biol.* **9**, 646–652 (2002).

19. Hollingsworth, S. A. & Dror, R. O. Molecular dynamics simulation for all. *Neuron* **99**, 1129–1143 (2018).

20. Cheng, J. *et al.* Accurate proteome-wide missense variant effect prediction with AlphaMissense. *Science* **381**, eadg7492 (2023).

21. Ioannidis, N. M. *et al.* REVEL: An ensemble method for predicting the pathogenicity of rare missense variants. *Am. J. Hum. Genet.* **99**, 877–885 (2016).

22. Rentzsch, P., Witten, D., Cooper, G. M., Shendure, J. & Kircher, M. CADD: predicting the deleteriousness of variants throughout the human genome. *Nucleic Acids Res.* **47**, D886–D894 (2019).

23. Schymkowitz, J. *et al.* The FoldX web server: an online force field. *Nucleic Acids Res.* **33**, W382–W388 (2005).

24. Vickers, A. J. & Elkin, E. B. Decision curve analysis: a novel method for evaluating prediction models. *Med. Decis. Making* **26**, 565–574 (2006).

25. Shrout, P. E. & Fleiss, J. L. Intraclass correlations: uses in assessing rater reliability. *Psychol. Bull.* **86**, 420–428 (1979).

26. Koo, T. K. & Li, M. Y. A guideline of selecting and reporting intraclass correlation coefficients for reliability research. *J. Chiropr. Med.* **15**, 155–163 (2016).

27. Gapsys, V., Michielssens, S., Seeliger, D. & de Groot, B. L. Accurate and rigorous prediction of the changes in protein free energies in a large-scale mutation scan. *Angew. Chem. Int. Ed. Engl.* **55**, 7364–7368 (2016).

28. Hosmer, D. W., Lemeshow, S. & Sturdivant, R. X. *Applied Logistic Regression* 3rd edn (Wiley, 2013).

29. Richards, S. *et al.* Standards and guidelines for the interpretation of sequence variants: a joint consensus recommendation of the American College of Medical Genetics and Genomics and the Association for Molecular Pathology. *Genet. Med.* **17**, 405–424 (2015).

30. Wang, Y. *et al.* Rapamycin inhibits FBXW7 loss-induced epithelial-mesenchymal transition and cancer stem cell-like characteristics in colorectal cancer cells. *Biochem. Biophys. Res. Commun.* **434**, 352–356 (2013).

31. Zhao, T. *et al.* Loss of nuclear activity of the FBXO7 protein in patients with parkinsonian-pyramidal syndrome (PARK15). *PLoS One* **6**, e16983 (2011).

32. Bonnen, P. E. *et al.* Mutations in FBXL4 cause mitochondrial encephalopathy and a disorder of mitochondrial DNA maintenance. *Am. J. Hum. Genet.* **93**, 471–481 (2013).

33. Sumner, C. J. *et al.* A dominant mutation in FBXO38 causes distal spinal muscular atrophy with calf predominance. *Am. J. Hum. Genet.* **93**, 976–983 (2013).

34. Landrum, M. J. *et al.* ClinVar: improving access to variant interpretations and supporting evidence. *Nucleic Acids Res.* **46**, D1062–D1067 (2018).

35. Abraham, M. J. *et al.* GROMACS: High performance molecular simulations through multi-level parallelism from laptops to supercomputers. *SoftwareX* **1–2**, 19–25 (2015).

36. Cohen, J. *Statistical Power Analysis for the Behavioral Sciences* 2nd edn (Lawrence Erlbaum Associates, 1988).

37. Lakens, D. Calculating and reporting effect sizes to facilitate cumulative science: a practical primer for t-tests and ANOVAs. *Front. Psychol.* **4**, 863 (2013).

38. DeLong, E. R., DeLong, D. M. & Clarke-Pearson, D. L. Comparing the areas under two or more correlated receiver operating characteristic curves: a nonparametric approach. *Biometrics* **44**, 837–845 (1988).

39. Sun, X. & Xu, W. Fast implementation of DeLong's algorithm for comparing the areas under correlated receiver operating characteristic curves. *IEEE Signal Process. Lett.* **21**, 1389–1393 (2014).

40. Pettersen, E. F. *et al.* UCSF ChimeraX: Structure visualization for researchers, educators, and developers. *Protein Sci.* **30**, 70–82 (2021).

---

## Tables

**Table 1 | Computational predictions for 10 pathogenic variants with experimentally validated normal SKP1 binding.**

| Variant | Domain | FoldX ΔΔG (kcal/mol) | Rosetta ΔΔG (kcal/mol) | Exceeds 1.0 kcal/mol | Notes |
|---------|--------|---------------------|----------------------|---------------------|-------|
| R138G | N-terminal | 2.76 ± 1.08 | 1.10 ± 0.52 | Both | pLDDT 25.0 (low confidence) |
| R138S | N-terminal | 1.25 ± 4.16 | −0.65 ± 0.40 | FoldX only† | pLDDT 25.0 (low confidence) |
| Q156R | N-terminal | 1.87 ± 8.60 | −0.78 ± 0.46 | FoldX only† | pLDDT 79.8 |
| Y506C | CASH domain 1 | 2.85 ± 1.08 | 4.91 ± 0.85 | Both | pLDDT 96.9 |
| I538V | CASH domain 1 | 1.41 ± 0.43 | 2.81 ± 0.04 | Both | pLDDT 97.6 |
| T623R | Inter-domain | 1.51 ± 4.29 | 2.93 ± 0.98 | Both | pLDDT 96.3 |
| S840P | C-terminal | 4.54 ± 2.31 | 15.05 ± 1.81 | Both | pLDDT 73.3 |
| A892D | C-terminal | 1.23 ± 4.28 | 4.97 ± 3.35 | Both | pLDDT 71.6 |
| P905R | C-terminal | 1.07 ± 4.44 | 2.12 ± 1.01 | Both | pLDDT 45.1 (low confidence) |
| D910G | C-terminal | 0.45 ± 2.61 | 4.48 ± 0.54 | Rosetta only† | pLDDT 42.9 (low confidence) |

Values shown as mean ± SD across 3 structural seeds for FBXO11–SKP1 complex context. †Method-discordant: only one method exceeds threshold. pLDDT values from AlphaFold3 complex seed 1. Low confidence positions (pLDDT <70) are noted; predictions at these positions should be interpreted with additional caution. Domain assignments based on FBXO11 domain architecture (see Fig. 1a). None of these 10 variants reside within the F-box domain (residues 72–120).


---

## Figure legends

**Figure 1 | Structural context of FBXO11 variants.** (**a**) AlphaFold3-predicted structure of the FBXO11–SKP1 complex (seed 1) with annotated functional domains. FBXO11 (927 residues) is shown with the F-box domain (residues 72–120, magenta) mediating SKP1 interaction, CASH domain 1 (green), CASH domain 2 (cyan), and extended C-terminal region (gray). SKP1 (orange) binds via the F-box domain. Regions with pLDDT < 70 are shown in lighter shading. (**b**) All 44 variant positions mapped onto the FBXO11 structure, color-coded by classification: pathogenic (red spheres, n = 23) and benign (blue spheres, n = 21; darker blue for ClinVar-validated, lighter blue for computational controls). Pathogenic variants are distributed across the entire protein. (**c**) The 10 experimentally validated normal-binding pathogenic variants (yellow spheres) highlighted on the structure, demonstrating that none reside within the F-box domain (magenta) or the SKP1 interface, consistent with preserved binding despite predicted thermodynamic instability.

**Figure 2 | Computational destabilization discriminates pathogenic from benign FBXO11 variants.** (**a**) FoldX ΔΔG distribution. Violin plots with embedded box plots show pathogenic/likely pathogenic (P/LP, red, n = 138: 23 variants × 3 seeds × 2 contexts) and benign/likely benign (B/LB, blue, n = 126: 21 variants × 3 seeds × 2 contexts). Mann–Whitney U test: p = 1.85 × 10⁻³, Cohen's d = 0.50. (**b**) Rosetta ΔΔG distribution. Sample sizes as in (a). Welch's t-test: p = 2.39 × 10⁻⁴, Cohen's d = 0.78. (**c**) Correlation between FoldX and Rosetta predictions. Pathogenic (red circles, n = 138) and benign (blue triangles, n = 126) systems. Spearman's ρ = 0.60 (p = 3.10 × 10⁻¹⁰); Pearson's r = 0.74 (p = 9.26 × 10⁻¹⁷). Dashed lines: 1.0 kcal/mol guideline thresholds. (**d**) Context-specific discrimination. Monomer vs. FBXO11–SKP1 complex (n = 132 per context: 44 variants × 3 seeds). Both contexts show significant P/LP vs. B/LB differences (monomer p < 0.01, complex p < 0.001). Context comparison: p = 0.94 (n.s.). Error bars: standard deviation. All p-values remain significant after Benjamini–Hochberg FDR correction.

**Figure 3 | Computational stability predictions for experimentally validated normal-binding variants.** FoldX (purple) and Rosetta (orange) ΔΔG values for 10 variants showing normal SKP1 binding⁸. Despite preserved binding, FoldX identified 9/10 and Rosetta 8/10 as exceeding the 1.0 kcal/mol guideline threshold (dashed line), with 10/10 detected by either method. Daggers (†): method-discordant predictions. Error bars: SD across 3 conformational seeds. Data shown for FBXO11–SKP1 complex context.

**Figure 4 | Conceptual model of binding-independent pathogenesis in FBXO11 variants.** Schematic illustrating pathways from missense mutation to reduced functional FBXO11. (**a**) Wild-type FBXO11 folds stably, assembles into the SCF complex with SKP1, and localizes to the nucleus for substrate ubiquitination. (**b**) Pathogenic missense variants produce thermodynamically destabilized FBXO11*. Two downstream paths are shown. Left path (grayed): some variants disrupt SKP1 binding, impairing SCF complex assembly (binding-dependent mechanism). Right path (highlighted, this study): other variants preserve SKP1 binding⁸ and assemble into the SCF complex despite thermodynamic destabilization; the destabilized complex is subject to protein quality control (PQC: chaperones, ubiquitin–proteasome system, autophagy), resulting in accelerated degradation, cytoplasmic aggregation, and nuclear exclusion—experimentally observed phenotypes⁸—ultimately reducing functional FBXO11 levels (binding-independent mechanism). Downstream effects on substrate regulation were not assessed in this study.

---

## Supplementary Information

**Supplementary Table S1.** Complete variant dataset with clinical classifications and computational predictions. Excel file containing all 44 missense variants with clinical classifications, ClinVar IDs, literature references, domain annotations, FoldX and Rosetta ΔΔG values across all systems, and statistical summaries. Domain annotations include F-box domain, CASH domain 1, CASH domain 2, inter-domain linker, and C-terminal region assignments for all variant positions.

**Supplementary Table S2.** AlphaFold3 structural quality metrics. pLDDT scores, RMSD values between conformational seeds, and interface quality assessment for both monomer and complex structures.

**Supplementary Table S3.** Threshold-based classification performance across benign group definitions. Sensitivity and specificity at 1.0 and 2.0 kcal/mol thresholds for FoldX, Rosetta, either-method, and both-methods criteria, calculated for both the full benign group (n=21) and the ClinVar-validated benign subgroup (n=6).

**Supplementary Table S4.** Performance metrics at conventional (1.0 kcal/mol) and Youden-optimal thresholds for FoldX, Rosetta, and Combined LR, with bootstrap 95% confidence intervals for thresholds and Youden's J.

**Supplementary Text S1.** Supplementary methods and molecular dynamics analysis. Complete protocols for AlphaFold3 structure generation, FoldX and Rosetta stability calculations, molecular dynamics simulations (including per-variant RMSD trajectories and RMSF profiles), convergence analysis, and statistical analyses.

**Supplementary Figure S1.** Exploratory short-timescale molecular dynamics simulations. Backbone RMSD trajectories over 20 ns for five variants (see Methods), each with three independent replicates (15 trajectories, 300 ns aggregate). Pathogenic variants (G421R, D910G, R138G) show elevated RMSD compared to benign I300V and wildtype. Mean RMSD over 20 ns: pathogenic 3.6 ± 1.4 nm, benign 2.86 ± 1.68 nm, wildtype 2.61 ± 1.48 nm. Shaded regions: SD across replicates. The 20 ns per-replicate duration is insufficient for equilibrium sampling and the results should be interpreted as hypothesis-generating. Simulations: GROMACS 2024.4, AMBER99SB-ILDN, 310 K, 1 bar, 150 mM NaCl, TIP3P water.

**Supplementary Figure S2.** AlphaFold3 conformational seed comparison. Overlay of three AlphaFold3 structural seeds for the FBXO11 monomer, colored by per-residue pLDDT confidence scores (blue: pLDDT >90, cyan: 70–90, yellow: 50–70, orange: <50). The overlay illustrates conformational variation across seeds, with core folded domains (CASH domains, F-box domain) showing high structural consistency across seeds, while N-terminal (residues 1–65) and C-terminal (residues 880–927) regions and inter-domain linkers show substantial conformational variation corresponding to low pLDDT regions. Pairwise RMSD values: seed 1 vs. seed 2 = 19.2 Å, seed 1 vs. seed 3 = 22.4 Å, seed 2 vs. seed 3 = 20.1 Å (full backbone); core domain RMSD (pLDDT >70 residues): 2.1–3.8 Å.

**Supplementary Figure S3.** Benchmarking of physics-based ΔΔG against established variant effect predictors on the 43-variant common subset. (**a**) Forest plot of AUC (left) and AUCPR (right) for FoldX, Rosetta, Combined LR (FoldX + Rosetta, LOOCV), AlphaMissense, REVEL, and CADD PHRED, ordered by AUC; physics-based methods are shown in blue and machine-learning predictors in orange. Markers indicate the point estimate; horizontal bars indicate the stratified non-parametric bootstrap 95 % confidence interval (n = 2,000 resamples preserving the pathogenic/benign ratio). Vertical dashed lines mark chance discrimination (AUC = 0.5, left panel) and the no-skill AUCPR baseline equal to the positive-class prevalence (π = 0.52, right panel); pathogenic is the positive class. (**b**) Pairwise Spearman rank-correlation matrix between all six methods, highlighting the low FoldX–AlphaMissense correlation (ρ = 0.31) — and the comparably low Rosetta–AlphaMissense correlation (ρ = 0.48) — relative to the high AlphaMissense–REVEL correlation (ρ = 0.81) among machine-learning predictors, consistent with physics-based ΔΔG capturing complementary signal.

