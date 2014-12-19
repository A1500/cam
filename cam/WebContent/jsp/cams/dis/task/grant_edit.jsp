<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<html>
<head>
<title>发放</title>
<next:ScriptManager />
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="grant_edit.js"></script>
<script language="javascript">
		var batchDetailId='<%=request.getParameter("batchDetailId")%>';
		var reliefType='<%=request.getParameter("reliefType")%>';
		var organCode = '<%=BspUtil.getOrganCode()%>';
		var organType = '<%=BspUtil.getOrganType()%>';
		var organName = '<%=BspUtil.getOrganName()%>';
		var currentUserName = '<%= GetBspInfo.getBspInfo().getUserName()%>';
		var day = '<%= DateUtil.getDay()%>';
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
</head>
<body>
<model:datasets>
	<!-- 获取批次汇总信息 -->
	<model:dataset id="amountds"
		cmd="com.inspur.cams.dis.base.cmd.DisReliefInfoQueryCommand"
		method="queryBatchGatherDate" global="true">
	</model:dataset>
	
	<model:dataset id="grantDs"
		cmd="com.inspur.cams.dis.query.cmd.DisConditionTongJiCmd"
		global="true" autoLoad="false">
		<model:record>
			<model:field name="ORGAN_CODE" type="string" />
			<model:field name="ORGAN_NAME" type="string" />
			<model:field name="DCNUM" type="string" />
			<model:field name="DCFOOD" type="string" />
			<model:field name="DCCLOTHES" type="string" />
			<model:field name="DCMONEY" type="string" />
			<model:field name="SWNUM" type="string" />
			<model:field name="SWMONEY" type="string" />
			<model:field name="YJNUM" type="string" />
			<model:field name="YJFOOD" type="string" />
			<model:field name="YJCLOTHES" type="string" />
			<model:field name="YJMONEY" type="string" />
			<model:field name="GDNUM" type="string" />
			<model:field name="GDFOOD" type="string" />
			<model:field name="GDCLOTHES" type="string" />
			<model:field name="GDMONEY" type="string" />
			<model:field name="CJNUM" type="string" />
			<model:field name="CJRBHOUSE" type="string" />
			<model:field name="CJRPHOUSE" type="string" />
			<model:field name="CJMONEY" type="string" />
		</model:record>
	</model:dataset>

	<model:dataset id="disFundsSourceDs"
		cmd="com.inspur.cams.dis.base.cmd.DisFundsSourceQueryCmd"
		method="queryFundsBalance" global="true" pageAble="false">
	</model:dataset>

	<model:dataset id="batchDetailds"
		cmd="com.inspur.cams.dis.base.cmd.DisReliefBatchDetailQueryCommand"
		method="queryBatchDetail" global="true">
		<model:record
			fromBean="com.inspur.cams.dis.base.data.DisReliefBatchDetail">
		</model:record>
	</model:dataset>
	
	<model:dataset id="ReliefTypeDataset" enumName="DIS.ALLOCATION_PURPOSE"
		autoLoad="true" global="true"></model:dataset>

	<model:dataset id="fillstateDs" enumName="DIS.BATCHDETAIL_FILL_STATE"
		autoLoad="true" global="true">
	</model:dataset>
</model:datasets>

<next:Panel name="form" width="100%" border="0" autoHeight="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem id="grantBtn" text="发放" iconCls="yes" handler="save"/>
	</next:TopBar>
	<next:Html>
		<div>
		<form style="width: 100%; height: 100%;" class="L5form">
		<table border="1" width="100%">
			<tr>
				<td class="FieldLabel">本级可用资金（元）：</td>
				<td class="FieldInput"><label id="useFunds" field="useFunds"/></td>
				<td class="FieldLabel">需发放资金（元）：</td>
				<td class="FieldInput"><label id="funds" field="funds"/></td>
			</tr>
			<tr>
				<td class="FieldLabel">本级可用口粮（公斤）：</td>
				<td class="FieldInput"><label id="useFoods" field="useFoods"/></td>
				<td class="FieldLabel">需发放口粮（公斤）：</td>
				<td class="FieldInput"><label id="foods" field="foods"/></td>
			</tr>
			<tr>
				<td class="FieldLabel">本级可用衣被（件）：</td>
				<td class="FieldInput"><label id="useClothes" field="useClothes"/></td>
				<td class="FieldLabel">需发放衣被（件）：</td>
				<td class="FieldInput"><label id="clothes" field="clothes"/></td>
			</tr>
			<tr>
				<td class="FieldLabel">发放人：</td>
				<td class="FieldInput"><input type="text"
					id="grantPeopleName" disabled="disabled"/></td>
				<td class="FieldLabel">发放时间：</td>
				<td class="FieldInput"><input type="text" format="Y-m-d"
					style="width: 100px;" maxlength="10" id="grantTime" /><img
					src="../../../../skins/images/default/rl.gif" align="middle"
					onclick="getTimes(this)"></td>
			</tr>
		</table>
		</form>
		</div>
	</next:Html>
</next:Panel>
</body>
</html>
