function init() {
	var applyDs=L5.DatasetMgr.lookup("applyDs");
    applyDs.setParameter("APPLY_ID@=",applyId);
 	applyDs.load();
 	applyDs.on("load",function(ds){
 		var record=ds.getAt(0);
 		var auditResult=record.get("auditResult");
 		record.set("applyTime",record.get("applyTime").substring(0,16));
 		if(method=="UPDATE" && organType=="13"){
 			var townOpinionId=record.get("townOpinionId");
 			if(!townOpinionId){
	 			record.set("townOpinionId","1");
 			}
 			if(auditResult=="2"){
	 			record.set("townOpinionId","0");
	 			record.set("townOpinion","");
 				$("townOpinionId").disabled=true;
 			}
 			$("townAuditTime").innerHTML=curDate.substring(0,4)+"年 "+curDate.substring(5,7)+"月 "+curDate.substring(8,10)+"日";
 		}else{
 			var townAuditTime=record.get("townAuditTime");
 			if(townAuditTime && townAuditTime.length>10){
 				$("townAuditTime").innerHTML=townAuditTime.substring(0,4)+"年 "+townAuditTime.substring(5,7)+"月 "+townAuditTime.substring(8,10)+"日";
 			}
 		}
 		if(method=="UPDATE" && organType=="12"){
 			var cityOpinionId=record.get("cityOpinionId");
 			if(!cityOpinionId){
	 			record.set("cityOpinionId","1");
 			}
 			if(auditResult=="2"){
	 			record.set("cityOpinionId","0");
	 			record.set("cityOpinion","");
 				$("cityOpinionId").disabled=true;
 			}
 			$("cityAuditTime").innerHTML=curDate.substring(0,4)+"年 "+curDate.substring(5,7)+"月 "+curDate.substring(8,10)+"日";
 		}else{
 			var cityAuditTime=record.get("cityAuditTime");
 			if(cityAuditTime && cityAuditTime.length>10){
 				$("cityAuditTime").innerHTML=cityAuditTime.substring(0,4)+"年 "+cityAuditTime.substring(5,7)+"月 "+cityAuditTime.substring(8,10)+"日";
 			}
 		}
 		if(method=="UPDATE" && organType=="11"){
 			var provinceOpinionId=record.get("provinceOpinionId");
 			if(!provinceOpinionId){
	 			record.set("provinceOpinionId","1");
 			}
 			if(auditResult=="2"){
	 			record.set("provinceOpinionId","0");
	 			record.set("provinceOpinion","");
 				$("provinceOpinionId").disabled=true;
 			}
 			$("provinceAuditTime").innerHTML=curDate.substring(0,4)+"年 "+curDate.substring(5,7)+"月 "+curDate.substring(8,10)+"日";
 		}else{
 			var provinceAuditTime=record.get("provinceAuditTime");
 			if(provinceAuditTime && provinceAuditTime.length>10){
 				$("provinceAuditTime").innerHTML=provinceAuditTime.substring(0,4)+"年 "+provinceAuditTime.substring(5,7)+"月 "
 				+provinceAuditTime.substring(8,10)+"日";
 			}
 		}
 		if(method=="UPDATE" && organType=="0"){
 			var departmentOpinionId=record.get("departmentOpinionId");
 			if(!departmentOpinionId){
	 			record.set("departmentOpinionId","1");
 			}
 			if(auditResult=="2"){
	 			record.set("departmentOpinionId","0");
	 			record.set("departmentOpinion","");
 				$("departmentOpinionId").disabled=true;
 			}
 			$("departmentAuditTime").innerHTML=curDate.substring(0,4)+"年 "+curDate.substring(5,7)+"月 "+curDate.substring(8,10)+"日";
 		}else{
 			var departmentAuditTime=record.get("departmentAuditTime");
 			if(departmentAuditTime && departmentAuditTime.length>10){
 				$("departmentAuditTime").innerHTML=departmentAuditTime.substring(0,4)+"年 "+departmentAuditTime.substring(5,7)+"月 "
 				+departmentAuditTime.substring(8,10)+"日";
 			}
 		}
 		//机构性质
 		$("xz"+record.get("organType")).style.display="";
 		
 		//辅导员信息
 		var tutorSource=record.get("tutorSource");
 		var tutorSourceNote=record.get("tutorSourceNote");
  		if(tutorSource.indexOf("1")>=0){
 			$("zfgmSpan").style.display="";
 		}
 		if(tutorSource.indexOf("2")>=0){
 			$("zyzSpan").style.display="";
 		}
 		//其他情况
 		if(tutorSourceNote!=""){
 			$("qtqksc").innerHTML="其他情况："+tutorSourceNote;
 		} 
 		//卫生间位置
 		var wcNum=record.get("wcNum")+"";
 		if(wcNum.indexOf("01")>=0){
 			$("station1").style.display="";
 		}
 		if(wcNum.indexOf("02")>=0){
 			$("station2").style.display="";
 		}
 		if(wcNum.indexOf("03")>=0){
 			$("station3").style.display="";
 		}
 		//无障碍通道
 		if(record.get("hasAccessiblePathway")<1){//无
 			$("wzatd2").style.display="";
 		}else{
 			$("wzatd1").style.display="";
 		}
 		//复印机
 		var equipment=record.get("equipment");
 		if(equipment.indexOf("1")>=0){
 			$("fyj").style.display="";
 		}
 		//传真机
 		if(equipment.indexOf("2")>=0){
 			$("czj").style.display="";
 		}
 		//扫描仪
 		if(equipment.indexOf("3")>=0){
 			$("smy").style.display="";
 		}
 		//电视机
 		if(equipment.indexOf("4")>=0){
 			$("dsj").style.display="";
 		}
 		//叫号机
 		if(equipment.indexOf("8")>=0){
 			$("jhj").style.display="";
 		}
 		//电子显示屏
 		if(equipment.indexOf("9")>=0){
 			$("dzxsp").style.display="";
 		}
 		//服务评价系统
 		if(equipment.indexOf("10")>=0){
 			$("fwpjxt").style.display="";
 		}
 		//监控设备
 		if(equipment.indexOf("11")>=0){
 			$("jksb").style.display="";
 		}
 	});
 	var queryDs=L5.DatasetMgr.lookup("queryDs");
 	queryDs.setParameter("DEPT_CODE",deptId);
 	queryDs.load();
 	var basePersonDs=L5.DatasetMgr.lookup("basePersonDs");
    basePersonDs.setParameter("DEPT_ID",deptId);
    basePersonDs.setParameter("MRM_BASE_PERSON.NAME@not like","%婚姻%");
    basePersonDs.load();
	//电子档案
 	mrmElectronicDataSet_load();
 	var tabpanel = L5.getCmp("approveTabPanel");
	tabpanel.on("activate",condition);
}

function save(){
	if(!checkSave()){
		return false;
	}
	var applyRecord=applyDs.getCurrent();
	applyRecord.set("curOrganCode",organCode);
	applyRecord.set("curOrganName",organName);
	applyRecord.set("dealOrganType",organType);
	var command=new L5.Command("com.inspur.cams.marry.application.cmd.MrmLevelApplyCmd");
	command.setParameter("applyRecord",applyRecord);
	command.execute("update");
	if (!command.error) {
		L5.Msg.alert('提示',"保存成功!",function(){
			back();
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function submit(){
	if(!checkSave()){
		return false;
	}	
	if(organType == '0'){
		curOrganCode="999";
		curOrganName="中华人民共和国民政部";
	}
	var applyRecord=applyDs.getCurrent();
	applyRecord.set("curOrganCode",curOrganCode);
	applyRecord.set("curOrganName",curOrganName);
	applyRecord.set("dealOrganType",organType);
	var command=new L5.Command("com.inspur.cams.marry.application.cmd.MrmLevelApplyCmd");
	command.setParameter("applyRecord",applyRecord);
	command.execute("updateAndSend");
	if (!command.error) {
		L5.Msg.alert('提示',"提交成功!",function(){
			back();
		});
	}else{
		L5.Msg.alert('提示',"提交时出现错误！"+command.error);
	}
}
function checkSave(){
	var applyRecord=applyDs.getCurrent();
	if(organType=="13" && !applyRecord.get("townOpinionId")){
		L5.Msg.alert('提示',"县级人民政府民政部门审核意见不能为空!");
		return false;
	}
	if(organType=="12" && !applyRecord.get("cityOpinionId")){
		L5.Msg.alert('提示',"地市级人民政府民政部门审核意见不能为空!");
		return false;
	}
	if(organType=="11" && !applyRecord.get("provinceOpinionId")){
		L5.Msg.alert('提示',"省级人民政府民政部门审核意见不能为空!");
		return false;
	}
	if(organType=="0" && !applyRecord.get("departmentOpinionId")){
		L5.Msg.alert('提示',"民政部审批意见不能为空!");
		return false;
	}
	return true;
}
//返回
function back(){
 	history.go(-1);
}
function clickShowHref(){
	var records=basePersonDs.getAllRecords();
	var result="";
	for(var i=0;i<records.length;i++){
		var record=records[i];
		if(record.get("name")!="平阴县民政局婚姻登记处管理员"){
		   result+='<a id="download" target=_blank href=../../../person/mrm_baseperson_print.jsp?personId='+record.get("personId")+'>'+record.get("name")+'</a>';
		   result+=',';
		}
	}
	return result;
}

function catalogName(){
	return "婚姻登记员有关材料复印件";
}
//判定婚姻登记机关等级评定标准是否符合
function condition(){
	compareDs.setParameter("APPLY_ID@=",applyId);
	compareDs.load();
	compareDs.on("load",writeTable);
}

function writeTable(){
	var t=$("dzb");
	var len = t.rows.length; 
    for(var i = 0;i < len;i++){
    	t.deleteRow(0);

    }
	var r = t.insertRow();
	 var t1=r.insertCell();
	 t1.innerHTML= "序号";
	 t1.align="center";
	 var t2=r.insertCell();
	 t2.innerHTML= "章节号";
	 t2.align="center";
	 var t3=r.insertCell();
	 t3.innerHTML= $("applyLevel").innerHTML+"标准要求";
	 t3.align="center";
	 t3.width="150";
	 var t4=r.insertCell();
	 t4.innerHTML= "实际完成情况";
	 t4.align="center";
	 t4.width="310";
	for(var i=1;i<=compareDs.getCount();i++){	
		var r = t.insertRow();
		 r.insertCell().innerHTML= compareDs.getAt(i-1).get("seq");
		 r.insertCell().innerHTML= compareDs.getAt(i-1).get("chapter");
		 r.insertCell().innerHTML= compareDs.getAt(i-1).get("require");
		 r.insertCell().innerHTML= '<textarea align="left" rows="3"cols="40" style="font-size:17px;width:100%;overflow:hidden;border:0" readonly="true">'+
		 	compareDs.getAt(i-1).get("actural")+'</textarea>';
	}
}
function wordcontorl(){ 
	var WordApp=new ActiveXObject("Word.Application"); 
	var wdCharacter=1 
	var wdOrientLandscape = 1 
	WordApp.Application.Visible=true; //执行完成之后是否弹出已经生成的word 
	var myDoc=WordApp.Documents.Add();//创建新的空文档 
	//WordApp.ActiveDocument.PageSetup.Orientation = wdOrientLandscape;//页面方向设置为横向 
	WordApp.Selection.ParagraphFormat.Alignment=1; //1居中对齐,0为居右 
	//WordApp. Selection.Font.Bold=true; 
	WordApp.Selection.Font.Size=20; 
	WordApp.Selection.TypeText("婚姻登记机关基本情况和等级标准要求对照表"); 
	WordApp.Selection.MoveRight(wdCharacter);　　　　//光标右移字符 
	WordApp.Selection.TypeParagraph();　　　　　　　　　//插入段落 
	WordApp.Selection.Font.Size=12; 
	//WordApp. Selection.TypeText("-----朱漪编写"); //分行插入日期 
	WordApp.Selection.TypeParagraph();　　　　　　　　　//插入段落 
	var myTable=myDoc.Tables.Add (WordApp.Selection.Range,compareDs.getCount()+1,4); //8行7列的表格 
	
	myTable.Columns.Item(1).SetWidth(30, '');
	myTable.Columns.Item(2).SetWidth(50, '');
	myTable.Columns.Item(3).SetWidth(260, '');
	myTable.Columns.Item(4).SetWidth(100, '');


	
	
	myTable.Style="网格型" 
	var aa = "孟佳标题"; 
	var TableRange; //以下为给表格中的单元格赋值 
	
	with (myTable.Cell(1,1).Range) { 
		font.Size = 12; 
		InsertAfter("序号"); 
	} 
	with (myTable.Cell(1,2).Range) { 
		font.Size = 12; 
		InsertAfter("章节号"); 
	} 
	with (myTable.Cell(1,3).Range) { 
		font.Size = 12; 
		InsertAfter($("applyLevel").innerHTML+"标准要求"); 
	} 
	with (myTable.Cell(1,4).Range) { 
		font.Size = 12; 
		InsertAfter("实际完成情况"); 
	}
	 
	

	
	for (i =0;i<compareDs.getCount() ;i++) { 
		
			
			with (myTable.Cell(i+2,1).Range) { 
				font.Size = 12; 
				InsertAfter(compareDs.getAt(i).get("seq")); 
				ParagraphFormat.Alignment =1;  //设置对齐方式 水平对齐
			} 
			with (myTable.Cell(i+2,2).Range) { 
				font.Size = 12; 
				InsertAfter(compareDs.getAt(i).get("chapter")); 
			} 
			with (myTable.Cell(i+2,3).Range) { 
				font.Size = 12; 
				InsertAfter(compareDs.getAt(i).get("require")); 
			} 
			with (myTable.Cell(i+2,4).Range) { 
				font.Size = 12; 
				InsertAfter(compareDs.getAt(i).get("actural")); 
			}
	} 
	row_count = 0; 
	col_count = 0;
	//myDoc.Protect(1); 
} 
