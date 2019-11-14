using AbaAccess
# using .FEMreorder
InpName = "D:\\working\\Analysis2.inp";
NodeDict,ElemDict,NSetDict,ElsetDict=MeshObtain(InpName);
NodeDict_new,ElemDict_new,NSetDict_new,ElsetDict_new = femreorder(NodeDict,ElemDict,NSetDict,ElsetDict);

fID = open("D:\\working\\Analysis2_reorder.inp","w")
println(fID,"*Node")
for nodeID in 1:length(NodeDict_new)
    println(fID,"$(nodeID),$(NodeDict_new[nodeID][1]),$(NodeDict_new[nodeID][2]),$(NodeDict_new[nodeID][3])")
end

println(fID,"*Element,type=C3D4")
for elemID in 1:length(ElemDict_new)
    println(fID,"$(elemID),$(ElemDict_new[elemID][1]),$(ElemDict_new[elemID][2]),$(ElemDict_new[elemID][3]),$(ElemDict_new[elemID][4])")
end

for (setname,memberIDArray) in NSetDict_new
    println(fID,"*Nset,nset="*setname)
    for memberid in memberIDArray 
        println(fID,"$(memberid),")
    end
end

for (setname,memberIDArray) in ElsetDict_new
    println(fID,"*Elset,Elset="*setname)
    for memberid in memberIDArray 
        println(fID,"$(memberid),")
    end
end

close(fID)