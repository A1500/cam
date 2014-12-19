function init() {
	query();
}
function update(){
	var editGrid=L5.getCmp('baseGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一个要修改的记录!");
		return false;
	}
	var cf = selected[0].get('COMMIT_FLAG');
	var vf = selected[0].get('VALIDATE_FLAG');
	if(vf=="重复数据"||cf=="是"){
		L5.Msg.alert('提示', "不能修改重复或已提交信息！");
		return;
	}
	var id = selected[0].get('ID');
	var url=L5.webPath+"/jsp/cams/bpt/excelToTable/war/warErrUpdate.jsp?id=" + id  ;
	var width = screen.width-100;
   	var height = screen.height-140;
   	var win = window.showModalDialog (url,window,"scroll:no;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	query();
	if (win==null) {
		return;
	} 
	
	return win;
}
function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	WarErrDataset.setParameter("organCode",user);
	WarErrDataset.setParameter("makeTable","bpt_imp_war_make");
	WarErrDataset.load();
}

//参战错误导出
function errExp(){
	var pringDs = L5.DatasetMgr.lookup("WarErrDataset");
	pringDs.setParameter("organCode",user);
	pringDs.setParameter("makeTable","bpt_imp_war_make");
	pringDs.setParameter("expErrFlag","1");
	pringDs.on("load",function(){
		L5.dataset2excel(pringDs,"/jsp/cams/bpt/excelToTable/excel/errExcel.jsp?pageIndex="+pringDs.pageInfo.pageIndex);
	});
	pringDs.load();
}

/**
 * 所属机构窗口
 */
function forHelp(){
		//var struId='<%=struId%>';
		var revalue=window.showModalDialog("../../../../../jsp/bsp/organization/getselect_code.jsp?rootId="+struId+"&showOrganType=11,12,13&organType=0&isExact=1&isCheckBox=0&isTree=1","","dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		
		if(revalue!=""&&revalue!=undefined){
		var list = revalue.split(";");
		document.getElementById("domicileCode").value = list[0];
		document.getElementById("domicileName").value = list[1];
		}
}
function into(){
	var xmlPath="com/inspur/cams/bpt/excelToTable/bathXml/war.xml" ;
	var enumsPath="com/inspur/cams/bpt/excelToTable/bathXml/cams.bpt.enums";
	 var msg=excelToTable(xmlPath,enumsPath,organCode);
	 if(msg!=null){
	 	
	 	var m = msg.split(";");
	 	if(m[5]=="1"){
	 		alert("导入的信息过多！");
	 	}
	 	if(m[4]=="1"){
	 		alert("选择模板错误！");
	 	}else if(m[4]=="2"){
	 		alert("模板列发生改变，请检查是否更改列！");
	 	}
	 	if(m[2]=="0"){
	 		if(confirm("验证成功！是否写入数据库?")){
	 			var command = new L5.Command("com.inspur.cams.bpt.excelToTable.command.WarCommand");
	 			command.setParameter("user", user);
				command.execute("saveDisability");
				if (!command.error) {
					alert("成功写入数据库！");
				} else {
					L5.Msg.alert('提示', "保存时出现错误！" + command.error);
				}
	 		}
	 	}else if(m[2]=="-1"){
	 		alert("错误:"+m[3]);
	 	}else if(m[2]=="AOE"){
	 		alert("模板已损坏！请复制到新模板后再次导入！");
	 	}else if(m[2]!="-1"&&m[2]!="0"){
	 		alert("导入的信息有误！请查正后再次导入！");
	 	}
	 	query();
	 	
	 }
	 	
}

function save(){
	var editGrid=L5.getCmp('baseGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示', "请选择提交的数据！");
		return;
	}
	for(var i=0;i<selected.length;i++){
		var cf = selected[i].get('COMMIT_FLAG');
		var vf = selected[i].get('VALIDATE_FLAG');
		var idcard = selected[i].get('ID_CARD');
		var name = selected[i].get('NAME');
		if(vf=="验证失败"||vf=="重复数据"||cf=="是"){
			L5.Msg.alert('提示', "提交的信息有误,重复或已提交！");
			return;
		}
		var isSame =idCardIsSame(idcard);
		if(isSame){
			L5.Msg.alert('提示', name+"已存在！");
			return;
		}
	}
	
	
	var command = new L5.Command("com.inspur.cams.bpt.excelToTable.command.WarCommand");
	command.setParameter("disabiltyErrRecords", selected);
	command.execute("saveDisability");
	if (!command.error) {
		L5.Msg.alert('提示', "保存成功！");
		query();
	} else {
		L5.Msg.alert('提示', "保存时出现错误！" + command.error);
	}
}
function idCardIsSame(idCard){
	var command = new L5.Command("com.inspur.cams.bpt.excelToTable.command.DisabilityCommand");
	command.setParameter("idCard",idCard);
	command.execute("idCardIsSame");
	var isSame=command.getReturn("isSame");
	return isSame;
}
function del(){
	var editGrid=L5.getCmp('baseGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示', "请选择删除的数据！");
		return;
	}
	var command = new L5.Command("com.inspur.cams.bpt.excelToTable.ExcelToTableCommand");
	command.setParameter("ErrRecords", selected);
	command.setParameter("makeTable", "bpt_imp_war_make");
	command.execute("deleteById");
	if (!command.error) {
		L5.Msg.alert('提示', "删除成功！");
		query();
	} else {
		L5.Msg.alert('提示', "删除时出现错误！" + command.error);
	}
}

//下载参战Excel导入模版
function downTemplate(){
	var filename = 'canzhanmoban.xls';
	var path = 'jsp/cams/bpt/excelToTable/excel/war.xls';
	window.location=L5.webPath+"/fileDownload?filePath="+path + "&fileName="+filename + "&project=1";
}