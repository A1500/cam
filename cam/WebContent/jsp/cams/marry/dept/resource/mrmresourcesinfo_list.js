function init() {
	var infocommand = new L5.Command("com.inspur.cams.comm.informUtil.InformSessionCmd");
		infocommand.execute("getUserInfo");
		var userLoginName ="";
		if (!infocommand.error) {
			var info = infocommand.getReturn("userInfo");
			  userLoginName =info.userLoginName;//通过登录账号查找对应的婚姻登记处。
			}
			
	var mrmBasePersonCommand = new L5.Command("com.inspur.cams.marry.base.cmd.MrmBasePersonCommand");
		mrmBasePersonCommand.setParameter("loginId",userLoginName);
		mrmBasePersonCommand.execute("getDeptId");
		if (!mrmBasePersonCommand.error) {
			 deptId = mrmBasePersonCommand.getReturn("deptId");
			 deptName= mrmBasePersonCommand.getReturn("deptName");
			}
			if(deptId=="" || deptId==null){
				ds.newRecord();
				alert("没有对应的婚姻登记处！");
				return false;
			
			}
    ds.setParameter("DEPT_ID@=",deptId);
	ds.on("load",function(){
    		var records=ds.getAllRecords();
    		var resRecords=L5.DatasetMgr.lookup("resourceNameDs").getAllRecords();
			for(var i=0;i<resRecords.length;i++){
				var value= resRecords[i].get("value");
				for(var j=0;j<records.length;j++){
	    			if(records[j].get("resourceName")==value){
	    				flg=false;
	    			}
	    		}
	    		if(flg){
					var record=L5.DatasetMgr.lookup("ds").newRecord();
					record.set("deptId",deptId);
					record.set("deptName",deptName);
					record.set("resourceName",value); 
	    		}
			}
    	})
   
	L5.DatasetMgr.lookup("ds").load();
	L5.QuickTips.init();
};

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	ds.setParameter("RESOURCE_NAME@=",getParam("resourceName"));	
	ds.setParameter("DEPT_ID@=",deptId);	
	ds.load();
}

function insert() {
	var Grid = L5.getCmp('editGridPanel');
	Grid.stopEditing();
	var sourRecord=ds.newRecord();	
		sourRecord.set("deptId",deptId);
		sourRecord.set("deptName",deptName);
}

function del() {
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var  delIds=[];
			for(var i=0;i<selected.length;i++){
				delIds[i]=selected[i].get("resourceId");
			}
			var command=new L5.Command("com.inspur.cams.marry.base.cmd.MrmResourcesInfoCommand");
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
function save() {
	var records = ds.getAllChangedRecords();
	if(records.length<1){
		L5.Msg.alert('提示','没有需要保存的数据!');
		return false;
	}
	var isValidate = ds.isValidate();
	if(isValidate != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+isValidate);
		return false;
	}
	
	var command = new L5.Command("com.inspur.cams.marry.base.cmd.MrmResourcesInfoCommand");
	command.setParameter("records", records);
	command.execute("save");
	if (!command.error) {
		ds.commitChanges();
		L5.Msg.alert('提示',"数据保存成功!");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

function reset() {
	ds.rejectChanges();
}


function insertXX() {
	var data = new L5.Map();
	data.put("method","INSERT");
	var url='jsp/cams/marry/dept/resource/mrmresourcesinfo_edit.jsp';
	var text = '增加资源信息表';
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
	data.put("dataBean",selected[0].get('resourceId'));
	var url='jsp/cams/marry/dept/resource/mrmresourcesinfo_edit.jsp';
	var text = '修改资源信息表';
	L5.forward(url,text,data);
}


