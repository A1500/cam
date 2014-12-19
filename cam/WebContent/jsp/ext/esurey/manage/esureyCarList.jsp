
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
<title>公安（车管）列表</title>
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
			var owerName='<%=java.net.URLDecoder.decode(request.getParameter("owerName"),"UTF-8")%>';
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
	<!--车管信息dataset用于列表显示-->
	<model:dataset id="carDataset"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyCarQueryCmd"
		global="true" pageSize="10">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyCar"></model:record>
	</model:dataset>
	<!--车管信息dataset用于window-->
	<model:dataset id="carAddDataset"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyCarQueryCmd"
		global="true" pageSize="10">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyCar"></model:record>
	</model:dataset>
	<!-- 车辆用途 -->
	<model:dataset id="carUseDataset" enumName="CAR.USE" autoLoad="true"
		global="true"></model:dataset>
	<!--经济核对_财产收入申报信息dataset-->
	<model:dataset id="estateDataset"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyPeopleEstateQueryCmd"
		global="true" pageSize="10">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyPeopleEstate"></model:record>
	</model:dataset>
	<!-- 车辆类型 -->
	<model:dataset id="carTypeDS" enumName="CAR_TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 财产收入类别 -->
	<model:dataset id="incomeTypeDataset" enumName="ITEM2"
		autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:ViewPort>
<next:GridPanel id="editGridPanel" name="samesureyhouseGrid"
	width="100%" stripeRows="true" height="90%" dataset="carDataset"
	title="车辆信息列表">

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
		<next:Column id="owner" header="车主姓名" field="owner" width="15%">
			<next:TextField />
		</next:Column>

		<next:Column id="carNo" header="车牌号码" field="carNo" width="15%">
			<next:TextField />
		</next:Column>

		<next:Column id="carType" header="车辆类型" field="carType" dataset="carTypeDS" width="15%">
			<next:TextField />
		</next:Column>

		<next:Column id="regValue" header="登记价值（万元）" field="regValue" width="15%" align="right" renderer="formatNum">
			<next:TextField />
		</next:Column>

		<next:Column id="regDate" header="登记时间" field="regDate" width="15%">
			<next:TextField />
		</next:Column>

		<next:Column id="carUse" header="用途" field="carUse"
			dataset="carUseDataset" width="25%">
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="carDataset" />
	</next:BottomBar>
</next:GridPanel>
<next:Panel id="prompt_id" width="100%" autoHeight="true">
	<next:Html>
		<form class="L5form">
		<table width="100%">
			<td class="FieldInput" rowspan="2"><font color="red" size="5">若此人无车辆信息，直接点击"提交"!</font></td>
		</table>
		</form>
	</next:Html>
</next:Panel>
</next:ViewPort>
<next:Window id="socialWin" height="160" title="车辆信息录入" width="550" closeAction="hide">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem text="保存" iconCls="save"
				handler="Evt_butsave_onclick"></next:ToolBarItem>
			<next:ToolBarItem text="返回" iconCls="undo"
				handler="Evt_butreturn_onclick"></next:ToolBarItem>
		</next:TopBar>
		<next:Html>
			<form class="L5form" dataset="carAddDataset">
			<table width="100%">
				<tr>
					<td class="FieldLabel">车主姓名：</td>
					<td class="FieldInput"><input type="text" name="owner" maxlength="25" readonly="readonly"
						field="owner" /></td>

					<td class="FieldLabel">车牌号码：</td>
					<td class="FieldInput"><input type="text" name="carNo" maxlength="30"
						field="carNo" /></td>
				</tr>
				<tr>
					<td class="FieldLabel">车辆类型：</td>
					<td class="FieldInput"><select name="carType" field="carType">
						<option dataset="carTypeDS"></option>
					</select></td>

					<td class="FieldLabel">登记价值（万元）：</td>
					<td class="FieldInput"><input type="text" name="regValue" maxlength="16" align="right" onblur="checkMoney(this.id)"
						field="regValue" /></td>
				</tr>
				<tr>
					<td class="FieldLabel">登记时间：</td>
					<td class="FieldInput"><input type="text" name="regDate"
						field="regDate" readonly="readonly" format="Y-m-d"
						onclick="LoushangDate(this)" /></td>

					<td class="FieldLabel">用途：</td>
					<td class="FieldInput"><select name="carUse" field="carUse">
						<option dataset="carUseDataset"></option>
					</select></td>
				</tr>
			</table>
			</form>
		</next:Html>
</next:Window>
</body>
</html>
