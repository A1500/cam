function init() {
	var ds = L5.DatasetMgr.lookup("ds");
	ds.baseParams["RECEIVE_ORGAN_CODE@="]=areaCode;
	ds.load();
	L5.QuickTips.init();
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	
	ds.setParameter("DIS_FUNDS_SOURCE.DIS_YEAR@=",getParam("disYear"));	
	ds.setParameter("DIS_FUNDS_SOURCE.ALLOCATION_STATUS@=",getParam("allocationStatus"));		
	ds.load();
}

function insert() {
	var data = new L5.Map();
	data.put("method","INSERT");
	var url='jsp/cams/dis/funds/manage/fundsmanage_edit.jsp';
	var text = '增加DIS_FUNDS_SOURCE';
	L5.forward(url,text,data);

}

function update(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	var data = new L5.Map();
	data.put("method","UPDATE");
	data.put("dataBean",selected[0].get('id'));
	var url='jsp/cams/dis/funds/manage/fundsmanage_edit.jsp';
	var text = '修改DIS_FUNDS_SOURCE';
	L5.forward(url,text,data);
}

function del(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	var command=new L5.Command("com.inspur.cams.dis.base.cmd.DisFundsAllocationDetailCommand");
	command.setParameter("id", selected[0].get("id"));
	command.execute("queryIfAllocationd");
	var count = command.getReturn("count");
	if(count>0){
		L5.Msg.alert('提示',"已经发放，不能进行删除操作!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var  delIds=[];
			for(var i=0;i<selected.length;i++){
				delIds[i]=selected[i].get("id");
			}
			var command=new L5.Command("com.inspur.cams.dis.base.cmd.DisFundsSourceCommand");
			command.setParameter("delIds", delIds);
			command.execute("delete");
			if (!command.error) {
				for(var i=0;i<selected.length;i++){
			    	ds.remove(selected[i]);
				}
				ds.commitChanges();
			}else{
				L5.Msg.alert('提示',"保存时出现错误！"+command.error);
			}
		}else{
			return false;
		}
	});
}

function fillPurposeName(value,cellmeta,record,rowindex,colindex,dataset){
	var nameArr = value.split(",");
	var name = "";
	for(var i = 0;i<nameArr.length;i++){
		var records = allocationPurposeSelect.query("value",nameArr[i]);
		if(i == nameArr.length-1){
			name+= records.items[0].get("text");
		}else{
			name+= records.items[0].get("text")+",";
		}
	}
	return name;
}

function allocation(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	if(selected[0].get('receiveStatus') != "1"){
		L5.Msg.alert('提示',"该资金未接收，不能进行发放!");
		return false;
	}
	if(selected[0].get('allocationStatus') == "1"){
		L5.Msg.alert('提示',"已经发放完成，不能进行发放!");
		//return false;
	}
	var data = new L5.Map();
	data.put("dataBean",selected[0].get('id'));
	var url='jsp/cams/dis/funds/allocation/allocation.jsp';
	var text = '修改DIS_FUNDS_SOURCE';
	L5.forward(url,text,data);
}
function receive(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	if(selected[0].get('receiveStatus') == "1"){
		L5.Msg.alert('提示',"该资金已经接收!");
		return false;
	}
	var command=new L5.Command("com.inspur.cams.dis.base.cmd.DisFundsSourceCommand");
	command.setParameter("record",selected[0]);
	command.execute("receive");
	if (!command.error) {
		L5.Msg.alert('提示',"接收成功!");
		//back();
	}else{
		L5.Msg.alert('提示',"接收时出现错误！"+command.error);
	}
	ds.reload();
}

function allocationOver(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	if(selected[0].get('receiveStatus') != "1"){
		L5.Msg.alert('提示',"该资金未接收，不能修改发放状态为已完成!");
		return false;
	}
	var command=new L5.Command("com.inspur.cams.dis.base.cmd.DisFundsSourceCommand");
	command.setParameter("record",selected[0]);
	command.execute("allocationOver");
	if (!command.error) {
		L5.Msg.alert('提示',"修改为发放完成状态成功!");
		//back();
	}else{
		L5.Msg.alert('提示',"接收时出现错误！"+command.error);
	}
	ds.reload();
}
