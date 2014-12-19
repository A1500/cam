
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
<title>保险列表</title>
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
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
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
	<!--保险信息dataset用于列表显示-->
	<model:dataset id="insuranceDataset"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyInsuranceQueryCmd"
		global="true" pageSize="10">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyInsurance"></model:record>
	</model:dataset>
	<!--保险信息dataset用于window-->
	<model:dataset id="insuranceAddDataset"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyInsuranceQueryCmd"
		global="true" pageSize="10">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyInsurance"></model:record>
	</model:dataset>
	<!-- 保险受益类型 -->
	<model:dataset id="beneDS" enumName="BENE_TYPE" autoLoad="true"
		global="true"></model:dataset>
</model:datasets>


<next:GridPanel id="editGridPanel" name="samesureyhouseGrid"
	width="100%" stripeRows="true" height="100%" dataset="insuranceDataset"
	title="保监">

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
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="benefitPeople" header="保险受益人" field="benefitPeople"
			width="90">
			<next:TextField />
		</next:Column>

		<next:Column id="benefitDate" header="受益时间" field="benefitDate"
			width="100">
			<next:TextField />
		</next:Column>

		<next:Column id="benefitType" header="保险受益种类" field="benefitType"
			dataset="beneDS" width="120">
			<next:TextField />
		</next:Column>

		<next:Column id="benefitNum" header="保险受益金额（元）" field="benefitNum" align="right"
			width="120">
			<next:TextField />
		</next:Column>

	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="insuranceDataset" />
	</next:BottomBar>
</next:GridPanel>
<next:Window id="socialWin" height="160" width="550" title="保监信息录入" closeAction="hide">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem text="保存" iconCls="save"
				handler="Evt_butsave_onclick"></next:ToolBarItem>
			<next:ToolBarItem text="返回" iconCls="undo"
				handler="Evt_butreturn_onclick"></next:ToolBarItem>
			<next:ToolBarItem symbol=""></next:ToolBarItem>
			<next:ToolBarItem symbol="-"></next:ToolBarItem>
			<next:ToolBarItem symbol=""></next:ToolBarItem>
		</next:TopBar>
		<next:Html>
			<form class="L5form" dataset="insuranceAddDataset">
			<table width="100%">
				<tr>
					<td class="FieldLabel">保险受益人：</td>
					<td class="FieldInput"><input type="text" name="benefitPeople"
						maxlength="15" field="benefitPeople" /></td>

					<td class="FieldLabel">受益时间：</td>
					<td class="FieldInput"><input type="text" name="benefitDate" readonly="readonly" format="Y-m-d"
					onclick="LoushangDate(this)" field="benefitDate" /></td>
				</tr>
				<tr>
					<td class="FieldLabel">保险受益种类：</td>
					<td class="FieldInput"><select name="benefitType"
						field="benefitType">
						<option dataset="beneDS"></option>
					</select></td>

					<td class="FieldLabel">保险受益金额（元）：</td>
					<td class="FieldInput"><input type="text" name="benefitNum" align="right"
						maxlength="16" onblur="checkMoney(this.id)" field="benefitNum" /></td>
				</tr>
			</table>
			</form>
		</next:Html>
</next:Window>
</body>
</html>
