function init() {
	//救助项目加载
	samAssistanceItemDataset.setParameter("filterSql", "ITEM_TYPE='02' AND STATUS='1'  and area_code in "+" ( "+filterAreaCode+" )");//专项救助
	samAssistanceItemDataset.on('load',loadDs);
	samAssistanceItemDataset.load();
};
function loadDs(){
	L5.DatasetMgr.lookup("ds").load();
}
function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	ds.setParameter("FREQUENCY@=",getParam("frequencyQuery"));
	ds.setParameter("ITEM_CODE@=",getParam("itemCodeQuery"));
	ds.setParameter("TARGET@=",getParam("targetQuery"));
	ds.setParameter("IN_USE@=",getParam("inUseQuery"));		
	ds.load();
}

function insert() {
	var winDs = L5.DatasetMgr.lookup("winDs");
	winDs.removeAll();
	winDs.newRecord({'target':'1','frequency':'1'});//家庭
	var win=L5.getCmp("addWin");
	win.show();
	$('itemCode').disabled=false;	
}

function update(){
	var grid = L5.getCmp("editGridPanel");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请选择一条记录!");
		return;
	}
	var itemId=record.get('itemId');
	var winDs = L5.DatasetMgr.lookup("winDs");
	winDs.setParameter('ITEM_ID',itemId);
	winDs.load();
	var win=L5.getCmp("addWin");
	win.show();
	$('itemCode').disabled=true;	
}

function closeWin(){
	var win=L5.getCmp("addWin");
	win.hide();
}

function save(){
	var record = winDs.getCurrent();
	var reg=/^\d+(\.\d{0,2})?$/; 
	var item = document.getElementById("assistanceMoney");
	if ((item.value).match(reg)== null){ 
	   L5.Msg.alert("提示","请输入正确的'"+item.name+"'！",function(){
		    item.focus();
		}); 
		item.value="";
		return ; 
	}
	var valid = winDs.isValidate();
	if(valid != true){
		L5.Msg.alert("提示",valid);
		return false;
	}	
	record.set('itemName',$('itemCode').options[$('itemCode').selectedIndex].text);
	var command=new L5.Command("com.inspur.cams.drel.sam.cmd.SamSpecialAssistanceItemCmd"); 
	command.setParameter("record",record);
	command.execute("save");
	if (!command.error) {
		L5.Msg.alert('提示',"保存成功!",function(){
			var win=L5.getCmp("addWin");
			win.hide();
			L5.DatasetMgr.lookup("ds").load();
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
//使用状态
function getInUse(value,cellmeta,record,rowindex,colindex,dataset){
	var inUse=record.get('inUse');
	if(inUse=="1"){
		return '<label style="color:green">'+'启用'+'</label>';
	}else if(inUse=="0"){
		return '<label style="color:red">'+'停用'+'</label>';
	}else{
		return "";
	} 
}	
function checkItemCode(){
	if(_$('itemCode')==''){
		return;
	}
	//新增时 校验项目名称
	var queryDs = L5.DatasetMgr.lookup("queryDs");
	queryDs.setParameter("ITEM_CODE@=",_$('itemCode'));	
	queryDs.on('load',function(ds){
		if(ds.getCount()>0){
			L5.Msg.alert("提示","项目名称已存在，请在原项目基础上修改!");
			winDs.setParameter('ITEM_ID',ds.get('itemId') );
			winDs.load();
			$('itemCode').disabled=true;	
			return false;
		}
	});
	queryDs.load();
}	

