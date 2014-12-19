function init(){
	var ds=L5.DatasetMgr.lookup("comExtUserDs");
	ds.setParameter("USER_ID@=", userId);
	ds.load();
}
function save(){
	if(_$("userName")==""){
		alert("社区名称不能为空！");
		return;
	}
	if(!$("communityTypeC").checked&&!$("communityTypeN").checked){
		alert("请选择社区类型！");
		return;
	}
	var ds=L5.DatasetMgr.lookup("comExtUserDs");
	var comExtUser=ds.getCurrent();
	comExtUser.set("areaCode",_$("userId"));
	comExtUser.set("areaName",_$("userName"));
	var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcOrganChangeCmd");
	command.setParameter("record", comExtUser);
	command.execute("change");
	
	if(!command.error){
		var parentWin = window.parent.window;
		var tree = parentWin.L5.getCmp("usertree");
		
		var node = tree.getNodeByRecordId(ds.getCurrent().get("userId"), "userRecord");
		node.record.set("userName", ds.getCurrent().get("userName"));
		node.record.commit();
		
		L5.Msg.alert("提示","保存成功！");
		var url="jsp/cams/cdc/committee/committeeDetail.jsp?userId="+ds.getCurrent().get("userId");
		L5.forward(url);
	}else{
		L5.Msg.alert("提示","保存出错！");
	}
}
function communityTypeChange(o){
	if (o.id=="communityTypeC") {
		$("ifVillageN").checked=true;
		$("ifVillageY").checked=false;
		$("ifVillageN").disabled=true;
		$("ifVillageY").disabled=true;
	}else{
		$("ifVillageN").disabled=false;
		$("ifVillageY").disabled=false;
	}
}