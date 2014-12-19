
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
	<head>
		<title>应急生活救助列表</title>
		<next:ScriptManager/>
		<%
			String isupdate = request.getParameter("isupdate");
			if(isupdate == null) {
				isupdate = "true";
			}
		%>
		<script language="javascript">
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
			 var batchDetailId='<%=request.getParameter("batchDetailId")%>';
			 var organCode = '<%=BspUtil.getOrganCode()%>';
		   	 var organName = '<%=BspUtil.getOrganName()%>';
		</script>
		<script type="text/javascript" src="<%=SkinUtils.getJS(request, "cams.js")%>"></script>
		<script type="text/javascript" src="<%=SkinUtils.getJS(request, "camsCheck.js")%>"></script>
		<script type="text/javascript" src="yj_info_list.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.dis.base.cmd.DisReliefInfoQueryCommand" method="queryList" global="true">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisReliefInfo">
			<model:field name="infoId" mapping="INFO_ID" type="string"/>
			<model:field name="batchDetailId" mapping="BATCH_DETAIL_ID" type="string"/>
			<model:field name="familyRecordId" mapping="FAMILY_PID" type="string"/>
			<model:field name="approvalFood" mapping="APPROVAL_FOOD" type="string" />
			<model:field name="approvalClothes" mapping="APPROVAL_CLOTHES" type="string" />
			<model:field name="approvalMonry" mapping="APPROVAL_MONRY" type="string" />
			<model:field name="acceptAreaName" mapping="ACCEPT_AREA_NAME" type="string" />
			<model:field name="acceptPeopleName" mapping="ACCEPT_PEOPLE_NAME" type="string" />
			<model:field name="acceptDate" mapping="ACCEPT_DATE" type="string" />
			<model:field name="checkOrganName" mapping="CHECK_ORGAN_NAME" type="string" />
			<model:field name="checkPeopleName" mapping="CHECK_PEOPLE_NAME" type="string" />
			<model:field name="checkDate" mapping="CHECK_DATE" type="string" />
			<model:field name="auditOrganName" mapping="AUDIT_ORGAN_NAME" type="string" />
			<model:field name="auditPeopleName" mapping="AUDIT_PEOPLE_NAME" type="string" />
			<model:field name="auditDate" mapping="AUDIT_DATE" type="string" />
			<model:field name="grantOrganName" mapping="GRANT_ORGAN_NAME" type="string" />
			<model:field name="grantOrganCode" mapping="GRANT_ORGAN_CODE" type="string" />
			<model:field name="grantPeopleName" mapping="GRANT_PEOPLE_NAME" type="string" />
			<model:field name="grantTime" mapping="GRANT_TIME" type="string" />
			<model:field name="fillTime" mapping="FILL_TIME" type="string" />
			<model:field name="organName" mapping="ORGAN_NAME" type="string" />
			<model:field name="organCode" mapping="ORGAN_CODE" type="string" />
			<model:field name="workflowStatus" mapping="WORKFLOW_STATUS" type="string" />
			<model:field name="approvalFamilyNum" mapping="APPROVAL_FAMILY_NUM" type="string" />
			<model:field name="acceptAreaCode" mapping="ACCEPT_AREA_CODE" type="string" />
			<model:field name="requiredForFood" mapping="REQUIRED_FOR_FOOD" type="string" />
			<model:field name="requiredForClothes" mapping="REQUIRED_FOR_CLOTHES" type="string" />
			<model:field name="requiredForHeat" mapping="REQUIRED_FOR_HEAT" type="string" />
			<model:field name="requiredForDisease" mapping="REQUIRED_FOR_DISEASE" type="string" />
			<model:field name="requiredForOthers" mapping="REQUIRED_FOR_OTHERS" type="string" />
		</model:record>
		<model:params>
			<model:param name="reliefType" value="YJ"></model:param>
			<model:param name="batchDetailId" value='<%=request.getParameter("batchDetailId")%>'></model:param>
		</model:params>
	</model:dataset>
	
	<model:dataset id="workflowStateDs" enumName="DIS.RELIEFINFO_WORKFLOW_STATE" autoLoad="true"
		global="true">
	</model:dataset>
	 
</model:datasets>


<next:GridPanel id="editGridPanel" name="disreliefinfoGrid" width="100%" clickToSelectedForChkSM="true" stripeRows="true" height="100%" dataset="ds" title="">
	<next:TopBar>
		<next:ToolBarItem text="“应急生活救助”列表"/>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="明细" iconCls="detail" handler="detail"/>
		<next:ToolBarItem text="导出Excel" iconCls="export" handler="exportExcel"/>
		<next:ToolBarItem text="打印救助卡" iconCls="print" handler="printPeople" id="undo" hidden="true"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
	
		<next:Column id="acceptAreaName" header="村名称" field="acceptAreaName" width="190" >
			<next:TextField  />
		</next:Column>
		
		<next:Column id="approvalFamilyNum" header="核准救助人口" field="approvalFamilyNum" width="90" align="right" >
			<next:NumberField  />
		</next:Column>
		<next:Column id="approvalFood" header="核准救助粮食(公斤)" field="approvalFood" width="120" align="right" renderer="formatNum">
			<next:TextField  />
		</next:Column>
		<next:Column id="approvalClothes" header="核准救助衣被(件)" field="approvalClothes" width="110" align="right" >
			<next:TextField  />
		</next:Column>
		<next:Column id="approvalMonry" header="核准救助资金(元)" field="approvalMonry" width="110" align="right" renderer="formatNum">
			<next:NumberField  />
		</next:Column>
	
		<next:Column id="requiredForFood" header="需口粮救助(公斤)" field="requiredForFood" width="100" align="right" renderer="formatNum">
			<next:NumberField  />
		</next:Column>
		<next:Column id="requiredForClothes" header="需衣被救助(件)" field="requiredForClothes" width="90" align="right">
			<next:TextField  />
		</next:Column>
		<next:Column id="requiredForHeat" header="需取暖救助(元)" field="requiredForHeat" width="90" align="right" renderer="formatNum">
			<next:TextField  />
		</next:Column>
		<next:Column id="requiredForDisease" header="需伤病救助(元)" field="requiredForDisease" width="90" align="right" renderer="formatNum">
			<next:NumberField  />
		</next:Column>
		<next:Column id="requiredForOthers" header="需其他救助(元)" field="requiredForOthers" width="90" align="right" renderer="formatNum">
			<next:NumberField  />
		</next:Column>
		
		<next:Column id="acceptPeopleName" header="村填报人姓名" field="acceptPeopleName" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="acceptDate" header="村填报日期" field="acceptDate" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="checkOrganName" header="乡镇(街道)名称" field="checkOrganName" width="90" hidden="true" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="checkPeopleName" header="乡镇(街道)审核人名称" field="checkPeopleName" width="90" hidden="true"  >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="checkDate" header="审核日期" field="checkDate" width="90" hidden="true"  >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="auditOrganName" header="县级名称" field="auditOrganName" width="90" hidden="true"  >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="auditPeopleName" header="县级批准人名称" field="auditPeopleName" width="90" hidden="true"  >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="auditDate" header="批准日期" field="auditDate" width="90" hidden="true"  >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="grantOrganName" header="发放单位名称" field="grantOrganName" width="90" hidden="true"  >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="grantOrganCode" header="发放单位区划" field="grantOrganCode" width="90" hidden="true"  >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="grantPeopleName" header="发放人名称" field="grantPeopleName" width="90" hidden="true"  >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="grantTime" header="发放日期" field="grantTime" width="90" hidden="true"  >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="organName" header="填报单位名称" field="organName" width="90" hidden="true"  >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="fillTime" header="填报时间" field="fillTime" width="90"  hidden="true" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="workflowStatus" header="审核状态" field="workflowStatus" dataset="workflowStateDs" width="90" >
			<next:TextField  />
		</next:Column>
	
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
