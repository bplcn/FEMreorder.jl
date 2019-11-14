function femreorder(NodeDict,ElemDict,NSetDict,ElsetDict)
#=
The function reorder the ID of nodes and elements of an .inp file.
=#
    nodeIDArray_old = collect(keys(NodeDict));
    elemIDArray_old = collect(keys(ElemDict));
    Nodeold2newDict,Nodenew2oldDict = IDreorder(nodeIDArray_old);
    Elemold2newDict,Elemnew2oldDict = IDreorder(elemIDArray_old);

    NodeDict_new = Dict();
    nodeIDArray_new = collect(keys(Nodenew2oldDict));
    for nodeIDnew in nodeIDArray_new
        nodeIDold = Nodeold2newDict[nodeIDnew];
        NodeDict_new[nodeIDnew] = NodeDict[nodeIDold];
    end

    ElemDict_new = Dict();
    elemIDArray_new = collect(keys(Elemnew2oldDict))
    for elemIDnew in elemIDArray_new
        elemIDold = Elemold2newDict[elemIDnew];
        nodeIDhere_new = deepcopy(ElemDict[elemIDold]);
        for knum = 1:length(nodeIDhere_new)
            nodeIDhere_new[knum] = Nodeold2newDict[ElemDict[elemIDold][knum]];
        end
        ElemDict_new[elemIDnew] = nodeIDhere_new;
    end

    NSetDict_new = Dict();
    NSetNamesArray = collect(keys(NSetDict));
    for setname in NSetNamesArray
        SetMembersArray_old = NSetDict[setname];
        SetMembersArray_new = deepcopy(SetMembersArray_old);
        ntotal = length(SetMembersArray_new)
        for knum = 1:ntotal
            SetMembersArray_new[knum] = Nodenew2oldDict[SetMembersArray_old[knum]];
        end
        NSetDict_new[setname] = SetMembersArray_new;
    end

    ElsetDict_new = Dict();
    ElsetNamesArray = collect(keys(ElsetDict));
    for setname in ElsetNamesArray
        SetMembersArray_old = ElsetDict[setname];
        SetMembersArray_new = deepcopy(SetMembersArray_old);
        ntotal = length(SetMembersArray_new)
        for knum = 1:ntotal
            SetMembersArray_new[knum] = Elemold2newDict[SetMembersArray_old[knum]];
        end
        ElsetDict_new[setname] = SetMembersArray_new;
    end
    return NodeDict_new,ElemDict_new,NSetDict_new,ElsetDict_new
end

function IDreorder(IDArray;beginid=1,inc=1)
# reorder of id 
    sort!(IDArray);
    ntotal = length(IDArray);
    old2newDict = Dict();
    new2oldDict = Dict();
    for knum = 1:ntotal
        old2newDict[IDArray[knum]]=knum;
        new2oldDict[knum]=IDArray[knum];
    end
    return old2newDict,new2oldDict
end