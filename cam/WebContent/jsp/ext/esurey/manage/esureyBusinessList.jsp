
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="com.inspur.cams.comm.util.DateUtil"%>
<%@ page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<html>
<head>
<title>房管列表</title>
<next:ScriptManager />
<script>
			var peopleId='<%=request.getParameter("peopleId")%>';
			var familyId='<%=request.getParameter("familyId")%>';
			var feedbackId='<%=request.getParameter("feedbackId")%>';
			var frontJsp='<%=request.getParameter("frontJsp")%>';
			var surveyId='<%=request.getParameter("surveyId")%>';
			var organId='<%=ExtBspInfo.getUserInfo(request).getOrganId()%>';
			var checkOrg='<%=ExtBspInfo.getUserInfo(request).getOrganName()%>';
			var checkPeople='<%=ExtBspInfo.getUserInfo(request).getUserName()%>';
			var checkId='<%=ExtBspInfo.getUserInfo(request).getUserId()%>';
		</script>
<script type="text/javascript" src="esureyHouseList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
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
		</script>
</head>
<body>
<model:datasets>
	<!--工商信息dataset用于列表显示-->
	<model:dataset id="businessDataset"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyBusinessQueryCmd"
		global="true" pageSize="10">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyBusiness"></model:record>
	</model:dataset>
	<!--工商信息dataset用于window-->
	<model:dataset id="businessAddDataset"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyBusinessQueryCmd"
		global="true" pageSize="10">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyBusiness"></model:record>
	</model:dataset>
	<!--经济核对_外部单位填报信息的dataset-->
	<model:dataset id="CheckFlagDataset"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyFeedbackQueryCmd"
		global="true" pageSize="10">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyFeedback"></model:record>
	</model:dataset>
	<!-- 企业注册方式 -->
	<model:dataset id="compBusinessTypeDataset"
		enumName="COMP.BUSINESS.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 企业注册方式 -->
	<model:dataset id="organDataset" enumName="ORGAN.STATUS"
		autoLoad="true" global="true"></model:dataset>
</model:datasets>


<next:GridPanel id="editGridPanel" name="samesureyhouseGrid"
	width="100%" stripeRows="true" height="100%" dataset="businessDataset"
	title="工商">

	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="增加" handler="addMsg" />
		<next:ToolBarItem iconCls="edit" text="修改"
			handler="Evt_modify_onclick" />
		<next:ToolBarItem iconCls="remove" text="删除"
			handler="Evt_butremove_onclick" />
		<next:ToolBarItem iconCls="add" text="提交"
			handler="Evt_butcheckin_onclick" />
		<next:ToolBarItem iconCls="return" text="返回"
			handler="Evt_return_onclick" />		
				<next:ToolBarItem symbol=""></next:ToolBarItem>
				<next:ToolBarItem symbol="-"></next:ToolBarItem>
				<next:ToolBarItem symbol=""></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="businessType" header="注册方式" field="businessType"
			dataset="compBusinessTypeDataset" width="15%">
			<next:TextField />
		</next:Column>

		<next:Column id="legalPerson" header="法人" field="legalPerson"
			width="10%">
			<next:TextField />
		</next:Column>

		<next:Column id="organName" header="企业名称" field="organName" width="15%">
			<next:TextField />
		</next:Column>

		<next:Column id="regAdd" header="注册地址" field="regAdd" width="20%">
			<next:TextField />
		</next:Column>

		<next:Column id="businessAdd" header="经营地址" field="businessAdd"
			width="20%">
			<next:TextField />
		</next:Column>

		<next:Column id="regFund" header="注册资金（万元）" field="regFund" width="20%" align="right" renderer="formatNum" >
			<next:TextField />
		</next:Column>

		<next:Column id="regDate" header="注册时间" field="regDate" width="10%">
			<next:TextField />
		</next:Column>

		<next:Column id="businessScope" header="经营范围" field="businessScope"
			width="10%">
			<next:TextField />
		</next:Column>

		<next:Column id="organStatus" header="当前状态" field="organStatus"
			dataset="organDataset" width="10%">
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="businessDataset" />
	</next:BottomBar>
</next:GridPanel>
<next:Window id="socialWin" height="220" title="工商信息录入" width="550" closeAction="hide">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem text="保存" iconCls="save"
				handler="Evt_butsave_onclick"></next:ToolBarItem>
			<next:ToolBarItem text="返回" iconCls="undo"
				handler="Evt_butreturn_onclick"></next:ToolBarItem>
		</next:TopBar>
		<next:Html>
			<form class="L5form" dataset="businessAddDataset">
			<table width="100%">
				<tr>
					<td class="FieldLabel">企业注册方式：</td>
					<td class="FieldInput"><select name="type" field="businessType">
						<option dataset="compBusinessTypeDataset"></option>
					</select></td>

					<td class="FieldLabel">法人名称：</td>
					<td class="FieldInput"><input type="text" name="legalPerson" maxlength="15"
						field="legalPerson" /></td>
				</tr>
				<tr>
					<td class="FieldLabel">企业名称：</td>
					<td class="FieldInput"><input type="text" name="organName" maxlength="25"
						field="organName" /></td>

					<td class="FieldLabel">注册地址：</td>
					<td class="FieldInput"><input type="text" name="regAdd" maxlength="50"
						field="regAdd" /></td>
				</tr>
				<tr>
					<td class="FieldLabel">经营地址：</td>
					<td class="FieldInput"><input type="text" name="businessAdd" maxlength="50"
						field="businessAdd" /></td>

					<td class="FieldLabel">注册资金（万元）：</td>
					<td class="FieldInput"><input type="text" name="regFund" maxlength="16" align="right" onblur="checkMoney(this.id)"
						field="regFund" /></td>
				</tr>
				<tr>
					<td class="FieldLabel">注册时间：</td>
					<td class="FieldInput"><input type="text" name="regDate"
						field="regDate" readonly="readonly" format="Y-m-d"
						onclick="LoushangDate(this)" /></td>

					<td class="FieldLabel">经营范围：</td>
					<td class="FieldInput"><input type="text" name="businessScope" maxlength="500"
						field="businessScope" /></td>
				</tr>
				<tr>
					<td class="FieldLabel">企业当前状态：</td>
					<td class="FieldInput"><select name="organStatus"
						field="organStatus">
						<option dataset="organDataset"></option>
					</select></td>

					<td class="FieldLabel"></td>
					<td class="FieldInput"></td>
				</tr>
			</table>
			</form>
		</next:Html>
</next:Window>
</body>
</html>
