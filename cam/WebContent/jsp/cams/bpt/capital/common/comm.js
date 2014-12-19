function help(){
    var revalue=window.showModalDialog(L5.webPath+"/jsp/cams/bpt/comm/getselect_code.jsp?rootId="+struId+"&showOrganType=11,12,13&organType=0&isExact=1&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
    if(revalue!=""&&revalue!=undefined){
          var list = revalue.split(";");
          document.getElementById("domicileCode").value = list[0];
          document.getElementById("domicileName").value = list[1];
       }
}

//在资金发放列表中，当选择"合计"行时，不能进行操作
function totalCancel(registerName){
	if(registerName=="合计"){
		L5.Msg.alert('提示',"无效操作！");
		return false;
	}else{
		return true;
	}
}