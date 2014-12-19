
function init() {
	var ds=L5.DatasetMgr.lookup("ds");
	var uploadDs=L5.DatasetMgr.lookup("uploadDs");
	uploadDs.load();
	var grid=L5.getCmp('editGridPanel');
	//给grid增加双击侦听事件。
	grid.on("rowdblclick",detail);
	L5.QuickTips.init();
};


function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
function query(){
	var uploadDs=L5.DatasetMgr.lookup("uploadDs");
	uploadDs.setParameter("PRS_CATALOGUE.CATALOG_CODE@=",getParam("catalogCode"));
	uploadDs.setParameter("PRS_CATALOGUE.INSERT_FLAG@=",getParam("insertFlag"));
	uploadDs.setParameter("PRS_CATALOGUE.UPLOAD_TIME@=",getParam("uploadTime"));
	uploadDs.setParameter("PRS_CATALOGUE.MILITARY_REGION@=",getParam("militaryRegion"));
	uploadDs.load();
}

function insert(){
	var ds = L5.DatasetMgr.lookup("ds");

	ds.removeAll();
	ds.newRecord();
	var win=L5.getCmp("uploadinsert");
	win.show(this);
	document.getElementById("Rtime").innerText = new Date();
	document.getElementById("form_content").reset();
}
function update(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}
	var ds = L5.DatasetMgr.lookup("ds");
	ds.setParameter("CATALOG_ID@=",selected[0].get("catalogId"));
	ds.load();

	var win=L5.getCmp("uploadupdate");
	win.show(this);
}

function detail(){

	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录查看!");
		return false;
	}
	var ds = L5.DatasetMgr.lookup("ds");
	ds.setParameter("CATALOG_ID@=",selected[0].get("catalogId"));
	ds.load();

	var win=L5.getCmp("uploaddetail");
	win.show(this);
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
				delIds[i]=selected[i].get("catalogId");
			}
			var command=new L5.Command("com.inspur.cams.prs.prsretiredsoldiers.cmd.SoldiersuploadCommand");
			command.setParameter("delIds", delIds);
			command.execute("delete");
			if (!command.error) {
				for(var i=0;i<selected.length;i++){
			    	ds.remove(selected[i]);

				}
				L5.Msg.alert('提示',"数据删除成功!");
				ds.commitChanges();
				var uploadDs=L5.DatasetMgr.lookup("uploadDs");
				uploadDs.reload();
			}else{
				L5.Msg.alert('提示',"保存时出现错误！"+command.error);
			}
		}else{
			return false;
		}
	});

}
function save() {
	var isValidate = ds.isValidate();
	if(isValidate != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+isValidate);
		return false;
	}
	if(ds.get("catalogCode")==""){
		L5.Msg.alert('提示',"目录名称不能为空!");
		return false;
	}
	if(ds.get("militaryRegion")==""){
		L5.Msg.alert('提示',"军区大单位不能为空!");
		return false;
	}
	var command = new L5.Command("com.inspur.cams.prs.prsretiredsoldiers.cmd.SoldiersuploadCommand");
	command.setParameter("record",ds.getCurrent());

	command.setForm("form_content");
	command.execute("insert");

	if (!command.error) {
		L5.Msg.alert('提示',"数据保存成功!",function(){
	var uploadDs=L5.DatasetMgr.lookup("uploadDs");
	uploadDs.load();
	var win=L5.getCmp("uploadinsert");
		win.hide();});

	}

	else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}

}

function reset() {
	ds.rejectChanges();
}


function upload() {
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条要导入的记录!");
		return false;
	}
	var insertFlag = selected[0].get("insertFlag");
	if(insertFlag!=0){
		L5.Msg.alert('提示',"请选择一条要未导入的记录!");
		return false;
	}
	var filename = selected[0].get("filePath");
	var command=new L5.Command("com.inspur.cams.prs.prsretiredsoldiers.cmd.PrsRetiredSoldiersCommand");
	command.setParameter("filename",filename);
	command.execute("upload");
	var count = command.getReturn("count");
	if (!command.error) {
		L5.Msg.alert('提示',"成功导入"+count+"条数据!");
		var cmd = new L5.Command("com.inspur.cams.prs.prsretiredsoldiers.cmd.SoldiersuploadCommand");
		cmd.setParameter("id", selected[0].get("catalogId"));
		cmd.setParameter("count",count);
		cmd.execute("updateFlag");
		var uploadDs=L5.DatasetMgr.lookup("uploadDs");
		uploadDs.reload();
 	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

	function operation(value) {
		var func = 'javascript:uploadById("' + value + '")';
		var str = "<a href='"+func+"'>" + '上传' + "</a>";
		return str;
	}

	function uploadById() {
	     document.getElementById("updatefileId").value = id;
		 var s = L5.getCmp('addNewDemobilizedGrantObject');
		 s.show();
	}

 var row_index=0;
   function  add_row()
  {
    var table2 = document.getElementById("table2");
	row_index++;
    var new_row=table2.insertRow(table2.rows.length);
	new_row.setAttribute("id", "row"+row_index);
	var new_col=new_row.insertCell(0);
	new_col.innerHTML="<input type='file' name='filename"+row_index+"' size='87' >";
    var new_col=new_row.insertCell(1);
    new_col.innerHTML="&nbsp;<input type='button' value='删除' onclick=\"delete_row('row"+row_index+ "')\">";
    document.getElementById("filename"+row_index).focus();
    document.getElementById("span").innerHTML="<font color='red'>附件大小不能超过5M</font>";
  }
    function delete_row(rname)
  {
	var table2 = document.getElementById("table2");
    var i;
    i=table2.rows(rname).rowIndex;
    table2.deleteRow(i);
  }

