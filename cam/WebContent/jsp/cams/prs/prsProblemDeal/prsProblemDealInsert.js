function init(){
	
	var domicileDatasetDomicile = L5.DatasetMgr.lookup("domicileCityDataset");

    domicileDatasetDomicile.setParameter("filterSql", "leve='1' and substr(id,1,2)= '" + organArea.substring(0, 2) + "'");
	domicileDatasetDomicile.load();
	//domicileDataset.setParameter("filterSql"," id like '"+"3701"+"%000000'");
	//domicileDataset.load();
	
	if(method=="insert"){
		var problemDealDS=L5.DatasetMgr.lookup("problemDealDS");
		var supervisionDS=L5.DatasetMgr.lookup("supervisionDS");
		problemDealDS.newRecord();
		problemDealDS.set('problemFrom','03');
		problemDealDS.set('supervision','0');
	}else if(method=="update"){
		var problemDealDS=L5.DatasetMgr.lookup("problemDealDS");
		problemDealDS.setParameter("PROBLEM_ID",problemId);
		problemDealDS.load();
	}
}
//保存
function save_problem(){
	var problemDealDS=L5.DatasetMgr.lookup("problemDealDS");
	var problemRecord=problemDealDS.getCurrent();
	if(problemRecord.get("dealFlag")!=03){
		problemRecord.set("deal","");
		problemRecord.set("dealPerson","");
		problemRecord.set("dealTime","");
	}
	
	if(problemRecord.get("dealFlag")=="01"){
		problemRecord.set("curActivity","01");
	}
	if(problemRecord.get("dealFlag")=="03"){
		problemRecord.set("curActivity","02");
	}
	if(problemRecord.get("problemTitle")==""){
		L5.Msg.alert("提示","问题标题不能为空！");
		return false;
	}
	if(problemRecord.get("problemNumbers")==""){
		L5.Msg.alert("提示","问题编号不能为空！");
		return false;
	}
	if(problemRecord.get("problemPerson")==""){
		L5.Msg.alert("提示","反映人名称不能为空！");
		return false;
	}
	if(problemRecord.get("problemCompany")==""){
		L5.Msg.alert("提示","反映人单位不能为空！");
		return false;
	}
	if(problemRecord.get("personNumber")==""){
		L5.Msg.alert("提示","反映人数不能为空！");
		return false;
	}
	if(problemRecord.get("problemDate")==""){
		L5.Msg.alert("提示","反映时间不能为空！");
		return false;
	}
	if(problemRecord.get("content")==""){
		L5.Msg.alert("提示","反映内容不能为空！");
		return false;
	}
	if(problemRecord.get("dealFlag") == "") {
		L5.Msg.alert("提示","处理结果不能为空！");
		return false;
	}
	var command=new L5.Command("com.inspur.cams.prs.prsproblemdeal.cmd.PrsProblemDealCmd");
	if(problemRecord.get("dealFlag")=="02"){
		if(_$("area")==""){
		L5.Msg.alert("提示","请选择要转发的单位！");
			return false;
		}
		problemRecord.set("curActivity","01");
		command.setParameter("receiveOrgan",_$("area"));
		var area=$("area");
		command.setParameter("receiveOrganName",area[area.selectedIndex].text);
	}
	command.setParameter("record",problemRecord);
	command.setForm(L5.getDom("form_content"));
	if(method=="insert"){
		command.execute("insertProblemDeal");
	}else if(method=="update"){
		command.execute("updateProblemDeal");
	}
	
	if(!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			L5.forward("jsp/cams/prs/prsProblemDeal/prsProblemDealList.jsp");
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
//代办
function send_problem11(){
	$("area").disabled=true;
	$("area").value="";
	$("area1").disabled=true;
	$("area1").value="";
	document.getElementById("deal").disabled=true ;
	document.getElementById("deal").value="";
	document.getElementById("dealPerson").disabled=true;
	document.getElementById("dealPerson").value="";
	document.getElementById("dealTime").disabled=true;
	document.getElementById("dealTime").value="";
}
//已办理
function send_problem1(){

	$("area").disabled=true;
	$("area").value="";
	$("area1").disabled=true;
	$("area1").value="";
	document.getElementById("deal").disabled=false;
	document.getElementById("dealPerson").disabled=false;
	document.getElementById("dealTime").disabled=false;
}
//返回
function return_problem(){
	var url="jsp/cams/prs/prsProblemDeal/prsProblemDealList.jsp";
	L5.forward(url);
}
//转发
function send_problem(){
	$("area").disabled=false;
	$("area1").disabled=false;
	document.getElementById("deal").disabled=true ;
	document.getElementById("deal").value="";
	document.getElementById("dealPerson").disabled=true;
	document.getElementById("dealPerson").value="";
	document.getElementById("dealTime").disabled=true;
	document.getElementById("dealTime").value="";
}
function setDomicile() {
    var domicileDatasetDomicile = L5.DatasetMgr.lookup("domicileDataset");
    var county=document.getElementById("area1").value;
    if (county.length > 9) {
        domicileDatasetDomicile.setParameter("filterSql", "leve='2' and substr(id,1,4)= '" + county.substring(0, 4) + "'");
        domicileDatasetDomicile.load();
    }
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