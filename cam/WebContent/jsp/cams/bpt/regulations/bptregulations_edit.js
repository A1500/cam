var row_index1=0;
function init() {	
	if (method == null || method == "") {
		L5.Msg.alert('提示', "未知的页面命令!");
	} else if (method == "INSERT") {
		var ds = L5.DatasetMgr.lookup("ds");
		ds.newRecord();
		ds.set("regulationsId",newid);
		ds.set("releasePeople",username);
		ds.set("releaseCompany",orgname);
	} else if (method == "UPDATE") {
		var ds = L5.DatasetMgr.lookup("ds");
		ds.setParameter("REGULATIONS_ID", id);
		ds.on("load",loadKE);
		ds.load();
		//document.getElementById("fileLevel").disabled=true;
		var UploadFileDataset = L5.DatasetMgr.lookup("UploadFileDataset");
		UploadFileDataset.setParameter("id", id);
		UploadFileDataset.load();
		UploadFileDataset.on("load",function(){
			var records = UploadFileDataset.getAllRecords();
			var x = records.length;
			if(x>0){
				for(var i=0;i<x;i++){
					var table1 = document.getElementById("table1");
					row_index1++;
					var new_row = table1.insertRow(table1.rows.length);
					new_row.setAttribute("id","row1"+row_index1);
					var new_col=new_row.insertCell(0);
					var id = records[i].get("attachmentId");
					var fileName = records[i].get("fileName");
					new_col.innerHTML="<a style='width:50%' href="+L5.webPath+"/download?table=BPT_REGULATIONS_ATTACHMENT&column=ATTACHMENT&filename=FILE_NAME&pk=ATTACHMENT_ID&ATTACHMENT_ID='"+id+"'><font size=2>"+fileName+'</font></a>'+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type='button' value='删除' onclick=\"delete_loadfilerow('row1"+row_index1+"','"+id+ "')\">";;
				}
			}
		});
	} else {
		L5.Msg.alert('提示', "未知的页面命令!");
	}
	L5.QuickTips.init(); 
	KE.create("content");
}

//删除附件
function delete_loadfilerow(rowIndex,id){
	var table1 = document.getElementById("table1");
    var i;
    i=table1.rows(rowIndex).rowIndex;
    table1.deleteRow(i);

	var command = new L5.Command("com.inspur.cams.bpt.regulations.cmd.BptRegulationsAttachmentCmd");
	command.setParameter("id", id);
	command.execute("delete");
	if (!command.error) {
		L5.Msg.alert("提示", "删除成功");
	} else {
		L5.Msg.alert("错误", command.error);
	}
}

function loadKE() {
	var content =ds.get("content");
	KE.insertHtml("content",content); 
}

function save(){
	var ds = L5.DatasetMgr.lookup("ds");
	var isValidate = ds.isValidate(true);
	if (isValidate !== true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return false;
	}
	var record = ds.getCurrent();
	if(!validateDateFormat(record.get("releaseDate"))){
		L5.Msg.alert("提示", "发布时间格式不正确,不能保存!");
		return false;
	}
	record.set("content",KE.util.getData("content"));
	var flag = record.get("flag");
	if(flag==''){
		L5.Msg.alert("提示", "文件状态不能为空！");
		return false;
	}
	if(flag=="2"){
		var  date = new Date();
		record.set("abolishedTime",date);
	}
	var command = new L5.Command("com.inspur.cams.bpt.regulations.cmd.BptRegulationsAjaxCommand");
	command.setParameter("record", record);
	command.setForm(L5.getDom("editForm"));
	if (method == "INSERT") {
		
		command.execute("addRegulation");
	} else if (method == "UPDATE") {
		command.execute("updateRegulations");
	}
	
	if (!command.error) {
		L5.Msg.alert("提示", "保存成功",function(){
			L5.forward("jsp/cams/bpt/regulations/bptregulations_list.jsp");
		});
	} else {
		L5.Msg.alert("错误", command.error);
	}
}

 function back()
 {	 	var url='jsp/cams/bpt/regulations/bptregulations_list.jsp';
		var text = '政策法规列表';
		L5.forward(url,text);	 
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
  	alert(rname);
	var table2 = document.getElementById("table2");
    var i;
    i=table2.rows(rname).rowIndex;
    table2.deleteRow(i);
  }