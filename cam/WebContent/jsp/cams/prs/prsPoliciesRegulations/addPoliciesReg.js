function init(){
	var policRegDS=L5.DatasetMgr.lookup("policRegDS");
	policRegDS.newRecord();
}
//发布
function click_save(){
	var fileNum = document.getElementById("fileNum").value;
	if(fileNum==""){
		alert("文号不能为空!");
		return false;
	}
	var regulationsTitle = document.getElementById("regulationsTitle").value;
	if(regulationsTitle==""){
		alert("标题不能为空!");
		return false;
	}
	var content = document.getElementById("content").value;
	if(content==""){
		alert("内容不能为空!");
		return false;
	}
	var policRegDS=L5.DatasetMgr.lookup("policRegDS");
	var policRegRecord=policRegDS.getCurrent();
	var nowDate=new Date();
	policRegRecord.set("releaseDate",nowDate);
	policRegRecord.set("releaseCompany",organCode);
	policRegRecord.set("releaseCompanyName",organName);
	policRegRecord.set("releasePeople",empName);
	policRegRecord.set("effectFlag","01");
	var command=new L5.Command("com.inspur.cams.prs.prspoliciesregulations.cmd.PrsPoliciesRegulationsCmd");
	command.setParameter("record",policRegRecord);
	command.setForm(L5.getDom("form_content"));
	command.execute("insertProblemDeal");
	if(!command.error){
		L5.Msg.alert("提示","发布成功！",function(){
			L5.forward("jsp/cams/prs/prsPoliciesRegulations/sendPoliciesRegList.jsp");
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
	
}

//返回
function click_return(){
	var url="jsp/cams/prs/prsPoliciesRegulations/sendPoliciesRegList.jsp";
	L5.forward(url);
}
 var row_index=0;
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
  /**
 * 实现选择单位树
 */
function selectUser(flag){
	var policRegDS=L5.DatasetMgr.lookup("policRegDS");
	var policRegRecord=policRegDS.getCurrent();
	var url = "approvalsysorgantreecheckbox.jsp";
	var win = showModalDialog(url, null,
			"scroll:no;status:no;dialogWidth:500px;dialogHeight:550px");
	if (win == null) {
		return;
	}

	var id="'";
	var name="";
	var id_name="";

	// 如果是点击的是【确定】
	if (win[0].length > 0) {
		id += win[0][0];//id1,id2,id3......
		name = win[1][0];//name1,name2,name3......
		id_name=id+"["+name+"]";//id1[name1],id2[name2],id3[name3].......
		//其余值之间用逗号分隔
		if (win[0].length > 1) {
			for ( var i = 1; i < win[0].length; i++) {
				id = id + "," + win[0][i];
				name = name + "," + win[1][i];
				id_name=id_name+","+win[0][i]+"["+win[1][i]+"]";
			}
		}
	}
	id = id + "'";
	policRegRecord.set("acceptingCompanyCode",id);
	policRegRecord.set("acceptingCompany",name);
}