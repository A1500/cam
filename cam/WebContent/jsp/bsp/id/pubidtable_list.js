
function init() {
	L5.DatasetMgr.lookup("ds").load();
	L5.QuickTips.init();
};
//校验当前值是否为整数值
function checkIdValue(args){
	var val1 = args[0];
	if(isNaN(val1)){
		return "必须为整数值";
	}else{
		return true;
	}
}

//校验流水号长度
function checkIdLength(args){
	var val1 = args[0];
	if(isNaN(val1)){
		return "必须为整数值";
	}else{
		return true;
	}
}
function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){

	ds.setParameter("PUB_IDTABLE.ID_ID@LIKE",getParam("idId"));
	ds.setParameter("PUB_IDTABLE.ID_NAME@LIKE",getParam("idName"));
	ds.load();
}

function insert() {
	var data = new L5.Map();
	data.put("method","INSERT");
	var url='jsp/bsp/id/pubidtable_edit.jsp';
	//var text ='增加业务流水号';
	L5.forward(url,addtext,data);

}

function update(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		//L5.Msg.alert('提示',"请选择一条记录修改!");
		L5.Msg.alert(alerttitle,selectone);
		return false;
	}
	var data = new L5.Map();
	data.put("method","UPDATE");
	var idId=selected[0].get('idId');
	var organId=selected[0].get('organId');
	idId=encodeURIComponent(encodeURIComponent(selected[0].get('idId')));
	data.put("dataBean",idId);
	data.put("organId",organId);
	var url='jsp/bsp/id/pubidtable_edit.jsp';
	//var text = '修改业务流水号';
	L5.forward(url,updatetext,data);
}

function del(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		//L5.Msg.alert('提示',"请选择要删除的记录!");
		L5.Msg.alert(alerttitle,selectdel);
		return false;
	}
	//L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
	L5.MessageBox.confirm(sure, confirm,function(state){
		if(state=="yes"){
			var  delIds=[];
			var j=0;
			for(var i=0;i<selected.length;i++){
				var idId=selected[i].get("idId");
				var organId=selected[i].get("organId");
				delIds[j]=idId;
				delIds[j+1]=organId;
				j=j+2;
			}
			var command=new L5.Command("org.loushang.bsp.id.cmd.PubIdtableCommand");
			command.setParameter("delIds", delIds);
			command.execute("delete");
			if (!command.error) {
				for(var i=0;i<selected.length;i++){
			    	ds.remove(selected[i]);
				}
				ds.commitChanges();
				L5.DatasetMgr.lookup("ds").load();
			}else{
				//L5.Msg.alert('提示',command.error);
				L5.Msg.alert(alerttitle,command.error);
			}
		}else{
			return false;
		}
	});
}
/*
 * 重置查询
 */
function reset(){
	document.getElementById("idId").value="";
	document.getElementById("idName").value="";
}
 
function exportSelected(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要导出的记录!");
		return false;
	}
	var revalue=window.showModalDialog("selectexport.jsp","","dialogHeight:550px;dialogWidth:500px;resizable:no;scroll:yes;dialogLeft:"+(window.screen.width-300)/2+";dialogTop:"+(window.screen.height-400)/2);
	if(revalue!=undefined&&revalue!=""){
		if(revalue.indexOf(":")==0){
			L5.Msg.alert("提示","请选择正确的文件目录");
			return;
		}
		var cmd=new L5.Command("org.loushang.bsp.id.cmd.PubIdtableCommand");
		cmd.setParameter("records",selected);
		cmd.execute("exportId");
		var jsonStr=cmd.getReturn("jsonStr");
		var ForWriting = 2;
		var path=revalue;
		var fso = new ActiveXObject("Scripting.FileSystemObject");	
		var idtablef = fso.OpenTextFile(path+"idtable.json", ForWriting, true);
		idtablef.Write(jsonStr);
		idtablef.Close(); 
		if(!cmd.error){
			L5.Msg.alert("提示","导出成功");
		}else{
			L5.Msg.alert("提示",cmd.error);
		}
  }
}

function exportAll(){
	var revalue=window.showModalDialog("selectexport.jsp","","dialogHeight:550px;dialogWidth:500px;resizable:no;scroll:yes;dialogLeft:"+(window.screen.width-300)/2+";dialogTop:"+(window.screen.height-400)/2);
	if(revalue!=undefined&&revalue!=""){
		if(revalue.indexOf(":")==0){
			L5.Msg.alert("提示","请选择正确的文件目录");
			return;
		}
		var cmd=new L5.Command("org.loushang.bsp.id.cmd.PubIdtableCommand");
		cmd.execute("exportAll");
		var jsonStr=cmd.getReturn("jsonStr");
		var ForWriting = 2;
		var path=revalue;
		var fso = new ActiveXObject("Scripting.FileSystemObject");	
		var idtablef = fso.OpenTextFile(path+"idtable.json", ForWriting, true);
		idtablef.Write(jsonStr);
		idtablef.Close(); 
		if(!cmd.error){
			L5.Msg.alert("提示","导出成功");
		}else{
			L5.Msg.alert("提示",cmd.error);
		}
   }
}

//业务流水号导入
function importId(){
	var revalue=window.showModalDialog("selectexport.jsp","","dialogHeight:550px;dialogWidth:500px;resizable:no;scroll:yes;dialogLeft:"+(window.screen.width-300)/2+";dialogTop:"+(window.screen.height-400)/2);
	if(revalue!=undefined&&revalue!=""){
		if(revalue.indexOf(":")==0){
			L5.Msg.alert("提示","请选择正确的文件目录");
			return;
		}
		var path=revalue;
		var ForReading = 1;
		var jsonStr;
		try{
			var fso = new ActiveXObject("Scripting.FileSystemObject");
			var idtablefile = fso.OpenTextFile(path+"idtable.json", ForReading);
			jsonStr=idtablefile.ReadAll();
		}catch(e){
			L5.Msg.alert("提示",e.message);
			return;
		}
		var cmd=new L5.Command("org.loushang.bsp.id.cmd.PubIdtableCommand");
		cmd.setParameter("jsonStr",jsonStr);
		cmd.execute("importId");
		if(!cmd.error){
			L5.Msg.alert("提示","导入成功");
			L5.DatasetMgr.lookup("ds").load();
		}else{
			L5.Msg.alert("提示",cmd.error);
		}
	}
}
