<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>应急生活救助-审核审批</title>
<next:ScriptManager />
<script language="javascript">
	 var organCode = '<%=BspUtil.getOrganCode()%>';
	 var organName = '<%=BspUtil.getOrganName()%>';
     var organType = '<%=BspUtil.getOrganType()%>';
     var ifApprove = '<%=request.getParameter("ifApprove")%>';
     var batchId = '<%=request.getParameter("batchId")%>';
     var batchDetailId = '<%=request.getParameter("batchDetailId")%>';
     
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
</script>
<script type="text/javascript"
	src="<%=SkinUtils.getJS(request, "cams.js")%>"></script>
<script type="text/javascript"
	src="<%=SkinUtils.getJS(request, "camsCheck.js")%>"></script>
<script type="text/javascript" src="../../comm/disComm.js"></script>
<script type="text/javascript" src="yjApproveList.js"></script>
</head>
<body>
<model:datasets>
	<!-- 档案信息 -->
	<model:dataset id="infoDs"
		cmd="com.inspur.cams.dis.base.cmd.DisReliefInfoQueryCmd" global="true"
		pageSize="15">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisReliefInfo">
		</model:record>
	</model:dataset>
	<!-- 提交状态 -->
	<model:dataset id="ReliefinfoWorkflowState"
		enumName="DIS.RELIEFINFO_WORKFLOW_STATE" autoLoad="true" global="true">
	</model:dataset>
	<!-- 户口类型 -->
	<model:dataset id="DisFamilyRegister" enumName="DIS.FAMILY_REGISTER"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 家庭类型 -->
	<model:dataset id="DisFamilyType" enumName="DIS.FAMILY_TYPE"
		autoLoad="true" global="true">
	</model:dataset>
</model:datasets>
<next:ViewPort>
	<next:Panel>
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem text="同意" iconCls="yes" handler="agree" id="btnAgree"/>
			<next:ToolBarItem text="驳回" iconCls="no" handler="reject" id="btnBack"/>
			<next:ToolBarItem text="关闭" iconCls="return" handler="back"/>
		</next:TopBar>
		<next:TabPanel>
			<next:Tabs>
				<next:Panel title="分析汇总" width="100%" height="100%">
					<next:Html>
						<iframe id="yjSumList" name="yjSumList"
							src='yjApproveSumList.jsp?batchId=<%=request.getParameter("batchId")%>&batchDetailId=<%=request.getParameter("batchDetailId")%>&ifApprove=<%=request.getParameter("ifApprove")%>'
							frameborder="no" border="0" marginwidth="0" marginheight="0"
							scrolling="no" allowtransparency="yes" width="100%" height="100%">
						</iframe>
					</next:Html>
				</next:Panel>
			</next:Tabs>
			<next:Tabs>
				<next:Panel title="明细信息" width="100%" height="100%">
					<next:Html>
						<iframe id="yjDetailList" name="yjDetailList"
							src='yjList.jsp?batchId=<%=request.getParameter("batchId")%>&batchDetailId=<%=request.getParameter("batchDetailId")%>'
							frameborder="no" border="0" marginwidth="0" marginheight="0"
							scrolling="no" allowtransparency="yes" width="100%" height="100%">
						</iframe>
					</next:Html>
				</next:Panel>
			</next:Tabs>
			<next:Tabs>
				<next:Panel title="审批流程" width="100%" height="100%">
					<next:Html>
						<iframe id="yjWorkFlowList" name="yjWorkFlowList"
							src='yjWorkFlow.jsp?batchId=<%=request.getParameter("batchId")%>&batchDetailId=<%=request.getParameter("batchDetailId")%>'
							frameborder="no" border="0" marginwidth="0" marginheight="0"
							scrolling="no" allowtransparency="yes" width="100%" height="100%">
						</iframe>
					</next:Html>
				</next:Panel>
			</next:Tabs>
		</next:TabPanel>
	</next:Panel>
</next:ViewPort>
</body>
</html>

<!-- 审批窗口 -->
<next:Window id="approveWin" closeAction="hide" title="审批窗口" height="250"
	width="666" modal="true" resizable="false">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="yes" id="btnConfirmAgree" text="确认同意" handler="confirmAgree"></next:ToolBarItem>
		<next:ToolBarItem iconCls="yes" id="btnConfirmBack" text="确认驳回" handler="confirmBack"></next:ToolBarItem>
		<next:ToolBarItem xtype="tbseparator" />
	</next:TopBar>
	<next:Html>
		<form id="form_content" onsubmit="return false" style="padding: 5px;"
			class="L5form">
		<table border="1" width="100%">
			<tr>
				<td class="FieldLabel">审批日期：</td>
				<td class="FieldInput"><input type="text" id="checkDate"
					field="checkDate" name="审批日期" format="Y-m-d"
					style="width: 100px;" maxlength="10"
					onpropertychange="changeDateStyle(this)" /><img
					src="../../../../../skins/images/default/rl.gif" align="middle"
					onclick="getTimes(this);" /><font color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 20%">审批意见</td>
				<td class="FieldInput" style="width: 80%">
					<textarea onpropertychange="if(value.length>199) value=value.substr(0,199)"  
					id="checkOption" rows="10" style="width: 95%"  ></textarea><font color="red">*</font></td>
			</tr>
		</table>
		</form>
	</next:Html>
</next:Window>