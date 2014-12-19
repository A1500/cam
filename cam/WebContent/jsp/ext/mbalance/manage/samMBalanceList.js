//页面初始化
function init() {
	document.getElementById("hosStatus").value=1;
	ds.setParameter("hosStatus","1");
	ds.setParameter("hospitalId",organId);
	ds.setParameter("strikeStatus","'00','03'");
	//L5.DatasetMgr.lookup("ds").load();
	L5.QuickTips.init();
};
//根据ElementId得到组件的value
function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
//查询方法
function query(){
	ds.setParameter("hospitalId",organId);
	ds.setParameter("strikeStatus","'00','03'");
	ds.setParameter("disease",getParam("disease"));		
	ds.setParameter("insuranceType",getParam("insuranceType"));		
	ds.setParameter("assitanceType",getParam("assitanceType"));	
	ds.setParameter("hospitalRecordId",getParam("hospitalRecordId"));
	ds.setParameter("inTime",getParam("inTime"));
	ds.setParameter("hosStatus",getParam("hosStatus"));
	ds.setParameter("regId",userId);
	ds.load();
}
//出院登记
function leave(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	var leaveTime;
		leaveTime=selected[0].get("LEAVE_DATE");
		if(""!=leaveTime){
			L5.Msg.alert('提示',"该人员已出院！");
		}else{
			var data = new L5.Map();
			data.put("method","UPDATE");
			data.put("balanceId",selected[0].get('BALANCE_ID'));
			data.put("peopleId",selected[0].get('PEOPLE_ID'));
			data.put("familyId",selected[0].get('FAMILY_ID'));
			data.put("assitanceType",selected[0].get('ASSITANCE_TYPE'));
			if(selected[0].get("BPT_TYPE")&&selected[0].get("ASSITANCE_TYPE")){
				var url='jsp/ext/mbalance/manage/samMBalanceLeaveBptSam.jsp';
				var text = '一站结算出院登记';
				L5.forward(url,text,data);
			}else if(selected[0].get("BPT_TYPE")){
				var url='jsp/ext/mbalance/manage/samMBalanceLeaveBpt.jsp';
				var text = '一站结算出院登记';
				L5.forward(url,text,data);
			}else if(selected[0].get("ASSITANCE_TYPE")){
				data.put("needConnect", needConnect);
				var url='jsp/ext/mbalance/manage/samMBalanceLeave.jsp';
				var text = '一站结算出院登记';
				L5.forward(url,text,data);
			}
		}
}
//删除住院登记信息
function del(){
	var hosDataset=L5.DatasetMgr.lookup("hosDataset");
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	if(selected[0].get("STRIKE_STATUS")=="01"||selected[0].get("STRIKE_STATUS")=="02"){
		L5.Msg.alert('提示',"不能冲账记录进行操作!");
		return false;
	}
	var leaveTime=[];
	for(var j=0;j<selected.length;j++){
		leaveTime[j]=selected[j].get("BALANCE_TIME");
		if(""!=leaveTime[j]){
			L5.Msg.alert('提示',"不能删除已出院的人员信息！");
		}else{
			L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
				if(state=="yes"){
					var  delIds=[];
					for(var i=0;i<selected.length;i++){
						delIds[i]=selected[i].get("BALANCE_ID");
					}
					var command=new L5.Command("com.inspur.cams.drel.mbalance.cmd.SamMBalanceCmd");
					command.setParameter("delIds", delIds);
					command.execute("delete");
					if (!command.error) {
						for(var i=0;i<selected.length;i++){
						   	hosDataset.remove(selected[i]);
						}
						hosDataset.commitChanges();
						L5.Msg.alert('提示',"删除成功！");
						ds.setParameter("hosStatus",document.getElementById("hosStatus").value);
						ds.setParameter("hospitalId",organId);
						L5.DatasetMgr.lookup("ds").load();
					}else{
						L5.Msg.alert('提示',"保存时出现错误！"+command.error);
					}
				}else{
					return false;
				}
			});
		}
	}
	
}
//修改信息
function pay(){
	var hosDataset=L5.DatasetMgr.lookup("hosDataset");
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	if(selected[0].get("STRIKE_STATUS")=="01"||selected[0].get("STRIKE_STATUS")=="02"){
		L5.Msg.alert('提示',"不能冲账记录进行操作!");
		return false;
	}
	var leaveTime=[];
	for(var j=0;j<selected.length;j++){
		leaveTime[j]=selected[j].get("BALANCE_TIME");
		if(""!=leaveTime[j]){
			L5.Msg.alert('提示',"不能修改已出院的人员信息！");
		}else{
			hosDataset.setParameter("balance_Id",selected[j].get("BALANCE_ID"));	
			hosDataset.load();
			if(win==undefined){
				var win=L5.getCmp("pay");
			}
			win=L5.getCmp("pay");
			win.show();
			document.getElementById("hosName").innerHTML=selected[0].get("NAME");
			document.getElementById("hosIdCard").innerHTML=selected[0].get("ID_CARD");
		}
	}
	
}
//修改住院信息保存
function save(){
	var hosDataset=L5.DatasetMgr.lookup("hosDataset");
	var valid = hosDataset.isValidate();
	var valid = hosDataset.isValidate();
	if(valid != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+valid);
		return false;
	}	
	var records = hosDataset.getCurrent();
	var command=new L5.Command("com.inspur.cams.drel.mbalance.cmd.SamMBalanceCmd"); 
	records.set("modTime",getCurDate());
	records.set("modID",userId);
	records.set("modPeople",userName);
	command.setParameter("records",records);
	command.execute("update");
	if (!command.error) {
		L5.Msg.alert('提示',"修改成功!");
		ds.setParameter("hosStatus",document.getElementById("hosStatus").value);
		ds.setParameter("hospitalId",organId);
		L5.DatasetMgr.lookup("ds").load();
		back();
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
//关闭信息修改窗口
function back(){
	if(win==undefined){
		var win=L5.getCmp("pay");
	}
	win=L5.getCmp("pay");
	win.hide();
}
//入院登记
function add(){
	if(win==undefined){
		var win=L5.getCmp("pay");
	}
	win=L5.getCmp("pay");
	win.show();
}
//报表查询
function report(){
	var url='jsp/ext/mbalance/manage/samMBalanceReport.jsp';
	var text = '一站式结算报表查询';
	L5.forward(url,text);
}
//打印结算单
function printBillClick(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录!");
		return false;
	}
	if(selected[0].get("STRIKE_STATUS")=="01"||selected[0].get("STRIKE_STATUS")=="02"){
		L5.Msg.alert('提示',"不能冲账记录进行操作!");
		return false;
	}
	if(!selected[0].get("BALANCE_TIME")){
		L5.Msg.alert('提示',"该人员未结算，请先结算！");
		return;
	}else{
		printBill(selected[0].get("BALANCE_ID"),cityDataset.get("name"));
	}
}
//冲账
function strikePay(){
	var hosDataset=L5.DatasetMgr.lookup("hosDataset");
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	if(selected[0].get("STRIKE_STATUS")=="01"||selected[0].get("STRIKE_STATUS")=="02"){
		L5.Msg.alert('提示',"不能冲账记录进行操作!");
		return false;
	}
	var leaveTime;
	leaveTime=selected[0].get("BALANCE_TIME");
	if(leaveTime){
		var data = new L5.Map();
		data.put("method","UPDATE");
		data.put("balanceId",selected[0].get('BALANCE_ID'));
		data.put("peopleId",selected[0].get('PEOPLE_ID'));
		data.put("familyId",selected[0].get('FAMILY_ID'));
		data.put("strike","strike");
		if(selected[0].get("BPT_TYPE")&&selected[0].get("ASSITANCE_TYPE")){
			var url='jsp/ext/mbalance/manage/samMBalanceLeaveBptSam.jsp';
			var text = '一站结算出院登记';
			L5.forward(url,text,data);
		}else if(selected[0].get("BPT_TYPE")){
			var url='jsp/ext/mbalance/manage/samMBalanceLeaveBpt.jsp';
			var text = '一站结算出院登记';
			L5.forward(url,text,data);
		}else if(selected[0].get("ASSITANCE_TYPE")){
			var url='jsp/ext/mbalance/manage/samMBalanceLeave.jsp';
			var text = '一站结算出院登记';
			L5.forward(url,text,data);
		}
	}else{
		L5.Msg.alert('提示',"该对象未结算，不能进行冲账！");
	}
}