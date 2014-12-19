function help(){
    var revalue=window.showModalDialog("../../../../jsp/cams/bpt/comm/getselect_code.jsp?rootId="+struId+"&showOrganType=11,12,13&organType=0&isExact=1&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
    if(revalue!=""&&revalue!=undefined){
          var list = revalue.split(";");
          document.getElementById("domicileCode").value = list[0];
          document.getElementById("domicileName").value = list[1];
       }
}