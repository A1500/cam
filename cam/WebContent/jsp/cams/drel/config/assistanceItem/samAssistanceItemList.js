var ifItemName=false;
function init(){
	samAssistanceItemList.setParameter("AREA_CODE@in",filterAreaCode);
	samAssistanceItemList.load();
}
function query(){
	samAssistanceItemList.setParameter("AREA_CODE@in",filterAreaCode);
	samAssistanceItemList.setParameter("status",document.getElementById('queryinUse').value);
	samAssistanceItemList.setParameter("item_name@like",document.getElementById('queryName').value);
	
	samAssistanceItemList.load();
}
//新增
function insert(){		
	ifItemName=false;
	var winSamAssistanceItemDataset = L5.DatasetMgr.lookup("winSamAssistanceItemDataset");
	winSamAssistanceItemDataset.removeAll();
	winSamAssistanceItemDataset.newRecord({'itemType':itemType,'status':'1','parent':'0','areaCode':areaCode,'areaName':areaName});
	var win = L5.getCmp("assistanceItemWin");
	win.show();
}
//修改
function update(){		
	var grid = L5.getCmp("assistanceItemGrid");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请选择一条记录!");
		return;
	}
	if(record.get('areaCode')!=areaCode){
		L5.Msg.alert("提示","录入单位不是当前登录单位，不能进行修改!");
		return;		
	}
	ifItemName=false;
	var itemCode=record.get('itemCode');
	var winSamAssistanceItemDataset = L5.DatasetMgr.lookup("winSamAssistanceItemDataset");
	winSamAssistanceItemDataset.setParameter('ITEM_CODE',itemCode);
	winSamAssistanceItemDataset.load();
	var win = L5.getCmp("assistanceItemWin");
	win.show();
}
//确定
function confirmWin(){
	if(ifItemName){
		L5.Msg.alert("提示","该"+labelName+"已存在，请更换"+labelName+"！");
		return;
	}
	var winSamAssistanceItemDataset = L5.DatasetMgr.lookup("winSamAssistanceItemDataset");	
	var valid = winSamAssistanceItemDataset.isValidate();
	if(valid != true){
		L5.Msg.alert("提示",valid);
		return false;
	}
	var command = new L5.Command("com.inspur.cams.drel.config.assistance.cmd.SamAssistanceItemCmd");
	command.setParameter("assistanceItemRecord", winSamAssistanceItemDataset.getCurrent());
	command.execute("save");	
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
			var win = L5.getCmp("assistanceItemWin");
			win.setVisible(false);
			samAssistanceItemList.setParameter("AREA_CODE@in",filterAreaCode);
			samAssistanceItemList.load();
		});
	}else{
		L5.Msg.alert("错误",command.error);
	}
}
//窗口关闭
function closeWin(){
	var win = L5.getCmp("assistanceItemWin");
	win.setVisible(false);
}
//检查
function checkItemName(){
	var itemName=_$('itemName');
	var itemCode=_$('itemCode');
	if(itemName!=''){
		var samAssistanceItemQueryDataset = L5.DatasetMgr.lookup("samAssistanceItemQueryDataset");
		samAssistanceItemQueryDataset.setParameter("ITEM_NAME", itemName);
		samAssistanceItemQueryDataset.setParameter("ITEM_CODE@!=", itemCode);
		samAssistanceItemQueryDataset.setParameter("AREA_CODE@in",filterAreaCode);//2012年11月6日
		samAssistanceItemQueryDataset.on('load',loadSamAssistanceItemQueryDataset);
		samAssistanceItemQueryDataset.load();
	}
}
function loadSamAssistanceItemQueryDataset(ds){
	ds.un('load',loadSamAssistanceItemQueryDataset);
	if(ds.getCount()>0){
		ifItemName=true;	
		L5.Msg.alert("提示","该"+labelName+"已存在，请更换"+labelName+"！");
		return;
	}		
	ifItemName=false;
}
//使用状态
function getStatus(value,cellmeta,record,rowindex,colindex,dataset){
	var status=record.get('status');
	if(status=="1"){
		return '<label style="color:green">'+'启用'+'</label>';
	}else if(status=="0"){
		return '<label style="color:red">'+'停用'+'</label>';
	}else{
		return "";
	} 
}
