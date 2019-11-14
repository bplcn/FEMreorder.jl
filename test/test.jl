using AbaAccess
# using .FEMreorder
InpName = "D:\\Abaqus_Temp\\Ana1.inp";
NodeDict,ElemDict,NSetDict,ElsetDict=MeshObtain(InpName);
NodeDict_new,ElemDict_new,NSetDict_new,ElsetDict_new = femreorder(NodeDict,ElemDict,NSetDict,ElsetDict);
