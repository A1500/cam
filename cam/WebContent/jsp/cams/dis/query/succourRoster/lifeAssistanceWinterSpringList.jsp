<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%
	response.setHeader("Expires", "Sat, 6 May 1995 12:00:00 GMT");  
	response.setHeader("Cache-Control", "no-store,no-cache,must-revalidate");  
	response.addHeader("Cache-Control", "post-check=0, pre-check=0");  
	response.setHeader("Pragma", "no-cache");  
	
	/*是否可以编辑：true 不能编辑； false 可以编辑*/
	String isupdate = request.getParameter("isupdate");
	if(isupdate == null) {
		isupdate = "true";
	}
%>
<html>
	<head>
		<title>冬春生活救助</title>
		<next:ScriptManager/>
		<script language="javascript">
   			var userOrganCode = '<%=BspUtil.getOrganCode()%>';
		 	 //查询条件打开合并函数
			 function collapse(element){
				var fieldsetParent=L5.get(element).findParent("fieldset");
				if(element.expand==null||element.expand==true){
					fieldsetParent.getElementsByTagName("div")[0].style.display="none";
					element.src = '<%=SkinUtils.getImage(request, "groupbox_expand.gif")%>';
					element.expand=false;
				}else{
					fieldsetParent.getElementsByTagName("div")[0].style.display="";
					element.src = "<%=SkinUtils.getImage(request, "groupbox_collapse.gif")%>";
					element.expand =true;
				}
			}
			 var organCode = '<%=BspUtil.getOrganCode()%>';
			 var organName = '<%=BspUtil.getOrganName()%>';
			 var struId='<%=BspUtil.getStruId()%>';
             var organType='<%=BspUtil.getOrganType()%>';
             var batchDetailId='<%=request.getParameter("batchDetailId")%>';
		</script>
		<script type="text/javascript" src="<%=SkinUtils.getJS(request, "cams.js")%>"></script>
		<script type="text/javascript" src="<%=SkinUtils.getJS(request, "camsCheck.js")%>"></script>
		<script type="text/javascript" src="<%=SkinUtils.getJS(request, "ISPrint.js") %>"></script>
		<script type="text/javascript" src="lifeAssistanceWinterSpringList.js"></script>	
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.dis.base.cmd.AssistanceQueryCommand" method="queryAssistance" global="true" pageSize="15">
		<model:record>
			<model:field name="INFO_ID" type="string" />
			<model:field name="RECORD_ID" type="string" />
			<model:field name="CHECK_ORGAN_NAME" type="string" /><!-- 乡镇（街道） -->
			<model:field name="CHECK_ORGAN_CODE" type="string" /><!-- 乡镇（街道） -->
			<model:field name="NAME" type="string" /><!-- 户主姓名 -->
			<model:field name="FAMILY_NUM" type="string" /><!-- 家庭人口 -->
			<model:field name="APPROVAL_TIMES" type="string" /><!-- 核准救助时段 -->
			<model:field name="APPROVAL_MONRY" type="string" /><!-- 核准救助金额 -->
			<model:field name="APPROVAL_FOOD" type="string" /><!-- 核准救助口粮 -->
			<model:field name="ACCEPT_DATE" type="string" /><!-- 填报日期 -->
			<model:field name="NOTE" type="string" /><!-- 备注 -->
			<model:field name="WORKFLOW_STATUS" type="string" /><!-- 流程跳转状态 -->
			<model:field type="string" name="areaName"/><!-- 行政区划名字供显示用 -->
			<model:field name="ID_CARD" type="string"/><!-- 身份证号码 -->
		</model:record>
	</model:dataset>
	<!-- 打印用 -->
	<model:dataset id="printDs" cmd="com.inspur.cams.dis.base.cmd.AssistanceQueryCommand" method="queryAssistance" global="true" >
		<model:record>
			<model:field name="INFO_ID" type="string" />
			<model:field name="RECORD_ID" type="string" />
			<model:field name="CHECK_ORGAN_NAME" type="string" /><!-- 乡镇（街道） -->
			<model:field name="CHECK_ORGAN_CODE" type="string" /><!-- 乡镇（街道） -->
			<model:field name="NAME" type="string" /><!-- 户主姓名 -->
			<model:field name="FAMILY_NUM" type="string" /><!-- 家庭人口 -->
			<model:field name="APPROVAL_TIMES" type="string" /><!-- 核准救助时段 -->
			<model:field name="APPROVAL_MONRY" type="string" /><!-- 核准救助金额 -->
			<model:field name="APPROVAL_FOOD" type="string" /><!-- 核准救助口粮 -->
			<model:field name="ACCEPT_DATE" type="string" /><!-- 填报日期 -->
			<model:field name="NOTE" type="string" /><!-- 备注 -->
			<model:field name="WORKFLOW_STATUS" type="string" /><!-- 流程跳转状态 -->
			<model:field type="string" name="areaName"/><!-- 行政区划名字供显示用 -->
			<model:field name="ID_CARD" type="string"/><!-- 身份证号码 -->
		</model:record>
	</model:dataset>
	<!-- 提交状态 -->
	<model:dataset id="ReliefinfoWorkflowState" enumName="DIS.RELIEFINFO_WORKFLOW_STATE" autoLoad="true" global="true">
	</model:dataset>
</model:datasets>

<next:GridPanel id="lifeAssistanceWinterSpringGrid" name="lifeAssistanceWinterSpringGrid" width="100%" clickToSelectedForChkSM="true" stripeRows="true" height="100%" dataset="ds"
	autoExpandColumn="NOTE" notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem text="“冬春生活救助”名册列表"/>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="明细" iconCls="detail" handler="detail" id="detail"/>
		<next:ToolBarItem text="导出Excel" iconCls="export" handler="exportExcel" id="printPeople"/>
		<next:ToolBarItem text="打印救助卡" iconCls="print" handler="printPeople" id="undo"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="40"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="NAME" header="户主姓名" field="NAME" width="90"></next:Column>
		<next:Column id="ID_CARD" header="身份证号码" field="ID_CARD" width="135"></next:Column>
		<next:Column id="CHECK_ORGAN_NAME" header="乡镇(街道)" field="CHECK_ORGAN_NAME" width="200"></next:Column>
		<next:Column id="FAMILY_NUM" header="家庭人口(人)" field="FAMILY_NUM" width="90" align="right"></next:Column>
		<next:Column id="APPROVAL_TIMES" header="核准救助时段" field="APPROVAL_TIMES" width="90" align="center"></next:Column>
		<next:Column id="APPROVAL_MONRY" header="核准救助金额(元)" field="APPROVAL_MONRY" width="120" align="right" renderer="formatNum"></next:Column>
		<next:Column id="APPROVAL_FOOD" header="核准救助口粮(公斤)" field="APPROVAL_FOOD" width="130" align="right" renderer="formatNum"></next:Column>
		<next:Column id="ACCEPT_DATE" header="填报日期" field="ACCEPT_DATE" width="90"></next:Column>
		<next:Column id="WORKFLOW_STATUS" header="提交状态" field="WORKFLOW_STATUS" width="90" dataset="ReliefinfoWorkflowState"></next:Column>
		<next:Column id="NOTE" header="备注" field="NOTE" width="120"></next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>