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
%>
<html>
	<head>
		<title>灾区民房恢复重建补助</title>
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
		<script type="text/javascript" src="disasterReconstructionSubsidyList.js"></script>	
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.dis.base.cmd.AssistanceQueryCommand" method="queryAssistance" global="true" pageSize="15">
		<model:record>
			<model:field name="INFO_ID" type="string" />
			<model:field name="RECORD_ID" type="string" />
			<model:field name="NAME" type="string" />
			<model:field name="FAMILY_TYPE" type="string" />
			<model:field name="DISASTER_TYPE" type="string" />
			<model:field name="COLLAPSED_HOUSE" type="string" />
			<model:field name="SERIOUS_DAMAGE_HOUSE" type="string" />
			<model:field name="APPROVAL_REBUILED_HOUSE" type="string" />
			<model:field name="APPROVAL_MONRY" type="string" />
			<model:field name="ACCEPT_DATE" type="string" />
			<model:field name="NOTE" type="string" />
			<model:field name="WORKFLOW_STATUS" type="string" /><!-- 流程跳转状态 -->
			<model:field type="string" name="areaName"/><!-- 行政区划名字供显示用 -->
			<model:field name="ID_CARD" type="string"/><!-- 身份证号码 -->
		</model:record>
	</model:dataset>
	<!-- 打印 -->
	<model:dataset id="printDs" cmd="com.inspur.cams.dis.base.cmd.AssistanceQueryCommand" method="queryAssistance" global="true" >
		<model:record>
			<model:field name="INFO_ID" type="string" />
			<model:field name="RECORD_ID" type="string" />
			<model:field name="NAME" type="string" />
			<model:field name="FAMILY_TYPE" type="string" />
			<model:field name="DISASTER_TYPE" type="string" />
			<model:field name="COLLAPSED_HOUSE" type="string" />
			<model:field name="SERIOUS_DAMAGE_HOUSE" type="string" />
			<model:field name="APPROVAL_REBUILED_HOUSE" type="string" />
			<model:field name="APPROVAL_MONRY" type="string" />
			<model:field name="ACCEPT_DATE" type="string" />
			<model:field name="NOTE" type="string" />
			<model:field name="WORKFLOW_STATUS" type="string" /><!-- 流程跳转状态 -->
			<model:field type="string" name="areaName"/><!-- 行政区划名字供显示用 -->
			<model:field name="ID_CARD" type="string"/><!-- 身份证号码 -->
		</model:record>
	</model:dataset>
	<!-- 提交状态 -->
	<model:dataset id="ReliefinfoWorkflowState" enumName="DIS.RELIEFINFO_WORKFLOW_STATE" autoLoad="true" global="true">
	</model:dataset>
	<!-- 家庭类型 -->
	<model:dataset id="DisFamilyType" enumName="DIS.FAMILY_TYPE" autoLoad="true" global="true">
	</model:dataset>
	<!-- 灾害种类 -->
	<model:dataset id="DisDisasterType" enumName="DIS.DISASTER_TYPE" autoLoad="true" global="true">
	</model:dataset>
</model:datasets>
<next:GridPanel id="disasterReconstructionSubsidyGrid" name="disasterReconstructionSubsidyGrid" width="100%" clickToSelectedForChkSM="true" stripeRows="true" height="100%" dataset="ds"
	autoExpandColumn="NOTE" notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem text="“灾区民房恢复重建补助”名册列表"/>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="明细" iconCls="detail" handler="detail" id="detail"/>
		<next:ToolBarItem text="导出Excel" iconCls="export" handler="exportExcel" id="printPeople"/>
		<next:ToolBarItem text="打印救助卡" iconCls="print" handler="printPeople" id="undo"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="40" header="序号"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="NAME" header="户主姓名" field="NAME" width="90"></next:Column>
		<next:Column id="ID_CARD" header="身份证号码" field="ID_CARD" width="135"></next:Column>
		<next:Column id="FAMILY_TYPE" header="家庭类型" field="FAMILY_TYPE" width="90" dataset="DisFamilyType"></next:Column>
		<next:Column id="DISASTER_TYPE" header="灾害种类" field="DISASTER_TYPE" width="90" dataset="DisDisasterType"></next:Column>
		<next:Column id="COLLAPSED_HOUSE" header="倒塌房屋(间)" field="COLLAPSED_HOUSE" width="90"></next:Column>
		<next:Column id="SERIOUS_DAMAGE_HOUSE" header="严重损坏房屋(间)" field="SERIOUS_DAMAGE_HOUSE" width="120"></next:Column>
		<next:Column id="APPROVAL_REBUILED_HOUSE" header="核准重建间数(间)" field="APPROVAL_REBUILED_HOUSE" width="120"></next:Column>
		<next:Column id="APPROVAL_MONRY" header="核准补助资金(元)" field="APPROVAL_MONRY" width="120"></next:Column>
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