
Q
Command: %s
53*	vivadotcl2 
place_design2default:defaultZ4-113h px� 
�
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2"
Implementation2default:default2
xc7a100t2default:defaultZ17-347h px� 
�
0Got license for feature '%s' and/or device '%s'
310*common2"
Implementation2default:default2
xc7a100t2default:defaultZ17-349h px� 
P
Running DRC with %s threads
24*drc2
82default:defaultZ23-27h px� 
V
DRC finished with %s
79*	vivadotcl2
0 Errors2default:defaultZ4-198h px� 
e
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px� 
p
,Running DRC as a precondition to command %s
22*	vivadotcl2 
place_design2default:defaultZ4-22h px� 
P
Running DRC with %s threads
24*drc2
82default:defaultZ23-27h px� 
�
�Input clock phase alignment: The PLLE2_ADV cell input clock signal %s on the %s pin of %s with COMPENSATION mode INTERNAL is driven from the %s pin of another cell of the same type. The two cells are not phase aligned.%s*DRC2�
 "�
Pshell/mig_7series_0/u_nexys_shell_mig_7series_0_0_mig/u_ddr2_infrastructure/loptPshell/mig_7series_0/u_nexys_shell_mig_7series_0_0_mig/u_ddr2_infrastructure/lopt2default:default2default:default2�
 "�
Zshell/mig_7series_0/u_nexys_shell_mig_7series_0_0_mig/u_ddr2_infrastructure/plle2_i/CLKIN1Zshell/mig_7series_0/u_nexys_shell_mig_7series_0_0_mig/u_ddr2_infrastructure/plle2_i/CLKIN12default:default2default:default2�
 "�
Sshell/mig_7series_0/u_nexys_shell_mig_7series_0_0_mig/u_ddr2_infrastructure/plle2_i	Sshell/mig_7series_0/u_nexys_shell_mig_7series_0_0_mig/u_ddr2_infrastructure/plle2_i2default:default2default:default2\
 "F
PLLE2_BASE_inst/CLKOUT0PLLE2_BASE_inst/CLKOUT02default:default2default:default2C
 +DRC|Netlist|Instance|Required Pin|PLLE2_ADV2default:default8Z	REQP-1715h px� 
b
DRC finished with %s
79*	vivadotcl2(
0 Errors, 1 Warnings2default:defaultZ4-198h px� 
e
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px� 
U

Starting %s Task
103*constraints2
Placer2default:defaultZ18-103h px� 
}
BMultithreading enabled for place_design using a maximum of %s CPUs12*	placeflow2
82default:defaultZ30-611h px� 
v

Phase %s%s
101*constraints2
1 2default:default2)
Placer Initialization2default:defaultZ18-101h px� 
�

Phase %s%s
101*constraints2
1.1 2default:default29
%Placer Initialization Netlist Sorting2default:defaultZ18-101h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:00.012default:default2
00:00:00.012default:default2
2601.4182default:default2
0.0002default:default2
53022default:default2
114422default:defaultZ17-722h px� 
[
FPhase 1.1 Placer Initialization Netlist Sorting | Checksum: 1394d839e
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:00.02 ; elapsed = 00:00:00.04 . Memory (MB): peak = 2601.418 ; gain = 0.000 ; free physical = 5302 ; free virtual = 114422default:defaulth px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:002default:default2
2601.4182default:default2
0.0002default:default2
53022default:default2
114422default:defaultZ17-722h px� 
�

Phase %s%s
101*constraints2
1.2 2default:default2F
2IO Placement/ Clock Placement/ Build Placer Device2default:defaultZ18-101h px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
h
SPhase 1.2 IO Placement/ Clock Placement/ Build Placer Device | Checksum: 15394cf0a
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:09 ; elapsed = 00:00:04 . Memory (MB): peak = 2601.418 ; gain = 0.000 ; free physical = 5240 ; free virtual = 113802default:defaulth px� 
}

Phase %s%s
101*constraints2
1.3 2default:default2.
Build Placer Netlist Model2default:defaultZ18-101h px� 
P
;Phase 1.3 Build Placer Netlist Model | Checksum: 270c17af7
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:26 ; elapsed = 00:00:10 . Memory (MB): peak = 2614.414 ; gain = 12.996 ; free physical = 5193 ; free virtual = 113342default:defaulth px� 
z

Phase %s%s
101*constraints2
1.4 2default:default2+
Constrain Clocks/Macros2default:defaultZ18-101h px� 
M
8Phase 1.4 Constrain Clocks/Macros | Checksum: 270c17af7
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:26 ; elapsed = 00:00:10 . Memory (MB): peak = 2614.414 ; gain = 12.996 ; free physical = 5193 ; free virtual = 113342default:defaulth px� 
I
4Phase 1 Placer Initialization | Checksum: 270c17af7
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:26 ; elapsed = 00:00:10 . Memory (MB): peak = 2614.414 ; gain = 12.996 ; free physical = 5194 ; free virtual = 113342default:defaulth px� 
q

Phase %s%s
101*constraints2
2 2default:default2$
Global Placement2default:defaultZ18-101h px� 
p

Phase %s%s
101*constraints2
2.1 2default:default2!
Floorplanning2default:defaultZ18-101h px� 
C
.Phase 2.1 Floorplanning | Checksum: 266be6ca1
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:33 ; elapsed = 00:00:12 . Memory (MB): peak = 2655.984 ; gain = 54.566 ; free physical = 5169 ; free virtual = 113102default:defaulth px� 
x

Phase %s%s
101*constraints2
2.2 2default:default2)
Global Placement Core2default:defaultZ18-101h px� 
�

Phase %s%s
101*constraints2
2.2.1 2default:default20
Physical Synthesis In Placer2default:defaultZ18-101h px� 
K
)No high fanout nets found in the design.
65*physynthZ32-65h px� 
�
$Optimized %s %s. Created %s new %s.
216*physynth2
02default:default2
net2default:default2
02default:default2
instance2default:defaultZ32-232h px� 
�
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
12default:default2
02default:default2
net or cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:defaultZ32-775h px� 
j
FNo candidate cells for DSP register optimization found in the design.
274*physynthZ32-456h px� 
�
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
22default:default2
02default:default2
net or cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:defaultZ32-775h px� 
h
DNo candidate cells for SRL register optimization found in the design349*physynthZ32-677h px� 
�
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
12default:default2
02default:default2
net or cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:defaultZ32-775h px� 
i
ENo candidate cells for BRAM register optimization found in the design297*physynthZ32-526h px� 
�
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
12default:default2
02default:default2
net or cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:defaultZ32-775h px� 
R
.No candidate nets found for HD net replication521*physynthZ32-949h px� 
�
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
12default:default2
02default:default2
net or cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:defaultZ32-775h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:00.012default:default2
00:00:00.012default:default2
2655.9842default:default2
0.0002default:default2
51522default:default2
112932default:defaultZ17-722h px� 
B
-
Summary of Physical Synthesis Optimizations
*commonh px� 
B
-============================================
*commonh px� 


*commonh px� 


*commonh px� 
�
�----------------------------------------------------------------------------------------------------------------------------------------
*commonh px� 
�
�|  Optimization                  |  Added Cells  |  Removed Cells  |  Optimized Cells/Nets  |  Dont Touch  |  Iterations  |  Elapsed   |
----------------------------------------------------------------------------------------------------------------------------------------
*commonh px� 
�
�|  Very High Fanout              |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
|  DSP Register                  |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
|  Shift Register                |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
|  BRAM Register                 |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
|  HD Interface Net Replication  |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
|  Total                         |            0  |              0  |                     0  |           0  |           5  |  00:00:00  |
----------------------------------------------------------------------------------------------------------------------------------------
*commonh px� 


*commonh px� 


*commonh px� 
T
?Phase 2.2.1 Physical Synthesis In Placer | Checksum: 17f5db3de
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:19 ; elapsed = 00:00:31 . Memory (MB): peak = 2655.984 ; gain = 54.566 ; free physical = 5152 ; free virtual = 112932default:defaulth px� 
K
6Phase 2.2 Global Placement Core | Checksum: 20b5718f6
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:21 ; elapsed = 00:00:32 . Memory (MB): peak = 2655.984 ; gain = 54.566 ; free physical = 5163 ; free virtual = 113042default:defaulth px� 
D
/Phase 2 Global Placement | Checksum: 20b5718f6
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:21 ; elapsed = 00:00:32 . Memory (MB): peak = 2655.984 ; gain = 54.566 ; free physical = 5175 ; free virtual = 113152default:defaulth px� 
q

Phase %s%s
101*constraints2
3 2default:default2$
Detail Placement2default:defaultZ18-101h px� 
}

Phase %s%s
101*constraints2
3.1 2default:default2.
Commit Multi Column Macros2default:defaultZ18-101h px� 
P
;Phase 3.1 Commit Multi Column Macros | Checksum: 1ef569d0e
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:28 ; elapsed = 00:00:34 . Memory (MB): peak = 2655.984 ; gain = 54.566 ; free physical = 5170 ; free virtual = 113102default:defaulth px� 


Phase %s%s
101*constraints2
3.2 2default:default20
Commit Most Macros & LUTRAMs2default:defaultZ18-101h px� 
R
=Phase 3.2 Commit Most Macros & LUTRAMs | Checksum: 210aba826
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:41 ; elapsed = 00:00:39 . Memory (MB): peak = 2655.984 ; gain = 54.566 ; free physical = 5171 ; free virtual = 113112default:defaulth px� 
y

Phase %s%s
101*constraints2
3.3 2default:default2*
Area Swap Optimization2default:defaultZ18-101h px� 
L
7Phase 3.3 Area Swap Optimization | Checksum: 1a2858ec1
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:42 ; elapsed = 00:00:39 . Memory (MB): peak = 2655.984 ; gain = 54.566 ; free physical = 5171 ; free virtual = 113112default:defaulth px� 
�

Phase %s%s
101*constraints2
3.4 2default:default22
Pipeline Register Optimization2default:defaultZ18-101h px� 
T
?Phase 3.4 Pipeline Register Optimization | Checksum: 17857a336
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:42 ; elapsed = 00:00:39 . Memory (MB): peak = 2655.984 ; gain = 54.566 ; free physical = 5171 ; free virtual = 113112default:defaulth px� 


Phase %s%s
101*constraints2
3.5 2default:default20
Small Shape Detail Placement2default:defaultZ18-101h px� 
R
=Phase 3.5 Small Shape Detail Placement | Checksum: 24db62068
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:55 ; elapsed = 00:00:52 . Memory (MB): peak = 2655.984 ; gain = 54.566 ; free physical = 5127 ; free virtual = 112672default:defaulth px� 
u

Phase %s%s
101*constraints2
3.6 2default:default2&
Re-assign LUT pins2default:defaultZ18-101h px� 
H
3Phase 3.6 Re-assign LUT pins | Checksum: 21539a1cd
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:57 ; elapsed = 00:00:54 . Memory (MB): peak = 2655.984 ; gain = 54.566 ; free physical = 5128 ; free virtual = 112682default:defaulth px� 
�

Phase %s%s
101*constraints2
3.7 2default:default22
Pipeline Register Optimization2default:defaultZ18-101h px� 
T
?Phase 3.7 Pipeline Register Optimization | Checksum: 180fef9bc
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:58 ; elapsed = 00:00:54 . Memory (MB): peak = 2655.984 ; gain = 54.566 ; free physical = 5128 ; free virtual = 112682default:defaulth px� 
D
/Phase 3 Detail Placement | Checksum: 180fef9bc
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:58 ; elapsed = 00:00:54 . Memory (MB): peak = 2655.984 ; gain = 54.566 ; free physical = 5128 ; free virtual = 112682default:defaulth px� 
�

Phase %s%s
101*constraints2
4 2default:default2<
(Post Placement Optimization and Clean-Up2default:defaultZ18-101h px� 
{

Phase %s%s
101*constraints2
4.1 2default:default2,
Post Commit Optimization2default:defaultZ18-101h px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
�

Phase %s%s
101*constraints2
4.1.1 2default:default2/
Post Placement Optimization2default:defaultZ18-101h px� 
V
APost Placement Optimization Initialization | Checksum: 158832ae0
*commonh px� 
u

Phase %s%s
101*constraints2
4.1.1.1 2default:default2"
BUFG Insertion2default:defaultZ18-101h px� 
�
PProcessed net %s, BUFG insertion was skipped due to placement/routing conflicts.32*	placeflow2b
Nst/core_top_module/pipeline_top_module/decode_module/rf_module/PLLE2_BASE_inst2default:defaultZ46-33h px� 
�
�BUFG insertion identified %s candidate nets. Inserted BUFG: %s, Replicated BUFG Driver: %s, Skipped due to Placement/Routing Conflicts: %s, Skipped due to Timing Degradation: %s, Skipped due to Illegal Netlist: %s.43*	placeflow2
12default:default2
02default:default2
02default:default2
12default:default2
02default:default2
02default:defaultZ46-56h px� 
H
3Phase 4.1.1.1 BUFG Insertion | Checksum: 158832ae0
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:02:16 ; elapsed = 00:00:59 . Memory (MB): peak = 2679.785 ; gain = 78.367 ; free physical = 5134 ; free virtual = 112752default:defaulth px� 
�
hPost Placement Timing Summary WNS=%s. For the most accurate timing information please run report_timing.610*place2
0.6262default:defaultZ30-746h px� 
S
>Phase 4.1.1 Post Placement Optimization | Checksum: 209b19836
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:02:20 ; elapsed = 00:01:01 . Memory (MB): peak = 2679.785 ; gain = 78.367 ; free physical = 5134 ; free virtual = 112742default:defaulth px� 
N
9Phase 4.1 Post Commit Optimization | Checksum: 209b19836
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:02:20 ; elapsed = 00:01:01 . Memory (MB): peak = 2679.785 ; gain = 78.367 ; free physical = 5134 ; free virtual = 112742default:defaulth px� 
y

Phase %s%s
101*constraints2
4.2 2default:default2*
Post Placement Cleanup2default:defaultZ18-101h px� 
L
7Phase 4.2 Post Placement Cleanup | Checksum: 209b19836
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:02:21 ; elapsed = 00:01:02 . Memory (MB): peak = 2679.785 ; gain = 78.367 ; free physical = 5134 ; free virtual = 112752default:defaulth px� 
s

Phase %s%s
101*constraints2
4.3 2default:default2$
Placer Reporting2default:defaultZ18-101h px� 
F
1Phase 4.3 Placer Reporting | Checksum: 209b19836
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:02:21 ; elapsed = 00:01:02 . Memory (MB): peak = 2679.785 ; gain = 78.367 ; free physical = 5134 ; free virtual = 112752default:defaulth px� 
z

Phase %s%s
101*constraints2
4.4 2default:default2+
Final Placement Cleanup2default:defaultZ18-101h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:002default:default2
2679.7852default:default2
0.0002default:default2
51342default:default2
112752default:defaultZ17-722h px� 
M
8Phase 4.4 Final Placement Cleanup | Checksum: 16c712b39
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:02:21 ; elapsed = 00:01:02 . Memory (MB): peak = 2679.785 ; gain = 78.367 ; free physical = 5134 ; free virtual = 112752default:defaulth px� 
\
GPhase 4 Post Placement Optimization and Clean-Up | Checksum: 16c712b39
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:02:21 ; elapsed = 00:01:02 . Memory (MB): peak = 2679.785 ; gain = 78.367 ; free physical = 5134 ; free virtual = 112752default:defaulth px� 
=
(Ending Placer Task | Checksum: eda879cb
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:02:21 ; elapsed = 00:01:02 . Memory (MB): peak = 2679.785 ; gain = 78.367 ; free physical = 5134 ; free virtual = 112752default:defaulth px� 
Z
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83h px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
642default:default2
12default:default2
02default:default2
02default:defaultZ4-41h px� 
^
%s completed successfully
29*	vivadotcl2 
place_design2default:defaultZ4-42h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2"
place_design: 2default:default2
00:02:262default:default2
00:01:042default:default2
2679.7852default:default2
78.3672default:default2
51702default:default2
113112default:defaultZ17-722h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:002default:default2
2679.7852default:default2
0.0002default:default2
51702default:default2
113112default:defaultZ17-722h px� 
H
&Writing timing data to binary archive.266*timingZ38-480h px� 
D
Writing placer database...
1603*designutilsZ20-1893h px� 
=
Writing XDEF routing.
211*designutilsZ20-211h px� 
J
#Writing XDEF routing logical nets.
209*designutilsZ20-209h px� 
J
#Writing XDEF routing special nets.
210*designutilsZ20-210h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2)
Write XDEF Complete: 2default:default2
00:00:062default:default2
00:00:022default:default2
2679.7852default:default2
0.0002default:default2
51122default:default2
112932default:defaultZ17-722h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2default:default2�
z/home/mtahir/SOC/FPGA/PCore_Git_FPGA/UETRV-PCore/FPGA_Target/Nexys-A7/Nexys-A7-Project/Nexys-A7.runs/impl_1/top_placed.dcp2default:defaultZ17-1381h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2&
write_checkpoint: 2default:default2
00:00:112default:default2
00:00:072default:default2
2679.7852default:default2
0.0002default:default2
51602default:default2
113102default:defaultZ17-722h px� 
^
%s4*runtcl2B
.Executing : report_io -file top_io_placed.rpt
2default:defaulth px� 
�
�report_io: Time (s): cpu = 00:00:00.18 ; elapsed = 00:00:00.26 . Memory (MB): peak = 2679.785 ; gain = 0.000 ; free physical = 5151 ; free virtual = 11300
*commonh px� 
�
%s4*runtcl2r
^Executing : report_utilization -file top_utilization_placed.rpt -pb top_utilization_placed.pb
2default:defaulth px� 
{
%s4*runtcl2_
KExecuting : report_control_sets -verbose -file top_control_sets_placed.rpt
2default:defaulth px� 
�
�report_control_sets: Time (s): cpu = 00:00:00.62 ; elapsed = 00:00:00.68 . Memory (MB): peak = 2679.785 ; gain = 0.000 ; free physical = 5156 ; free virtual = 11306
*commonh px� 


End Record