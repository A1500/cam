 var row_index=0;
 /*
 * 实现HtmlEdit
 */
function init(){
	uploadds.newRecord();
}
 /*
  * 增加一行
  */
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
  /*
   * 删除一行
   */
  function delete_row(rname)
  {
	var table2 = document.getElementById("table2");
    var i;
    i=table2.rows(rname).rowIndex;
    table2.deleteRow(i);
  }

/*
 * 删除左右两端空格
 */
function trim(str){

	return str.replace(/(^\s*)|(\s*$)/g, '');
}


/*
 * 执行保存前的校验
 */
function click_check(){
    var editor=L5.getCmp('bio');
	var temp=undefined;

	if(getParam("title")==temp||trim(getParam("title"))==""){
		L5.Msg.alert("提示","通知标题不能为空!");
		return false;
	}else if(getParam("informtype")==temp||trim(getParam("informtype"))==""){
		L5.Msg.alert("提示","请选择通知类型!");
		return false;
	}else if(trim(L5.getCmp('bio').getValue())==""){
		L5.Msg.alert("提示","请填写通知正文!");
		return false;
	}else if((editor.getValue()).length>=4000){
		L5.Msg.alert("提示","正文不能超过4000字!");
	    return false;
	}else{
		return true ;
	}
}

//根据ID获取界面控件的值
function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
/*
 * 发布通知
 */
function click_save(){
	var uploadds = L5.DatasetMgr.lookup("uploadds");
	var record=uploadds.getCurrent();
	record.set("fileName",document.getElementById("fileName").value);
	record.set("fileType",document.getElementById("fileType").value);
	record.set("fileMess",document.getElementById("fileMess").value);

	var command=new L5.Command("com.inspur.cams.bpt.bptuploadfile.cmd.BptUploadfileCommand");
	command.setParameter("record",record);
	command.setForm("form_content");
	command.execute("uploadinsert");
	//包含有大字段的异常判断
	command.afterExecute=function(){
		if(!command.error){
		L5.Msg.alert("提示","上传附件成功!");
		 var url='jsp/cams/bpt/manage/group/bptuploadfile.jsp';
            L5.forward(url);
		}else{
	        L5.Msg.alert("提示",(command.error+'').replace("出现系统异常",""),{});
        }
	}
}
