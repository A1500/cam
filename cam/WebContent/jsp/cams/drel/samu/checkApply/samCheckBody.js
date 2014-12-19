function init(){
	var samListDataSet=L5.DatasetMgr.lookup("samListDataSet");
	samListDataSet.setParameter("areaLevelId",organCode);
	samListDataSet.load();
}
function query(){
	var samListDataSet=L5.DatasetMgr.lookup("samListDataSet");
	samListDataSet.setParameter("checkDate",document.getElementById("checkDateQuery").value);
	samListDataSet.setParameter("gerocomiumName",document.getElementById("gerocomiumIdQuery").value);
	samListDataSet.setParameter("areaLevelId",organCode);	
	samListDataSet.load();
}
var flag=true;//敬老院是否有在院供养对象的标志
function checkGero(){
	var gerocomiumName=document.getElementById("gerocomiumName").value;
	var samGeroKeptPersonDataSet=L5.DatasetMgr.lookup("samGeroKeptPersonDataSet");
	samGeroKeptPersonDataSet.setParameter("GEROCOMIUM_ID@=",gerocomiumName);
	samGeroKeptPersonDataSet.setParameter("IS_STATUS@=","1");
	samGeroKeptPersonDataSet.load();
	samGeroKeptPersonDataSet.on('load',function(){
		if(samGeroKeptPersonDataSet.getCount()==0){
			L5.Msg.alert("提示","此敬老院无供养对象！");
			flag=false;
			return ;
		}else{
			flag=true;
		}
	});
}
function saveList(){
	var gerocomiumName=document.getElementById("gerocomiumName").value;
	var checkDate=document.getElementById("checkDate").value;
	var checkResult=document.getElementById("checkResult").value;
	if(gerocomiumName==''||gerocomiumName==null){
		L5.Msg.alert("提示","敬老院名称不能为空！");
		return;
	}
	if(checkDate==''||checkDate==null){
		L5.Msg.alert("提示","查体时间不能为空！");
		return;
	}
	if(checkResult==''||checkResult==null){
		L5.Msg.alert("提示","查体结果不能为空！");
		return;
	}
	if(flag==false){
		L5.Msg.alert("提示","此敬老院无供养对象！");
		return;
	}
	var samListDataSet=L5.DatasetMgr.lookup("samListDataSet");
	var records=samListDataSet.getAllRecords();
	if(records.length!=0){
		for(var i=0;i<records.length;i++){
			if(records[i].get("GEROCOMIUM_ID")==gerocomiumName && records[i].get("CHECK_DATE")==checkDate){
				L5.Msg.alert("提示","名册已登记！");
				return;
			}
		}
	}
	var command=new L5.Command("com.inspur.cams.drel.samu.cmd.SamGeroApplyCmd");
	command.setParameter("gerocomiumName",gerocomiumName);
	command.setParameter("checkDate",checkDate);
	command.setParameter("checkResult",checkResult);
	command.execute("insertCheck");
	if (!command.error){
		L5.Msg.alert("提示","名册保存成功！",function(){
			closeListWin();
		});
	}else{
		L5.Msg.alert("提示","保存出错！");
	}
}
function insertList(){
	var win=L5.getCmp("addListWin");
	win.show(this);
	document.getElementById("gerocomiumName").value='';
	document.getElementById("checkDate").value='';
	document.getElementById("checkResult").value='';
	var samGeroDataSet=L5.DatasetMgr.lookup("samGeroDataSet");
	if(organArea.substr(2,10)=="0000000000"){
		samGeroDataSet.setParameter("filterSql","SUBSTR(AREA_LEVEL_ID,1,2) LIKE '%" + organArea.substring(0, 2) + "%' AND IF_CURRENT='1'");
	}else if(organArea.substr(4,8)=="00000000"){
		samGeroDataSet.setParameter("filterSql","SUBSTR(AREA_LEVEL_ID,1,4) LIKE '%" + organArea.substring(0, 4) + "%' AND IF_CURRENT='1'");
	}else if(organArea.substr(6,6)=="000000"){
		samGeroDataSet.setParameter("filterSql","SUBSTR(AREA_LEVEL_ID,1,6) LIKE '%" + organArea.substring(0, 6) + "%' AND IF_CURRENT='1'");
	}
	samGeroDataSet.load();
	//supportOrgDataset.setParameter("filterSql", "SUBSTR(ORGAN_AREA_CODE,1,6)= '" + organArea.substring(0, 6) + "' AND ORGAN_STATUS='1'");
}
function editDetail(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var gerocomiumId=records[0].get('GEROCOMIUM_ID');
	var checkDate=records[0].get('CHECK_DATE');
	var remarks=records[0].get('REMARKS');
	var width = 900;
	var height = 500;
	var url="samCheckInsert.jsp?gerocomiumId="+gerocomiumId+"&checkDate="+checkDate+"&remarks="+remarks;
	window.showModalDialog(url, window, "scroll:0;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
}
function deleteList(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length==0){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	L5.MessageBox.confirm('确定', '确定要确认名册吗？', function(state) {
		if(state=="yes"){
			var gerocomiumId=records[0].get('GEROCOMIUM_ID');
			var checkDate=records[0].get('CHECK_DATE');
			var command=new L5.Command("com.inspur.cams.drel.samu.cmd.SamGeroApplyCmd");
			command.setParameter("gerocomiumId",gerocomiumId);
			command.setParameter("checkDate",checkDate);
			command.execute("deleteCheckList");
			if (!command.error){
				L5.Msg.alert("提示","名册删除成功！",function(){
					query();
				});
			}else{
				L5.Msg.alert("提示","名册删除出错！");
			}
		}
	});
}
function closeListWin(){
	L5.getCmp("addListWin").setVisible(false);
	query();
}
function getOrganArea(){
	if(organArea.endsWith("0000000000")){//省370000000000
			return organArea.substring(0,2);
		} else if (organArea.endsWith("00000000")){//市370100000000
			return organArea.substring(0,4);
		} else if (organArea.endsWith("000000")){//县370104000000
			return organArea.substring(0,6);
		} else if (organArea.endsWith("000")){//乡370104003000
			return organArea.substring(0,9);
		}
        return organArea;
}
//名册时间转换为超链接
function detailRender(value, cellmeta, record, rowindex, colindex, dataset) {
	return '<a href="javascript:detail(\'' + record.get('GEROCOMIUM_ID')+'\',\''+ record.get('CHECK_DATE')+'\')">'
			+ value + '</a>';
}
// 名册时间-查看明细
function detail(GEROCOMIUM_ID,CHECK_DATE) {
	var width = 900;
	var height = 500;
	var url = "samCheckBodyDetail.jsp?gerocomiumId=" + GEROCOMIUM_ID+"&checkDate="+CHECK_DATE;
	var win = window.showModalDialog(url, window,
			"scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:"
					+ height + "px;resizable:1");
}
//弹出敬老院
function func_ForGeroSelect(){
	var revalue = window.showModalDialog(
			L5.webPath + "/jsp/cams/drel/samu/geroTree/geroTree.jsp?radioMaxlevel=0&organCode="
					+ organArea + "&organName="
					+ escape(encodeURIComponent(organName)), "",
			"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
	if (revalue != "" && revalue != undefined) {
		var list = revalue.split(";");
		document.getElementById("gerocomiumIdQuery").value = list[0];
		document.getElementById("gerocomiumNameQuery").value = list[1];
	}
}