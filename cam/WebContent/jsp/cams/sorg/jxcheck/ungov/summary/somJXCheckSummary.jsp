<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.StrUtil"%>
<html>
	<head>
	<title>民办非企业单位年检信息汇总</title>
	<next:ScriptManager/>
<%
	String taskCode = StrUtil.n2b((String)request.getParameter("taskCode"));
	String year = StrUtil.n2b((String)request.getParameter("year"));
	String CheckStatus = StrUtil.n2b((String)request.getParameter("CheckStatus"));
	String sorgKind = StrUtil.n2b((String)request.getParameter("sorgKind"));
	String ifGridAll = StrUtil.n2b((String)request.getParameter("ifGridAll"));
%>
<style media="print">
	.noprint     { display: none }
</style>
<script language="javascript">
	var taskCode='<%=taskCode%>';
	var year='<%=year%>';
	var CheckStatus='<%=CheckStatus%>';
	var ifGridAll='<%=ifGridAll%>';
	var sorgKind='<%=sorgKind%>';
	function init(){
		if(ifGridAll == ''){
			ds.setParameter("TASK_CODE",taskCode);
			ds.setParameter("CHECK_YEAR",year);
			ds.load();
		}else{
			ds.setParameter("SORG_KIND",sorgKind);
			ds.setParameter("CHECK_YEAR",year);
			ds.setParameter("STATUS",CheckStatus);
			ds.setParameter("ifGridAll",ifGridAll);
			ds.setParameter("SORG_TYPE","M");
			ds.load();
		}
	}
	function back(){
		var data=new L5.Map();
		data.put("searchYear",year);
		data.put("CheckStatus",CheckStatus);
		url="jsp/cams/sorg/jxcheck/ungov/summary/somJXCheckSummaryList.jsp";
		L5.forward(url,'',data);
	}
/*
展示基本信息的具体数值
item:具体字段
value：当前字段的值
title:标题即列名
*/
var fileName="";
function showbaseWin(item,value,title){
	if( value == "0"){
		return;
	}
	baseInfoDs.removeAll();
	baseInfoDs.setParameter("SORG_TYPE","M");
	baseInfoDs.setParameter("ITEM",item);
	baseInfoDs.setParameter("TASK_CODE",taskCode);
	baseInfoDs.setParameter("CHECK_YEAR",year);
	baseInfoDs.load();
	L5.getCmp("baseShowList").setVisible(true);
	L5.getCmp("baseShowList").setTitle(title);
	var colModel = L5.getCmp("baseShowListGrid").getColumnModel();
	fileName=title;
}
var isparty=false;
function showWin(value,field,tableName,columnName){
	isparty=false;
	if( value == "0"){
		return;
	}
	detailDs.removeAll();
	if(field.slice(field.length-2,field.length) == '_A'){
		field=field.slice(0,field.length-2);
		detailDs.setParameter("ifBuildParty","0");
	}
	if(field.indexOf('CURRENT_TOTAL') != -1 || field.indexOf('IN_TOTAL')!=-1 || field.indexOf('OFF_TOTAL')!=-1){
		if(field.slice(field.length-1,field.length) == '1'){
			detailDs.setParameter("IF_OPEN","1");
			field = field.slice(0,field.length-1);
		}else if(field.slice(field.length-1,field.length) == '2'){
			detailDs.setParameter("IF_OPEN","2");
			field = field.slice(0,field.length-1);
		}else{
			detailDs.setParameter("IF_OPEN","0");
		}
	}else if(('1234567890').indexOf(field.slice(field.length-1,field.length))!=-1){
		if(field.indexOf('NO_BUILD_PARTY_RESON') != -1){
			detailDs.setParameter("ifBuildParty","0");
		}else if(field.indexOf('IF_PARTY_OFFICER') != -1){
			detailDs.setParameter("ifBuildParty","0");
		}
		detailDs.setParameter("sqlfield",field.slice(field.length-1,field.length));
		field = field.slice(0,field.length-1);
		isparty=true;
	}
	detailDs.setParameter("SORG_TYPE","M");
	detailDs.setParameter("FIELD",field);
	detailDs.setParameter("TABLE_NAME",tableName);
	detailDs.setParameter("TASK_CODE",taskCode);
	detailDs.setParameter("CHECK_YEAR",year);
	detailDs.load();
	/*
	detailDs.on('load',function (){
		detailDs.filterBy(function(record, id){
			if(record.get(field) != '0'){
				return record;
			}
		});
	});
	*/
	L5.getCmp("showList").setVisible(true);
	L5.getCmp("showList").setTitle(columnName);
	var colModel = L5.getCmp("showListGrid").getColumnModel();
	if(isparty){
		colModel.setHidden(3,true);
	}else{
		colModel.setColumnHeader(3,columnName);
		colModel.setDataIndex(3,field);
		colModel.setHidden(3,false);
	}
	fileName=columnName;
	L5.getCmp("showList").setPosition(L5.getCmp("showList").getPosition[0],getScrollTop()+30);
}
function exportExcel(){
	var dataset=L5.DatasetMgr.lookup("baseInfoDs");
	var pageSize = dataset.pageInfo.pageSize;
	var pageIndex = dataset.pageInfo.pageIndex;
	var startCursor = dataset.pageInfo.startCursor;
	dataset.baseParams["excelType"]="1";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	dataset.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
	dataset.baseParams["limitExcel"]=dataset.getTotalCount();
//	dataset.baseParams["limitExcel"]=pageSize;  //导出记录数，如导出类型为导出符合查询条件所有记录时，其值为dataset.getTotalCount()
	L5.dataset2excel(dataset,"/jsp/cams/sorg/jxcheck/fund/summary/somJXCheckSummaryToExcelBaseInfo.jsp?title="+fileName);
	dataset.baseParams["excelType"]="reset"; //重置导出类型

}
function exportDetailExcel(){

	var dataset=L5.DatasetMgr.lookup("detailDs");
	var pageSize = dataset.pageInfo.pageSize;
	var pageIndex = dataset.pageInfo.pageIndex;
	var startCursor = dataset.pageInfo.startCursor;
	dataset.baseParams["excelType"]="1";  //导出类型 0：导出当前页；1：导出符合查询条件所有记录
	dataset.baseParams["startExcel"]=startCursor;  //总记录中当前页记录起始位置
	dataset.baseParams["limitExcel"]=dataset.getTotalCount();
	if(isparty){
		L5.dataset2excel(dataset,"/jsp/cams/sorg/jxcheck/fund/summary/somJXCheckSummaryToExcelBaseInfo.jsp?title="+fileName);
	}else{
		L5.dataset2excel(dataset,"/jsp/cams/sorg/jxcheck/fund/summary/somJXCheckSummaryToExcelDetail.jsp?title="+fileName+"&field="+L5.getCmp("showListGrid").getColumnModel().getDataIndex(3));
	}
	dataset.baseParams["excelType"]="reset"; //重置导出类型
}
function closeBaseWin(){
	L5.getCmp("baseShowList").hide();
}
function closeWin(){
	L5.getCmp("showList").hide();
}
//获取滚动条高度
function getScrollTop()
	{
	var scrollTop=0;
	if(document.documentElement&&document.documentElement.scrollTop)
	{
	scrollTop=document.documentElement.scrollTop;
	}
	else if(document.body)
	{
	scrollTop=document.body.scrollTop;
	}
	return scrollTop;
}
function print(){
	document.execCommand("Print",false);
}
</script>
<script language="javascript">
function exportWord(){
	ExcelSheet = new ActiveXObject('Word.Application');
    ExcelSheet.Application.Visible = true;
    var mydoc=ExcelSheet.Documents.Add('',0,0);
    myRange =mydoc.Range(0,1);
    myRange =mydoc.Range(myRange.End-1,myRange.End);//设定起始点
    var sel=document.body.createTextRange();
    var Layer1 = document.getElementById("Layer1");
    sel.moveToElementText(Layer1);
    sel.select();
    document.execCommand('Copy');
    sel.moveEnd('character');
    myRange.Paste();
    myRange =mydoc.Range(myRange.End-1,myRange.End);
    myRange.InsertAfter("\n");
    ExcelSheet.ActiveWindow.View.TableGridlines = false;
}
</script>



<style media="print">
	.noprint     { display: none }
</style>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckQueryCommand" method="queryUngovCheckReport" global="true">
	</model:dataset>

	<model:dataset id="baseInfoDs" cmd="com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckQueryCommand" method="queryCheckBaseAnalyse" global="true">
	</model:dataset>

	<model:dataset id="detailDs" cmd="com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckQueryCommand" method="queryCheckAnalyse" global="true">
	</model:dataset>
	<model:dataset id="somCheckStatus" enumName="SOM.CHECK_STATUS" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel border="0">
<next:Panel id="panel" cls="noprint" border="0">
<next:TopBar>
		<next:ToolBarItem text='' id="displayItem"/>
		<next:ToolBarItem symbol="民办非企业单位年检信息汇总"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="打印" iconCls="print" handler="print"></next:ToolBarItem>
		<next:ToolBarItem text="导出WORD" iconCls="print" handler="exportWord"></next:ToolBarItem>
		<next:ToolBarItem text="返回" iconCls="return" handler="back"></next:ToolBarItem>
</next:TopBar>
</next:Panel>
<next:Html>
<div id="Layer1" style='text-align:center'>

<p class=MsoNormal style="text-align:right"><span lang=EN-US style="text-align:left"></span></p>

<p class=MsoNormal align="center"><span style='font-size: 15.0pt; font-family: 黑体; mso-hansi-font-family: 宋体;'>
	民办非企业单位年检信息汇总</span></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<form method="post" onsubmit="return false" class="L5form" dataset="ds">
<table width="650">
	<tr>
		<td class="FieldInput" width="80%">民办非企业单位年检信息民办非企业单位已经上报的总数为</td>
		<td class="FieldInput" width="20%"><label name="民办非企业单位年检信息民办非企业单位已经上报的总数"
			field="TOTAL" onclick="showbaseWin('1',this.innerHTML,this.name)" style="cursor:hand;color:blue"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="80%">民办非企业单位年检信息民办非企业单位已经上报的审批完成数为</td>
		<td class="FieldInput" width="20%"><label name="民办非企业单位年检信息民办非企业单位已经上报的审批完成数"
			field="CHECK_PASS" onclick="showbaseWin('2',this.innerHTML,this.name)" style="cursor:hand;color:blue"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="80%">民办非企业单位年检信息民办非企业单位已经上报的未审批完成数为</td>
		<td class="FieldInput" width="20%"><label name='民办非企业单位年检信息民办非企业单位已经上报的未审批完成数'
			field="CHECK_NO_PASS" onclick="showbaseWin('3',this.innerHTML,this.name)" style="cursor:hand;color:blue"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="80%">民办非企业单位年检信息中年检合格的民办非企业单位个数为</td>
		<td class="FieldInput" width="20%"><label name='民办非企业单位年检信息中年检合格的民办非企业单位个数'
			field="CHECK_OK" onclick="showbaseWin('4',this.innerHTML,this.name)" style="cursor:hand;color:blue"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="80%">民办非企业单位年检信息中年检基本合格的民办非企业单位个数为</td>
		<td class="FieldInput" width="20%"><label name="民办非企业单位年检信息中年检基本合格的民办非企业单位个数"
			field="CHECK_BASAL_OK" onclick="showbaseWin('5',this.innerHTML,this.name)" style="cursor:hand;color:blue"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="80%">民办非企业单位年检信息中年检不合格的民办非企业单位个数为</td>
		<td class="FieldInput" width="20%"><label name="民办非企业单位年检信息中年检不合格的民办非企业单位个数"
			field="CHECK_NOT_OK" onclick="showbaseWin('6',this.innerHTML,this.name)" style="cursor:hand;color:blue"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="80%">民办非企业单位年检信息中一年未年检的民办非企业单位个数为</td>
		<td class="FieldInput" width="20%"><label name="民办非企业单位年检信息中一年未年检的民办非企业单位个数"
			field="ONE_YEAR" onclick="showbaseWin('7',this.innerHTML,this.name)" style="cursor:hand;color:blue"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="80%">民办非企业单位年检信息中两年未年检的民办非企业单位个数为</td>
		<td class="FieldInput" width="20%"><label name="民办非企业单位年检信息中两年未年检的民办非企业单位个数"
			field="TWO_YEAR" onclick="showbaseWin('8',this.innerHTML,this.name)" style="cursor:hand;color:blue"></label></td>
	</tr>
</table>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal align="center"><span style='font-size: 13.0pt; font-family: 黑体; mso-hansi-font-family: 宋体;'>
	（一）基本情况</span></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<table width="650">
	<tr>
		<td class="FieldInput" width="25%">开办资金（万元）</td>
		<td class="FieldInput" width="25%" colspan="3"><label
			field="INITIAL_FUND"  style="cursor:hand;color:blue" onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK','开办资金（万元）')"></label></td>

	</tr>
	<tr>
		<td class="FieldInput" width="25%">目前在校学生人数（学校类）</td>
		<td class="FieldInput" width="25%"><label
		 style="cursor:hand;color:blue" onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK','目前在校学生人数（学校类）')"	field="IN_SCHOOL_NUM"></label></td>
		<td class="FieldInput" width="25%">本年度共培训人数（劳动类）</td>
		<td class="FieldInput" width="25%"><label
			 style="cursor:hand;color:blue" onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK','本年度共培训人数（劳动类）')"field="TRAIN_NUM"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">本年度医疗服务人数（卫生类）</td>
		<td class="FieldInput" width="25%"><label
		 style="cursor:hand;color:blue" onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK','本年度医疗服务人数（卫生类）')"	field="MEDICAL_NUM"></label></td>
		<td class="FieldInput" width="25%">本年度共举行文化服务活动次数（文化类）</td>
		<td class="FieldInput" width="25%"><label
		 style="cursor:hand;color:blue" onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK','本年度共举行文化服务活动次数（文化类）')"	field="CULTURE_ACTIVITY_NUM"></label></td>
	</tr>
</table>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal align="center"><span style='font-size: 13.0pt; font-family: 黑体; mso-hansi-font-family: 宋体;'>
	（二）人员情况</span></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<table width="650">
<tr>
		<td class="FieldInput" width="25%">从业人员总数</td>
		<td class="FieldInput" width="25%"><label
			field="PRACTITIONER_NUM" style="cursor:hand;color:blue" onclick="showWin(this.innerHTML,this.field,'SOM_JX_PEOPLE','从业人员总数')"></label></td>
		<td class="FieldInput" width="25%">从业人员总数中女性人数</td>
		<td class="FieldInput" width="25%"><label
			field="WOMAN_PRAC_NUM" style="cursor:hand;color:blue" onclick="showWin(this.innerHTML,this.field,'SOM_JX_PEOPLE','从业人员总数中女性人数')"></label></td>

	</tr>
	<tr>
		<td class="FieldInput" width="25%">专职人员总数</td>
		<td class="FieldInput" width="25%"><label
			field="FULLTIME_NUM" style="cursor:hand;color:blue" onclick="showWin(this.innerHTML,this.field,'SOM_JX_PEOPLE','专职人员总数')"></label></td>
		<td class="FieldInput" width="25%">专职人员中签订劳动合同人数</td>
		<td class="FieldInput" width="25%"><label
			field="FULLTIME_CONTRACT_NUM" style="cursor:hand;color:blue" onclick="showWin(this.innerHTML,this.field,'SOM_JX_PEOPLE','专职人员中签订劳动合同人数')"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">专职人员中离退休返聘人数</td>
		<td class="FieldInput" width="25%"><label
			field="RETIRED_NUM" style="cursor:hand;color:blue" onclick="showWin(this.innerHTML,this.field,'SOM_JX_PEOPLE','专职人员中离退休返聘人数')"></label></td>

		<td class="FieldInput" width="25%">兼职人员中在国家机关任职人数</td>
		<td class="FieldInput" width="25%"><label
			  style="cursor:hand;color:blue" onclick="showWin(this.innerHTML,this.field,'SOM_JX_PEOPLE','兼职人员中在国家机关任职人数')"field="PARTTIME_GOV_NUM"></label></td>
	</tr>
	<tr>
	<td class="FieldInput" width="25%">兼职人员中在企事业单位任职人数</td>
		<td class="FieldInput" width="25%"><label
			 style="cursor:hand;color:blue" onclick="showWin(this.innerHTML,this.field,'SOM_JX_PEOPLE','兼职人员中在企事业单位任职人数')"field="ENTERPRISES_NUM"></label></td>
		<td class="FieldInput" width="25%">兼职人员中其他人数</td>
		<td class="FieldInput" width="25%"><label
			 style="cursor:hand;color:blue" onclick="showWin(this.innerHTML,this.field,'SOM_JX_PEOPLE','兼职人员中其他人数')"field="OTHER_NUM"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">35岁及以下人数</td>
		<td class="FieldInput" width="25%"><label
			 style="cursor:hand;color:blue" onclick="showWin(this.innerHTML,this.field,'SOM_JX_PEOPLE','35岁及以下人数')"field="UNDER_THIRTYFIVE_NUM"></label></td>
		<td class="FieldInput" width="25%">36—50岁人数</td>
		<td class="FieldInput" width="25%"><label
			 style="cursor:hand;color:blue" onclick="showWin(this.innerHTML,this.field,'SOM_JX_PEOPLE','36—50岁人数')"field="THIRTYSIX_TO_FIFTY_NUM"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">51—60岁人数</td>
		<td class="FieldInput" width="25%"><label
			 style="cursor:hand;color:blue" onclick="showWin(this.innerHTML,this.field,'SOM_JX_PEOPLE','51—60岁人数')"field="FIFTYONE_TO_SIXTY_NUM"></label></td>
		<td class="FieldInput" width="25%">60岁以上人数</td>
		<td class="FieldInput" width="25%"><label
			 style="cursor:hand;color:blue" onclick="showWin(this.innerHTML,this.field,'SOM_JX_PEOPLE','60岁以上人数')"field="ABOVE_SIXTY_NUM"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">高中及以下学历人数</td>
		<td class="FieldInput" width="25%"><label
			 style="cursor:hand;color:blue" onclick="showWin(this.innerHTML,this.field,'SOM_JX_PEOPLE','高中及以下学历人数')"field="UNDER_HIGHSCHOOL_NUM"></label></td>
		<td class="FieldInput" width="25%">大学本科及专科学历人数</td>
		<td class="FieldInput" width="25%"><label
			 style="cursor:hand;color:blue" onclick="showWin(this.innerHTML,this.field,'SOM_JX_PEOPLE','大学本科及专科学历人数')"field="UNIVERSITY_NUM"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">硕士及以上学历人数</td>
		<td class="FieldInput" width="25%" colspan="3"><label
			 style="cursor:hand;color:blue" onclick="showWin(this.innerHTML,this.field,'SOM_JX_PEOPLE','硕士及以上学历人数')"field="ABOVE_MASTER_NUM"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">负责人总数</td>
		<td class="FieldInput" width="25%"><label
		 style="cursor:hand;color:blue" onclick="showWin(this.innerHTML,this.field,'SOM_JX_PEOPLE','负责人总数')"	field="PRINCIPAL_NUM"></label></td>
		<td class="FieldInput" width="25%">负责人中女性数</td>
		<td class="FieldInput" width="25%"><label
			 style="cursor:hand;color:blue" onclick="showWin(this.innerHTML,this.field,'SOM_JX_PEOPLE','兼职人员中其他人数')"field="WOMEN_PRINCIPAL_NUM"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">从业人员中担任党代表人数</td>
		<td class="FieldInput" width="25%"><label
			 style="cursor:hand;color:blue" onclick="showWin(this.innerHTML,this.field,'SOM_JX_PEOPLE','从业人员中担任党代表人数')"field="ABOVE_COUNTY_NUM"></label></td>
		<td class="FieldInput" width="25%">从业人员中担任省级及以下党代表人数</td>
		<td class="FieldInput" width="25%"><label
			 style="cursor:hand;color:blue" onclick="showWin(this.innerHTML,this.field,'SOM_JX_PEOPLE','从业人员中担任省级及以下党代表人数')"field="PARTY_NUM_PROVINCE"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">从业人员中担任全国性党代表人数</td>
		<td class="FieldInput" width="25%"><label
			 style="cursor:hand;color:blue" onclick="showWin(this.innerHTML,this.field,'SOM_JX_PEOPLE','从业人员中担任全国性党代表人数')"field="PARTY_NUM_NATION"></label></td>

		<td class="FieldInput" width="25%">从业人员中担任人大代表人数</td>
		<td class="FieldInput" width="25%"><label
			 style="cursor:hand;color:blue" onclick="showWin(this.innerHTML,this.field,'SOM_JX_PEOPLE','从业人员中担任人大代表人数')"field="NPC_NUM"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">从业人员中担任省级及以下人大代表人数</td>
		<td class="FieldInput" width="25%"><label
			 style="cursor:hand;color:blue" onclick="showWin(this.innerHTML,this.field,'SOM_JX_PEOPLE','从业人员中担任省级及以下人大代表人数')"field="NPC_NUM_PROVINCE"></label></td>

		<td class="FieldInput" width="25%">从业人员中担任全国性人大代表人数</td>
		<td class="FieldInput" width="25%"><label
			 style="cursor:hand;color:blue" onclick="showWin(this.innerHTML,this.field,'SOM_JX_PEOPLE','从业人员中担任全国性人大代表人数')"field="NPC_NUM_NATION"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">从业人员中担任政协委员人数</td>
		<td class="FieldInput" width="25%"><label
			 style="cursor:hand;color:blue" onclick="showWin(this.innerHTML,this.field,'SOM_JX_PEOPLE','从业人员中担任政协委员人数')"field="CPPCC_NUM"></label></td>

		<td class="FieldInput" width="25%">从业人员中担任省级及以下政协委员人数</td>
		<td class="FieldInput" width="25%"><label
			 style="cursor:hand;color:blue" onclick="showWin(this.innerHTML,this.field,'SOM_JX_PEOPLE','从业人员中担任省级及以下政协委员人数')"field="CPPCC_NUM_PROVINCE"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">从业人员中担任全国性政协委员人数</td>
		<td class="FieldInput" width="25%"><label
			 style="cursor:hand;color:blue" onclick="showWin(this.innerHTML,this.field,'SOM_JX_PEOPLE','从业人员中担任全国性政协委员人数')"field="CPPCC_NUM_NATION"></label></td>

		<td class="FieldInput" width="25%"></td>
		<td class="FieldInput" width="25%"></td>
	</tr>
</table>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal align="center"><span style='font-size: 13.0pt; font-family: 黑体; mso-hansi-font-family: 宋体;'>
	（三）组织建设和活动情况</span></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<table width="650">
	<tr>
		<td class="FieldInput" width="25%">理事会总人数</td>
		<td class="FieldInput" width="25%"><label
			field="COUNCIL_NUM"></label></td>
		<td class="FieldInput" width="25%">监事会总人数</td>
		<td class="FieldInput" width="25%"><label
			field="AUDITOR_NUM"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">本年度召开理事会次数</td>
		<td class="FieldInput" width="25%"><label
			field="COUNCIL_TIMES"></label></td>
		<td class="FieldInput" width="25%">本年度召开监事会次数</td>
		<td class="FieldInput" width="25%"><label
			field="AUDITING_TIMES"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">开展公益活动项目个数</td>
		<td class="FieldInput" width="25%"><label
			field="COMMONWEAL_NUM" style="cursor:hand;color:blue" onclick="showWin(this.innerHTML,this.field,'SOM_JX_ACTIVITY','开展公益活动项目个数')"></label></td>
		<td class="FieldInput" width="25%">公益活动次数</td>
		<td class="FieldInput" width="25%"><label
			field="COMMONWEAL_TIMES"style="cursor:hand;color:blue" onclick="showWin(this.innerHTML,this.field,'SOM_JX_ACTIVITY','公益活动次数')"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">公益活动支出金额（元）</td>
		<td class="FieldInput" width="25%" colspan="3"><label
			field="COMMONWEAL_OUT"style="cursor:hand;color:blue" onclick="showWin(this.innerHTML,this.field,'SOM_JX_ACTIVITY','公益活动支出金额（元)')"></label></td>

	</tr>
	<tr>
		<td class="FieldInput" width="25%">年度缴税总额（元）</td>
		<td class="FieldInput" width="25%"><label
			field="TAX_TOTAL" onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_FINANCE','年度缴税总额（元）')" style="cursor:hand;color:blue"></label></td>
		<td class="FieldInput" width="25%">其中缴营业税（元）</td>
		<td class="FieldInput" width="25%"><label
			field="SALES_TAX"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">其中缴所得税（元）</td>
		<td class="FieldInput" width="25%"><label
			field="INCOME_TAX"></label></td>
		<td class="FieldInput" width="25%">缴其他税费（元）</td>
		<td class="FieldInput" width="25%"><label
			field="OTHER_TAX"></label></td>
	</tr>

		 <tr>
		<td class="FieldInput" width="25%">年度所获资金</td>
		<td class="FieldInput" width="25%"><label
			field="CAPITAL"style="cursor:hand;color:blue" onclick="showWin(this.innerHTML,this.field,'SOM_JX_ACTIVITY','年度所获资金')"></label></td>
		<td class="FieldInput" width="25%"> </td>
		<td class="FieldInput" width="25%"> </td>
	</tr>
</table>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal align="center"><span style='font-size: 13.0pt; font-family: 黑体; mso-hansi-font-family: 宋体;'>
	（四）党建情况</span></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<table width="650">
	<tr>
		<td  width="25%" align="center" colspan="4" style='font-size: 11.0pt; font-family: 黑体; mso-hansi-font-family: 宋体;'>
			已建党组织<label field="IF_BUILD_PARTY1"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','已建党组织')"
			style="cursor: hand; color: blue"></label>
			个，专职党务工作者人数<label field="PARTY_WORKER_NUM"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','专职党务工作者人数')"
			 style="cursor: hand; color: blue"></label> 个。</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%" rowspan="6">党组织形式</td>
		<td class="FieldInput" width="25%">党委<label field="PARTY_TYPE1"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','党委')" style="cursor: hand; color: blue"></label>个</td>
		<td class="FieldInput" width="25%" rowspan="6">党组织隶属关系</td>
		<td class="FieldInput" width="25%">业务主管单位党组织<label field="PARTY_RELATION_TYPE1"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','业务主管单位党组织')" style="cursor: hand; color: blue"></label>个</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">党总支<label field="PARTY_TYPE2"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','党总支')" style="cursor: hand; color: blue"></label>个</td>
		<td class="FieldInput" width="25%">挂靠单位党组织<label field="PARTY_RELATION_TYPE2"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','挂靠单位党组织')" style="cursor: hand; color: blue"></label>个</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">党支部<label field="PARTY_TYPE3"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','党支部')" style="cursor: hand; color: blue"></label>个</td>
		<td class="FieldInput" width="25%">属地党组织<label field="PARTY_RELATION_TYPE3"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','属地党组织')" style="cursor: hand; color: blue"></label>个</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">临时支部<label field="PARTY_TYPE4"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','临时支部')" style="cursor: hand; color: blue"></label>个</td>
		<td class="FieldInput" width="25%">行业党组织<label field="PARTY_RELATION_TYPE4"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','行业党组织')" style="cursor: hand; color: blue"></label>个</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">联合支部<label field="PARTY_TYPE5"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','联合支部')" style="cursor: hand; color: blue"></label>个</td>
		<td class="FieldInput" width="25%">其他党组织<label field="PARTY_RELATION_TYPE5"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','其他党组织')" style="cursor: hand; color: blue"></label>个</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">其他形式<label field="PARTY_TYPE6"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','其他形式党组织隶属关系')" style="cursor: hand; color: blue"></label>个</td>
		<td class="FieldInput" width="25%"></td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%" rowspan="6">党组织活动场所</td>
		<td class="FieldInput" width="25%">单独设立<label field="PARTY_SPACE1"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','单独设立')" style="cursor: hand; color: blue"></label>个</td>
		<td class="FieldInput" width="25%" rowspan="6">年度活动经费</td>
		<td class="FieldInput" width="25%">总额：<label field="PARTY_ACTIVITY_MON"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','总额')" style="cursor: hand; color: blue"></label>元</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">办公场所合用<label field="PARTY_SPACE2"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','办公场所合用')" style="cursor: hand; color: blue"></label>个</td>
		<td class="FieldInput" width="25%">党费：<label field="PARTY_DUES_MON"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','党费')" style="cursor: hand; color: blue"></label>元</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">与社区组织活动场所共用<label field="PARTY_SPACE3"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','与社区组织活动场所共用')" style="cursor: hand; color: blue"></label>个</td>
		<td class="FieldInput" width="25%">上级党组织支持：<label field="PARTY_SUPPORT_MON"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','上级党组织支持')" style="cursor: hand; color: blue"></label>元</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">其他<label field="PARTY_SPACE4"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','其他党组织活动场所')" style="cursor: hand; color: blue"></label>个</td>
		<td class="FieldInput" width="25%">业务经费：<label field="PARTY_BUSINESS_MON"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','业务经费')" style="cursor: hand; color: blue"></label>元</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">无场所<label field="PARTY_SPACE5"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','无场所')" style="cursor: hand; color: blue"></label>个</td>
		<td class="FieldInput" width="25%">财政支持：<label field="PARTY_FINANCE_MON"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','财政支持')" style="cursor: hand; color: blue"></label>元</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%"></td>
		<td class="FieldInput" width="25%">其他形式：<label field="PARTY_OTHER_MON"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','其他形式活动经费')" style="cursor: hand; color: blue"></label>元</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%" rowspan="4">党组织负责人</td>
		<td class="FieldInput" width="25%" rowspan="2">担任社会组织主要负责人<label field="PARTY_PEOPLE_TYPE1"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','担任社会组织主要负责人')" style="cursor: hand; color: blue"></label>个</td>
		<td class="FieldInput" width="25%">35岁以下<label field="PARTY_PEOPLE_AGE1"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','35岁以下')" style="cursor: hand; color: blue"></label>人</td>
		<td class="FieldInput" width="25%">留学归国人员<label field="PARTY_PEOPLE_EDU4"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','留学归国人员')" style="cursor: hand; color: blue"></label>人</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">36—50岁<label field="PARTY_PEOPLE_AGE2"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','36—50岁')" style="cursor: hand; color: blue"></label>人</td>
		<td class="FieldInput" width="25%">硕士及以上<label field="PARTY_PEOPLE_EDU3"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','硕士及以上')" style="cursor: hand; color: blue"></label>人</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">担任专职党务干部<label field="PARTY_PEOPLE_TYPE2"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','担任专职党务干部')" style="cursor: hand; color: blue"></label>个</td>
		<td class="FieldInput" width="25%">51-60岁<label field="PARTY_PEOPLE_AGE3"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','51-60岁')" style="cursor: hand; color: blue"></label>人</td>
		<td class="FieldInput" width="25%">本科或专科<label field="PARTY_PEOPLE_EDU2"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','本科或专科')" style="cursor: hand; color: blue"></label>人</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">其他人员<label field="PARTY_PEOPLE_TYPE3"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','其他人员')" style="cursor: hand; color: blue"></label>个</td>
		<td class="FieldInput" width="25%">60岁以上<label field="PARTY_PEOPLE_AGE4"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','60岁以上')" style="cursor: hand; color: blue"></label>人</td>
		<td class="FieldInput" width="25%">中专及以下<label field="PARTY_PEOPLE_EDU1"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','中专及以下')" style="cursor: hand; color: blue"></label>人</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%" rowspan="6">党员情况</td>
		<td class="FieldInput" width="25%">总数<label field="PARTY_MEMBER_TOTAL"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','总数')" style="cursor: hand; color: blue"></label>人</td>
		<td class="FieldInput" width="25%">35岁以下<label field="PARTY_UNDER_THIRTY_FIVE_NUM"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','35岁以下')" style="cursor: hand; color: blue"></label>人</td>
		<td class="FieldInput" width="25%">留学归国人员<label field="PARTY_ABROAD_NUM"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','留学归国人员')" style="cursor: hand; color: blue"></label>人</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">领导班子中党员<label field="LEGAL_PARTY_NUM"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','领导班子中党员')" style="cursor: hand; color: blue"></label>人</td>
		<td class="FieldInput" width="25%">36—50岁<label field="PARTY_ABOVE_THIRTY_FIVE_NUM"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','36—50岁')" style="cursor: hand; color: blue"></label>人</td>
		<td class="FieldInput" width="25%">硕士及以上<label field="PARTY_MASTER_NUM"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','硕士及以上')" style="cursor: hand; color: blue"></label>人</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">从业人员中党员<label field="PARTY_PRACTITIONER_NUM"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','从业人员中党员')" style="cursor: hand; color: blue"></label>人</td>
		<td class="FieldInput" width="25%">51-60岁<label field="PARTY_UNDER_SIXTY_NUM"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','51-60岁')" style="cursor: hand; color: blue"></label>人</td>
		<td class="FieldInput" width="25%">本科或专科<label field="PARTY_BACHELOR_NUM"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','本科或专科')" style="cursor: hand; color: blue"></label>人</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">专职人员中党员<label field="PARTY_FULL_TIME_NUM"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','专职人员中党员')" style="cursor: hand; color: blue"></label>人</td>
		<td class="FieldInput" width="25%">60岁以上<label field="PARTY_ABOVE_SIXTY_NUM"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','60岁以上')" style="cursor: hand; color: blue"></label>人</td>
		<td class="FieldInput" width="25%">中专及以下<label field="PARTY_SENIOR_NUM"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','中专及以下')" style="cursor: hand; color: blue"></label>人</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">本年度发展新党员<label field="NEW_PARTY_PEOPLE_NUM"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','本年度发展新党员')" style="cursor: hand; color: blue"></label>人</td>
		<td class="FieldInput" width="25%"> </td>
		<td class="FieldInput" width="25%"> </td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">离退休党员<label field="PARTY_RETIRE_NUM"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','离退休党员')" style="cursor: hand; color: blue"></label>人</td>
		<td class="FieldInput" width="25%"> </td>
		<td class="FieldInput" width="25%"> </td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%" rowspan="6">党员学习教育方式</td>
		<td class="FieldInput" width="25%">个人自学<label field="PARTY_STUDY_WAY_SELF1"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','个人自学')" style="cursor: hand; color: blue"></label>个</td>
		<td class="FieldInput" width="25%" rowspan="6">党员组织隶属关系</td>
		<td class="FieldInput" width="25%">社会组织党组织<label field="PARTY_PARTY_NUM"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','社会组织党组织')" style="cursor: hand; color: blue"></label>人</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">支部学习讨论<label field="PARTY_STUDY_WAY_TALK1"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','支部学习讨论')" style="cursor: hand; color: blue"></label>个</td>
		<td class="FieldInput" width="25%">业务主管单位党组织<label field="PARTY_BORG_NUM"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','业务主管单位党组织')" style="cursor: hand; color: blue"></label>人</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">听辅导报告或专题讲座<label field="PARTY_STUDY_WAY_CHAIR1"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','听辅导报告或专题讲座')" style="cursor: hand; color: blue"></label>个</td>
		<td class="FieldInput" width="25%">挂靠单位党组织<label field="PARTY_LINKED_NUM"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','挂靠单位党组织')" style="cursor: hand; color: blue"></label>人</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">外出交流参观<label field="PARTY_STUDY_WAY_VISIT1"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','外出交流参观')" style="cursor: hand; color: blue"></label>个</td>
		<td class="FieldInput" width="25%">属地党组织<label field="PARTY_COLONY_NUM"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','属地党组织')" style="cursor: hand; color: blue"></label>人</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">组织文艺活动<label field="PARTY_STUDY_WAY_ART1"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','组织文艺活动')" style="cursor: hand; color: blue"></label>个</td>
		<td class="FieldInput" width="25%">原工作单位党组织<label field="PARTY_WORK_SPACE_NUM"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','原工作单位党组织')" style="cursor: hand; color: blue"></label>人</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">其他形式<label field="PARTY_STUDY_WAY_OTHER1"
		 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','党员学习教育方式其他形式')" 	style="cursor: hand; color: blue"></label>个</td>
		<td class="FieldInput" width="25%">其他党组织<label field="PARTY_OTHER_SUBJECTION_NUM"
		 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','其他党组织')" 	style="cursor: hand; color: blue"></label>人</td>
	</tr>
	<tr>
		<td  width="25%" align="center" colspan="4" style='font-size: 11.0pt; font-family: 黑体; mso-hansi-font-family: 宋体;'>
			本年度共开展党员活动<label field="PARTY_ACTIVITY_NUM"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','本年度共开展党员活动')" style="cursor: hand; color: blue"></label>
			次，为群众办实事、办好事<label field="ACTIVITY_GOOD_NUM"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','为群众办实事、办好事')"
			style="cursor: hand; color: blue"></label> 件。</td>
	</tr>
	<tr>
		<td  width="25%" align="center" colspan="4" style='font-size: 11.0pt; font-family: 黑体; mso-hansi-font-family: 宋体;'>
			未建党组织的社会组织<label field="IF_BUILD_PARTY0"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','未建党组织的社会组织')"
			style="cursor: hand; color: blue"></label>
			个，党建指导员<label field="IF_PARTY_OFFICER1"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','党建指导员')" style="cursor: hand; color: blue"></label> 人。</td>
	</tr>
	<tr>
		<td  width="25%" align="center" colspan="4" style='font-size: 11.0pt; font-family: 黑体; mso-hansi-font-family: 宋体;'>
			应建未建<label field="NO_BUILD_PARTY_RESON1"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','应建未建')"
			style="cursor: hand; color: blue"></label>
			 个，有党员但不符合建立党组织条件<label field="NO_BUILD_PARTY_RESON2"
			  onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','有党员但不符合建立党组织条件')"
			  style="cursor: hand; color: blue"></label> 个，
			无党员<label field="NO_BUILD_PARTY_RESON3"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','无党员')"
			style="cursor: hand; color: blue"></label> 个。
			</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%" rowspan="4">党员情况</td>
		<td class="FieldInput" width="25%">从业人员中党员<label field="PARTY_PRACTITIONER_NUM_A"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','从业人员中党员')" style="cursor: hand; color: blue"></label>人</td>
		<td class="FieldInput" width="25%">35岁以下<label field="PARTY_UNDER_THIRTY_FIVE_NUM_A"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','35岁以下')" style="cursor: hand; color: blue"></label>人</td>
		<td class="FieldInput" width="25%">留学归国人员<label field="PARTY_ABROAD_NUM_A"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','留学归国人员')" style="cursor: hand; color: blue"></label>人</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">专职人员中党员<label field="PARTY_FULL_TIME_NUM_A"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','专职人员中党员')" style="cursor: hand; color: blue"></label>人</td>
		<td class="FieldInput" width="25%">36—50岁<label field="PARTY_ABOVE_THIRTY_FIVE_NUM_A"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','36—50岁')" style="cursor: hand; color: blue"></label>人</td>
		<td class="FieldInput" width="25%">硕士及以上<label field="PARTY_MASTER_NUM_A"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','硕士及以上')" style="cursor: hand; color: blue"></label>人</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">离退休党员<label field="PARTY_RETIRE_NUM_A"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','离退休党员')" style="cursor: hand; color: blue"></label>人</td>
		<td class="FieldInput" width="25%">51-60岁<label field="PARTY_UNDER_SIXTY_NUM_A"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','51-60岁')" style="cursor: hand; color: blue"></label>人</td>
		<td class="FieldInput" width="25%">本科或专科<label field="PARTY_BACHELOR_NUM_A"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','本科或专科')" style="cursor: hand; color: blue"></label>人</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">本年度发展新党员<label field="NEW_PARTY_PEOPLE_NUM_A"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','本年度发展新党员')" style="cursor: hand; color: blue"></label>人</td>
		<td class="FieldInput" width="25%">60岁以上<label field="PARTY_ABOVE_SIXTY_NUM_A"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','60岁以上')" style="cursor: hand; color: blue"></label>人</td>
		<td class="FieldInput" width="25%">中专及以下<label field="PARTY_SENIOR_NUM_A"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','中专及以下')" style="cursor: hand; color: blue"></label>人</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%" rowspan="5">党员组织隶属关系</td>
		<td class="FieldInput" width="25%" colspan="3">业务主管单位党组织<label field="PARTY_BORG_NUM_A"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','业务主管单位党组织')" style="cursor: hand; color: blue"></label>人</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%" colspan="3">挂靠单位党组织<label field="PARTY_LINKED_NUM_A"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','挂靠单位党组织')" style="cursor: hand; color: blue"></label>人</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%" colspan="3">属地党组织<label field="PARTY_COLONY_NUM_A"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','属地党组织')" style="cursor: hand; color: blue"></label>人</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%" colspan="3">原工作单位党组织<label field="PARTY_WORK_SPACE_NUM_A"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','原工作单位党组织')" style="cursor: hand; color: blue"></label>人</td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%" colspan="3">其他党组织<label field="PARTY_OTHER_SUBJECTION_NUM_A"
			 onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_PARTY','党员组织隶属关系为其他党组织')" style="cursor: hand; color: blue"></label>人</td>
	</tr>
</table>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal align="center"><span style='font-size: 13.0pt; font-family: 黑体; mso-hansi-font-family: 宋体;'>
	（五）财务情况</span></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<table width="650">
	<tr>
		<td class="FieldInput" width="25%">上年度净资产合计（元）</td>
		<td class="FieldInput" width="25%" colspan="3"><label
			field="LAST_TOTAL" onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_FINANCE','上年度净资产合计（元）')" style="cursor:hand;color:blue"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">本年度收入合计（元）</td>
		<td class="FieldInput" width="25%" colspan="3"><label
			field="EARNING_TOTAL" onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_FINANCE','本年度收入合计（元）')" style="cursor:hand;color:blue"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">本年度收入中提供服务收入（元）</td>
		<td class="FieldInput" width="25%"><label
			field="SERVICE_EARNING"></label></td>
		<td class="FieldInput" width="25%">本年度收入中政府购买服务收入（元）</td>
		<td class="FieldInput" width="25%"><label
			field="ORGAN_EARNING"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">接受社会捐赠（元）</td>
		<td class="FieldInput" width="25%"><label
			field="ACCEPT_EARNING"></label></td>
		<td class="FieldInput" width="25%">政府补助收入（元）</td>
		<td class="FieldInput" width="25%"><label
			field="ASSISTANCE_EARNING"></label></td>
	</tr>
	<tr>

		<td class="FieldInput" width="25%">其他收入（元）</td>
		<td class="FieldInput" width="25%" colspan="3"><label
			field="OTHER_EARNING"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">本年度费用合计（元）</td>
		<td class="FieldInput" width="25%"  colspan="3"><label
			field="CHARGE_TOTAL" onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_FINANCE','本年度费用合计（元）')" style="cursor:hand;color:blue"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">业务活动成本（元）</td>
		<td class="FieldInput" width="25%"><label
			field="APPLY_CHARGE"></label></td>
		<td class="FieldInput" width="25%">公益事业支出（元）</td>
		<td class="FieldInput" width="25%"><label
			field="COMWEAL_CHARGE"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">管理费用（元）</td>
		<td class="FieldInput" width="25%"><label
			field="MANAGE_CHARGE"></label></td>
		<td class="FieldInput" width="25%">管理费用中工资福利（元）</td>
		<td class="FieldInput" width="25%"><label
			field="PAY_CHARGE"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">管理费用中办公开支（元）</td>
		<td class="FieldInput" width="25%" colspan="3"><label
			field="OFFICE_CHARGE"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">其它费用（元）</td>
		<td class="FieldInput" width="25%" colspan="3"><label
			field="MANAGE_OTHER_CHARGE"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">本年度净资产合计（元）</td>
		<td class="FieldInput" width="25%" colspan="3"><label
			field="NET_TOTAL" onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_FINANCE','本年度净资产合计（元）')" style="cursor:hand;color:blue"></label></td>

	</tr>
	<tr>
		<td class="FieldInput" width="25%">年度缴税总额（元）</td>
		<td class="FieldInput" width="25%"><label
			field="TAX_TOTAL" onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_FINANCE','年度缴税总额（元）')" style="cursor:hand;color:blue"></label></td>
		<td class="FieldInput" width="25%">其中缴营业税（元）</td>
		<td class="FieldInput" width="25%"><label
			field="SALES_TAX"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">其中缴所得税（元）</td>
		<td class="FieldInput" width="25%"><label
			field="INCOME_TAX"></label></td>
		<td class="FieldInput" width="25%">缴其他税费（元）</td>
		<td class="FieldInput" width="25%"><label
			field="OTHER_TAX"></label></td>
	</tr>
</table>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal align="center"><span style='font-size: 13.0pt; font-family: 黑体; mso-hansi-font-family: 宋体;'>
	（六）资产负债表</span></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<table width="650">
	<tr>
		<td class="FieldInput" width="25%">货币资金年初数（元）</td>
		<td class="FieldInput" width="25%"><label
			field="CA_MONEYFUNDS_S"></label></td>
		<td class="FieldInput" width="25%">货币资金期末数（元）</td>
		<td class="FieldInput" width="25%"><label
			field="CA_MONEYFUNDS_E"  onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_BALANCE_SHEET','货币资金期末数（元）')" style="cursor:hand;color:blue"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">流动资产合计年初数（元）</td>
		<td class="FieldInput" width="25%"><label
			field="CA_SUM_S"></label></td>
		<td class="FieldInput" width="25%">流动资产合计期末数（元）</td>
		<td class="FieldInput" width="25%"><label
			field="CA_SUM_E" onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_BALANCE_SHEET','流动资产合计期末数（元）')" style="cursor:hand;color:blue"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">固定资产原价年初数（元）</td>
		<td class="FieldInput" width="25%"><label
			field="FA_PRIME_COST_S"></label></td>
		<td class="FieldInput" width="25%">固定资产原价期末数（元）</td>
		<td class="FieldInput" width="25%"><label
			field="FA_PRIME_COST_E" onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_BALANCE_SHEET','固定资产原价期末数（元）')" style="cursor:hand;color:blue"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">累计折旧年初数（元）</td>
		<td class="FieldInput" width="25%"><label
			field="FA_ACCUMULATED_DEPRECIATION_S"></label></td>
		<td class="FieldInput" width="25%">累计折旧期末数（元）</td>
		<td class="FieldInput" width="25%"><label
			field="FA_ACCUMULATED_DEPRECIATION_E" onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_BALANCE_SHEET','累计折旧期末数（元）')" style="cursor:hand;color:blue"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">固定资产合计年初数（元）</td>
		<td class="FieldInput" width="25%"><label
			field="FA_SUM_S"></label></td>
		<td class="FieldInput" width="25%">固定资产合计期末数（元）</td>
		<td class="FieldInput" width="25%"><label
			field="FA_SUM_E" onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_BALANCE_SHEET','固定资产合计期末数（元）')" style="cursor:hand;color:blue"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">资产总计年初数（元）</td>
		<td class="FieldInput" width="25%"><label
			field="ASSETS_SUM_S"></label></td>
		<td class="FieldInput" width="25%">资产总计期末数（元）</td>
		<td class="FieldInput" width="25%"><label
			field="ASSETS_SUM_E" onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_BALANCE_SHEET','资产总计期末数（元）')" style="cursor:hand;color:blue"></label></td>
	</tr>
	<tr>
		<td class="FieldInput" width="25%">净资产合计年初数（元）</td>
		<td class="FieldInput" width="25%"><label
			field="NET_ASSETS_SUM_S"></label></td>
		<td class="FieldInput" width="25%">净资产合计期末数（元）</td>
		<td class="FieldInput" width="25%"><label
			field="NET_ASSETS_SUM_E" onclick="showWin(this.innerHTML,this.field,'SOM_JX_CHECK_BALANCE_SHEET','净资产合计期末数（元）')" style="cursor:hand;color:blue"></label></td>
	</tr>
</table>
</form>
</div>
</next:Html>
</next:Panel>
<next:Window id="baseShowList"  closable="close" title="基本情况列表" width="580" height="300" autoScroll="true" modal="true">
	<next:EditGridPanel id="baseShowListGrid" width="98%" stripeRows="true" height="88%" dataset="baseInfoDs">
		<next:TopBar>
			<next:ToolBarItem  symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="detail" text="导出为EXCEL" handler="exportExcel"></next:ToolBarItem>
			<next:ToolBarItem iconCls="return" text="关闭" handler="closeBaseWin"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn />
			<next:Column header="登记证号" width="20%" field="SORG_CODE" editable="false"><next:TextField /></next:Column>
			<next:Column header="社会会组织名称" width="20%" field="CN_NAME" editable="false"><next:TextField /></next:Column>
		</next:Columns>
		<next:BottomBar>
		<next:PagingToolBar dataset="baseInfoDs"/>
	</next:BottomBar>
	</next:EditGridPanel>
</next:Window>
<!-- 基本情况列表 -->
<next:Window id="showList"  closable="close" title="基本情况列表" width="580" height="300" modal="true">
	<next:EditGridPanel id="showListGrid" width="98%" stripeRows="true" height="88%" dataset="detailDs" >
		<next:TopBar>
			<next:ToolBarItem  symbol="->"></next:ToolBarItem>
			<next:ToolBarItem  iconCls="detail"  text="导出为EXCEL" handler="exportDetailExcel"></next:ToolBarItem>
			<next:ToolBarItem iconCls="return" text="关闭" handler="closeWin"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn />
			<next:Column header="登记证号" width="15%" field="SORG_CODE" editable="false"><next:TextField /></next:Column>
			<next:Column header="社会会组织名称" width="20%" field="CN_NAME" editable="false"><next:TextField /></next:Column>
			<next:Column header="项目名称" width="20%" field="field" editable="false" sortable="true" ><next:TextField /></next:Column>
		</next:Columns>
		<next:BottomBar>
		<next:PagingToolBar dataset="detailDs"/>
	</next:BottomBar>
	</next:EditGridPanel>
</next:Window>
</body>
</html>
