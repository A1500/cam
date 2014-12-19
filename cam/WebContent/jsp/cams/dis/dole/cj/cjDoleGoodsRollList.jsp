<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>灾区民房恢复重建</title>
<%
	String ifDetail=request.getParameter("ifDetail");
%>
<next:ScriptManager />
<script language="javascript">
	 var organCode = '<%=BspUtil.getOrganCode()%>';
	 var organName = '<%=BspUtil.getOrganName()%>';
     var organType = '<%=BspUtil.getOrganType()%>';
     var ifFill = '<%=request.getParameter("ifFill")%>';
     var batchId = '<%=request.getParameter("batchId")%>';
     var batchDetailId = '<%=request.getParameter("batchDetailId")%>';
     var doleId = '<%=request.getParameter("doleId")%>';
     var ifDetail = '<%=ifDetail%>';
     
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
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "cams.js")%>"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "camsCheck.js")%>"></script>
<script type="text/javascript" src="../../comm/disComm.js"></script>
<script type="text/javascript" src="cjDoleGoodsRollList.js"></script>
</head>
<body>
<model:datasets>
	<!-- 档案信息 -->
	<model:dataset id="infoDs" cmd="com.inspur.cams.dis.base.cmd.DisReliefInfoQueryCmd"
		global="true" pageSize="15">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisReliefInfo">
		</model:record>
	</model:dataset>
	<model:dataset id="doleDetailDs" cmd="com.inspur.cams.dis.base.cmd.DisReliefDoleDetailQueryCmd"
		global="true" pageSize="100">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisReliefDoleDetail">
		</model:record>
	</model:dataset>
	<!-- 提交状态 -->
	<model:dataset id="ReliefinfoWorkflowState"
		enumName="DIS.RELIEFINFO_WORKFLOW_STATE" autoLoad="true" global="true">
	</model:dataset>
	<!-- 灾害类型 -->
	<model:dataset id="DisDisasterType" enumName="DIS.DISASTER_TYPE"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 家庭类型 -->
	<model:dataset id="DisFamilyType" enumName="DIS.FAMILY_TYPE"
		autoLoad="true" global="true">
	</model:dataset>
</model:datasets>

<next:Panel name="form" width="100%" border="0" autoHeight="true">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox"><legend
			class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton"
			src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>"
			onclick="collapse(this)" /> </legend>
		<div>
		<form style="width: 100%; height: 100%;" class="L5form">
		<table border="1" width="100%">
			<tr>
				<td class="FieldLabel">户主姓名:</td>
				<td class="FieldInput"><input type="text"
					id="qName" class="TextEditor" title="户主姓名" /></td>
				<td class="FieldLabel">行政村（社区）:</td>
				<td class="FieldInput"><input type="text"
					id="qAcceptAreaName" class="TextEditor" title="行政村（社区）"
					style="width: 200" /> <input type="hidden" id="qAcceptAreaCode"
					class="TextEditor" title="行政村（社区）" /> <img
					src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"
					style="cursor: hand" onclick="forOrganSelect()" /></td>
				<td class="FieldLabel" colspan="2">
				<button onclick="query()" id="search">查 询</button>
				&nbsp;&nbsp;
				<button type="reset">重置</button>
				</td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="cjGrid" name="cjGrid" width="100%"
	clickToSelectedForChkSM="true" stripeRows="true" height="100%"
	dataset="infoDs" notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<%if(!"1".equals(ifDetail)){ %>
		<next:ToolBarItem text="确认" iconCls="edit" handler="confirm" />
		<%}else{ %>
		<next:ToolBarItem text="查看" iconCls="detail" handler="detail" />
		<%}%>
		<next:ToolBarItem text="导出Excel" iconCls="export" handler="forExcel"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="40" header="序号" />
		<next:Column id="name" header="户主姓名" field="name" width="90"></next:Column>
		<next:Column id="idCard" header="身份证号码" field="idCard" width="135"></next:Column>
		<next:Column id="familyType" header="家庭类型"
			field="familyType" width="80" dataset="DisFamilyType" align="center"></next:Column>
		
		<next:Column id="disasterType" header="灾害种类"
			field="disasterType" width="120" align="center" dataset="DisDisasterType"></next:Column>
		<next:Column id="collapsedHouse" header="倒塌房屋（间）" field="collapsedHouse"
			width="130" align="right"></next:Column>
		<next:Column id="seriousDamageHouse" header="严重损坏房屋（间）"
			field="seriousDamageHouse" width="130" align="right"></next:Column>
		<next:Column id="approvalRebuiledHouse" header="核准重建间数（间）"
			field="approvalRebuiledHouse" width="130" align="right"></next:Column>
		<next:Column id="approvalMoney" header="核准救助资金（元）"
			field="approvalMoney" width="130" align="right">
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="infoDs" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>