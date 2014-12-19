//页面初始化
function init(){
	var dicManageDS = L5.DatasetMgr.lookup("dicManageDS");
	dicManageDS.load();
}

//查询方法
function query(){
	var dicManageDS = L5.DatasetMgr.lookup("dicManageDS");
	dicManageDS.baseParams["DIC_TYPE@like@String"]=document.getElementById("qDicType").value;
	dicManageDS.baseParams["DIC_NAME@like@String"]=document.getElementById("qDicName").value;
	dicManageDS.load();
}
//增加字典维护信息窗口
var addWin;

//增加字典信息方法
function add_Button_Click(){
	var dicManageAddDS = L5.DatasetMgr.lookup("dicManageAddDS");
	dicManageAddDS.removeAll();
	dicManageAddDS.newRecord();
	if(!addWin){
		addWin=L5.getCmp("addWin");
	}
	addWin.show();
	document.getElementById("dicType").disabled=false;
}
//字典信息添加窗口保存按钮方法
function save_Button_Click(){
	var	dicManageAddDS = L5.DatasetMgr.lookup("dicManageAddDS");
	var isValidate=dicManageAddDS.isValidate(true);
	if(isValidate!=true){
		L5.Msg.alert("错误","无法通过校验！"+isValidate);
		return;
	}
	
	var record=dicManageAddDS.getCurrent();
	//保存前校验
	var dicManageCheckDS=L5.DatasetMgr.lookup("dicManageCheckDS");
	dicManageCheckDS.setParameter("DIC_TYPE",record.get("dicType"));
	dicManageCheckDS.purgeListeners();
	dicManageCheckDS.on('load',function(){
		if(dicManageCheckDS.getCount()==0){
			var addDicManageCmd= new L5.Command("com.inspur.cams.comm.dicm.cmd.DicManageCmd");
			addDicManageCmd.setParameter("record",record);
			addDicManageCmd.execute("insert");
			if(!addDicManageCmd.error){	
				L5.Msg.alert("提示","保存成功！");
				var dicManageDS = L5.DatasetMgr.lookup("dicManageDS");
				dicManageDS.load();
				closeAddWin();
			}else{
				L5.Msg.alert("错误",addDicManageCmd.error);
			}
		}else{
			L5.Msg.alert("提示","已有相应记录!");
		}
	});
	dicManageCheckDS.load();
}

//字典信息添加窗口返回按钮方法
function return_Button_Click(){
	if(!addWin){
		addWin=L5.getCmp("addWin");
	}
	addWin.hide();
}
// 关闭添加字典信息窗口
function closeAddWin(){
	if(!addWin){
		addWin=L5.getCmp("addWin");
	}
	addWin.hide();
}
// 关闭添加字典详细信息窗口
function closeDicDetailWin(){
	if(!dicDetailWin){
		dicDetailWin=L5.getCmp("dicDetailWin");
	}
	dicDetailWin.hide();
}

//保存
function save_Modify_Click(){
	var dicManageDS = L5.DatasetMgr.lookup("dicManageDS");
	var records=dicManageDS.getAllChangedRecords();
	if(records.length==0){
		L5.Msg.alert("提示","没有要保存的记录！");
		return;
	}
	var addDicManageCmd= new L5.Command("com.inspur.cams.comm.dicm.cmd.DicManageCmd");
	addDicManageCmd.setParameter("records",records);
	addDicManageCmd.execute("save");
	if(!addDicManageCmd.error){	
		L5.Msg.alert("提示","保存成功！");
		var dicManageDS = L5.DatasetMgr.lookup("dicManageDS");
		dicManageDS.load();
	}else{
		L5.Msg.alert("错误",addDicManageCmd.error);
	}
	
}
/**
 *  事件处理：点击字典类型链接
 *
 */
function editDicDetails(value,cellmeta,record,rowindex,colindex,dataset){
	return '<a href="javascript:showDicDetailsWin(\''+record.data["dicType"]+'\')">' + value + '</a>';
}
//字典详细信息管理窗口
var dicDetailWin;
//字典类型，将当前选择记录的字典类型传递到字典详细信息管理窗口
var detailWinDicType;
//链接调用方法
function showDicDetailsWin(dicType){
	detailWinDicType=dicType;
	var dicDetailsDS = L5.DatasetMgr.lookup("dicDetailsDS");
	dicDetailsDS.setParameter("DIC_TYPE",dicType);
	dicDetailsDS.load();
	if(!dicDetailWin){
		dicDetailWin=L5.getCmp("dicDetailWin");
	}
	dicDetailWin.show();
	var dicDetailsGrid=L5.getCmp("dicDetailsGrid");
	dicDetailsGrid.on("cellclick",getColCode);
	dicDetailsGrid.on("afteredit",onColCheckCode);
}
//当前编辑列
var editColumn;
//当前编辑列的代码值
var code;
function getColCode(grid, rowIndex, columnIndex,e){
	code="";
	editColumn=columnIndex;
	var dicDetailsGrid=L5.getCmp("dicDetailsGrid");
	var cell = dicDetailsGrid.getSelections();
	if(cell[0].get("code")){
		code=cell[0].get("code");
	}
		
}

//修改校验是否主键冲突
function onColCheckCode(e){
	var dicDetailsGrid=L5.getCmp("dicDetailsGrid");
	var cell = dicDetailsGrid.getSelections();
	if(editColumn==3){
		var dicDetailsCheckDS = L5.DatasetMgr.lookup("dicDetailsCheckDS");
		dicDetailsCheckDS.setParameter("DIC_TYPE",cell[0].get("dicType"));
		dicDetailsCheckDS.setParameter("CODE",cell[0].get("code"));
		dicDetailsCheckDS.purgeListeners();
		dicDetailsCheckDS.on('load',function(){
			if(dicDetailsCheckDS.getCount()>0){
				cell[0].set("code",code);
				L5.Msg.alert("提示","已有相应记录!");
			}
		});
		dicDetailsCheckDS.load();
	}
}

//增加字典详细信息
function add_Details_Click(){
	var dicDetailsDS = L5.DatasetMgr.lookup("dicDetailsDS");
	var record=dicDetailsDS.newRecord();
	record.set("dicType",detailWinDicType);
	record.set("flag","1");
	record.set("orderNum","1");
}

//保存字典详细信息
function save_Details_Click(){
	var dicDetailsDS = L5.DatasetMgr.lookup("dicDetailsDS");
	var isValidate=dicDetailsDS.isValidate(true);
	if(isValidate!=true){
		L5.Msg.alert("错误","无法通过校验！"+isValidate);
		return;
	}
	var records=dicDetailsDS.getAllChangedRecords();
	if(records.length==0){
		L5.Msg.alert("提示","没有要保存的记录！");
		return;
	}
	var dicDetailsCmd= new L5.Command("com.inspur.cams.comm.dicm.cmd.DicDetailsCmd");
	dicDetailsCmd.setParameter("records",records);
	dicDetailsCmd.execute("save");
	if(!dicDetailsCmd.error){
		L5.Msg.alert("提示","保存成功！");
		dicDetailsDS.setParameter("DIC_TYPE",detailWinDicType);
		dicDetailsDS.load();
	}else{
		L5.Msg.alert("错误",dicDetailsCmd.error);
	}
}
//小写转换为大写
function changeCapsLock(domId){
	document.getElementById(domId).value=document.getElementById(domId).value.toUpperCase();
}