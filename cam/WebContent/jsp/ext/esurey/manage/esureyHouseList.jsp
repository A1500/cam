
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
			var idCard='<%=request.getParameter("idCard")%>';
			var owerName='<%=java.net.URLDecoder.decode(request.getParameter("owerName"),"UTF-8")%>';
		</script>
<script type="text/javascript" src="esureyHouseList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
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
	<!--房管信息dataset用于列表显示-->
	<model:dataset id="houseDataset"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyHouseQueryCmd"
		global="true" pageSize="10">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyHouse"></model:record>
	</model:dataset>
	<!--房管信息dataset用于window-->
	<model:dataset id="houseAddDataset"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyHouseQueryCmd"
		global="true" pageSize="10">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyHouse"></model:record>
	</model:dataset>
	<!-- 房屋用途 -->
	<model:dataset id="houseUserageDataset" enumName="HOUSE.USEAGE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 交易性质 -->
	<model:dataset id="businessTypeDataset" enumName="BUSINESS.TYPE"
		autoLoad="true" global="true"></model:dataset>
	<!--经济核对_财产收入申报信息dataset-->
	<model:dataset id="estateDataset"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyPeopleEstateQueryCmd"
		global="true" pageSize="10">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyPeopleEstate"></model:record>
	</model:dataset>
	<!-- 财产收入类别 -->
	<model:dataset id="incomeTypeDataset" enumName="ITEM2"
		autoLoad="true" global="true"></model:dataset>
</model:datasets>


<next:GridPanel id="editGridPanel" name="samesureyhouseGrid"
	width="100%" stripeRows="true" height="100%" dataset="houseDataset"
	title="房管">

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
		<next:Column id="houseOwer" header="产权人姓名" field="houseOwer"
			width="90">
			<next:TextField />
		</next:Column>

		<next:Column id="owerIdCard" header="身份证号" field="owerIdCard"
			width="150">
			<next:TextField />
		</next:Column>
		
		<next:Column id="houseCardNo" header="房产证号" field="houseCardNo"
			width="90">
			<next:TextField />
		</next:Column>

		<next:Column id="houseUseage" header="房屋用途" field="houseUseage"
			dataset="houseUserageDataset" width="90">
			<next:TextField />
		</next:Column>

		<next:Column id="regValue" header="交易价值（元）" field="regValue" renderer="formatNum" align="right" width="110">
			<next:TextField />
		</next:Column>

		<next:Column id="regDate" header="登记或交易时间" field="regDate" width="105">
			<next:TextField />
		</next:Column>

		<next:Column id="businessType" header="交易性质" field="businessType"
			dataset="businessTypeDataset" width="90">
			<next:TextField />
		</next:Column>

		<next:Column id="location" header="房屋坐落" field="location" width="90">
			<next:TextField />
		</next:Column>

		<next:Column id="houseArea" header="建筑面积（平方米）" field="houseArea"  renderer="formatNum"  width="120">
			<next:TextField />
		</next:Column>

	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="houseDataset" />
	</next:BottomBar>
</next:GridPanel>
<next:Window id="socialWin" closeAction="hide" title="房屋信息录入" height="230" width="580">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem text="保存" iconCls="save"
				handler="Evt_butsave_onclick"></next:ToolBarItem>
			<next:ToolBarItem text="返回" iconCls="undo"
				handler="Evt_butreturn_onclick"></next:ToolBarItem>
		</next:TopBar>
		<next:Html>
			<form class="L5form" dataset="houseAddDataset">
			<table>


				<tr>
					<td class="FieldLabel" width="110px">身份证号：</td>
					<td class="FieldInput" width="145px"><input style="width: 100%" type="text" id="owerIdCardIn" maxlength="18" name="owerIdCard" onchange="check_IdCard()"
						field="owerIdCard" readonly="readonly"/></td>
						
					<td class="FieldLabel" width="115px">产权人姓名：</td>
					<td class="FieldInput" width="145px"><input type="text" name="houseOwer" style="width: 100%" maxlength="15"
						field="houseOwer" readonly="readonly"/></td>
					
				</tr>
				<tr>
					<td class="FieldLabel" >房产证号：</td>
					<td class="FieldInput"><input type="text" name="houseCardNo" style="width: 100%" maxlength="50"
						field="houseCardNo" /></td>
				
					<td class="FieldLabel">房屋用途：</td>
					<td class="FieldInput"><select name="houseUseage" style="width:100%"
						field="houseUseage">
						<option dataset="houseUserageDataset"></option>
					</select></td>
				</tr>
				<tr>
					<td class="FieldLabel">交易价值(元)：</td>
					<td class="FieldInput" ><input type="text" name="regValue" style="width: 100%" maxlength="16" align="right" onblur="checkMoney(this.id)"
						field="regValue" /></td>

					<td class="FieldLabel">登记或交易时间：</td>
					<td class="FieldInput"><input type="text" name="regDate" style="width:100%"
						field="regDate" readonly="readonly" format="Y-m-d"
						onclick="LoushangDate(this)"></td>
				</tr>
				<tr>
					<td class="FieldLabel">交易性质：</td>
					<td class="FieldInput" ><select name="businessType" style="width: 100%" 
						field="businessType">
						<option dataset="businessTypeDataset"></option>
					</select></td>
					<td class="FieldLabel">房屋坐落：</td>
					<td class="FieldInput" ><input type="text" name="location" style="width: 100%" 
						field="location" /></td>
					</tr>
				<tr>
					<td class="FieldLabel">建筑面积（平方米）：</td>
					<td class="FieldInput"><input type="text" name="houseArea" onblur="checkMoney(this.id)" style="width:100%"
						field="houseArea" /></td>
					<td class="FieldLabel"></td>
					<td class="FieldInput"></td>
				</tr>
			</table>
			</form>
		</next:Html>
</next:Window>
</body>
</html>
