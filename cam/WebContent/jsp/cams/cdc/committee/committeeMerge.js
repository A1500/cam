function init(){
	var ds=L5.DatasetMgr.lookup("comExtUserDs");
	ds.newRecord({"organId":organId,"organName":organName,"organType":"SQ","ifVillage":"0"});
	$("ifVillageN").disabled=true;
	$("ifVillageY").disabled=true;
}
function save(){
	if(_$("userId")==""){
		alert("社区行政区划不能为空！");
		return;
	}
	if(_$("userName")==""){
		alert("社区名称不能为空！");
		return;
	}
	if(!$("communityTypeC").checked&&!$("communityTypeN").checked){
		alert("请选择社区类型！");
		return;
	}
	if(_$("pwd")==""){
		alert("密码不能为空！");
		return;
	}
	if(_$("repwd")==""){
		alert("确认密码不能为空！");
		return;
	}
	if(_$("pwd")!=_$("repwd")){
		alert("密码不一致！");
		return;
	}
	var cdcOrganChangeDs=L5.DatasetMgr.lookup("cdcOrganChangeDs");
	if(cdcOrganChangeDs.getCount()<1){
		alert("被合并的社区不能为空！");
		return;
	}
	var ds=L5.DatasetMgr.lookup("comExtUserDs");
	var comExtUser=ds.getCurrent();
	comExtUser.set("areaCode",_$("userId"));
	comExtUser.set("areaName",_$("userName"));
	L5.MessageBox.confirm("提示", "合并的社区将被撤销，是否继续？",function(sta){
		if(sta=="yes"){
			var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcOrganChangeCmd");
			command.setParameter("record", comExtUser);
			command.setParameter("cdcOrganChangeRecords", cdcOrganChangeDs.getAllChangedRecords());
			command.execute("merge");
			if(!command.error){
				var parentWin = window.parent.window;
				var tree=parentWin.L5.getCmp("usertree");
				// 从树中增加合并成立的社区
				var node=tree.getNodeByRecordId(organId, "cityRecord");
				var rec=new parentWin.L5.tree.TreeRecord.recordTypes["userRecord"](ds.getCurrent().data, ds.getCurrent().get("userId"));
				node.record.insert(rec);
				// 从树中删除被合并的社区
				for(var i=0;i<cdcOrganChangeDs.getCount();i++){
					var mergeNode=tree.getNodeByRecordId(cdcOrganChangeDs.getAt(i).get("areaCode"), "userRecord");
					mergeNode.remove();
				}
				
				L5.Msg.alert("提示","保存成功！");
				var url="jsp/cams/cdc/committee/committeeDetail.jsp?userId="+ds.getCurrent().get("userId");
				L5.forward(url);
			}else{
				L5.Msg.alert("提示","保存出错！");
			}
		}else return;
	});
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
function addOrgan(){
	var cdcOrganChangeDs=L5.DatasetMgr.lookup("cdcOrganChangeDs");
	
	var url="selectCommitteeTree.jsp";
	var re=window.showModalDialog(url,"","height=100,width=300");
	if(re==undefined||re.length<1){
		return;
	}
	var id=re[0];
	var name=re[1];
	for(var i=0;i<id.length;i++){
		if(cdcOrganChangeDs.find("areaCode",id[i],0)<0){
			cdcOrganChangeDs.newRecord({"areaCode":id[i],"areaName":name[i]});
		}
	}
}
function deleteOrgan(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length<1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var cdcOrganChangeDs=L5.DatasetMgr.lookup("cdcOrganChangeDs");
	for(var i=0;i<records.length;i++){
		cdcOrganChangeDs.remove(records[i]);
	}
}