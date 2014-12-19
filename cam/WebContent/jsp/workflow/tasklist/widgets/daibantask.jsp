<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>Customers</title>
		<next:ScriptManager/>
</STYLE>
<script type="text/javascript">
function init(){
	var defaultSubjectDaiBanDataset=L5.DatasetMgr.lookup("defaultSubjectDaiBanDataset");
	var leng=defaultSubjectDaiBanDataset.getTotalCount();
	if(leng>10){
		document.getElementById("gengduo").style.display="";
	}
}
var tpl1=new L5.XTemplate(
	'<table width="100%" cellspacing="0" cellpadding="0" align="center" id="t2">',
		'<tr>',
			'<td align="center"><table width="100%"  border="0" cellpadding="0" cellspacing="0"  bgcolor="#FFFFFF">',
			'<tr valign="top">',			     
			'<td align="center">',
			'<tpl for=".">',
			'<tpl if="[xindex]<11">',
			'<table width="100%" border="0" cellpadding="0" cellspacing="0">', 
				'<tr>',
				'<td width="1%">',
				'</td>',			          
				'<td width="50%"><table width="100%" cellpadding="0" cellspacing="0">',
				'<tr >',
				'<td width="3%" valign="middle">&nbsp;<img src="<%=request.getContextPath()%>/jsp/portal/images/cirbutton.gif" width="5" height="9" align="middle">&nbsp;</td>',
				'<td width="50%"> <span id="{assignmentId}" class="tb" dir="ltr" style="cursor:pointer;color:blue" onclick="daibandetail(this)" ><a title="{subject}">{subject}</a></span></td>',
				'<td width="50%"><span id="{assignmentId}" class="tb" dir="ltr"   >{procCreateTime}</span></td>',
				'</tr>',
				  '</table>',
			       '</td>',
			     '</tr>',
				 '<tr>',
					'<table width="100%" align="center" border="0" cellspacing="0" cellpadding="0">',
		             '<tr>',
		             '<td background="<%=request.getContextPath()%>/jsp/portal/images/line.jpg"><img src="<%=request.getContextPath()%>/jsp/portal/images/line.jpg" width="7" height="5"></td>',
		              '</tr>',
		             '</table>',
				'</tr>',
		     '</table>',
				  
			'</tpl>',
		    '</tpl>',
		    '</td>',
			'</tr>',
		  '</table>',
		  '</td>',
		'</tr>',
	'</table>'
);	
tpl1.compile();

//查看某条待办任务
function daibandetail(ele) {
	var url="command/dispatcher/org.loushang.workflow.tasklist.forward.TaskListDispatcherCmd/daiBanTaskForward";
	var query="?assignmentId="+ele.id;
	parent.L5.detailContent(url+query,"待办任务详细信息");
}
//更多待办任务
function gengduodaiban(){
	parent.L5.detailContent("/jsp/workflow/tasklist/querydaiban.jsp","待办任务列表");
}
	
</script>
		<model:datasets>
		<model:dataset id="defaultSubjectDaiBanDataset"	cmd="org.loushang.workflow.tasklist.taskinfo.cmd.DaiBanTaskQueryCmd" method="queryDaiBanTaskPortalInfo" autoLoad="true" global="true">
			<model:record >
				<model:field name="assignmentId" type="string" />
				<model:field name="subject" type="string" />
				<model:field name="procDefName" type="string" />	
				<model:field name="procCreateTime" type="string" />
			</model:record>
			</model:dataset>
		</model:datasets>
	</head>
<body >
<FORM id=form1 method=post name=form1 action=CautionLightPlus.aspx?RegionCode=370100>

		<next:ViewPort>
			<next:Panel border="false" id="daiban" >
				<next:DataView autoHeight="true" itemSelector="table.item" dataset="defaultSubjectDaiBanDataset" tpl="tpl1"/>
			
			<next:Html>
					<div id="gengduo" style="display:none"><a onclick="gengduodaiban()" style="cursor:pointer"><p align="right"><font size="2" color="blue">更多&gt;&gt;</font></p></a></div>
			</next:Html>
			</next:Panel>
		</next:ViewPort>

</FORM>
</body>

</html>