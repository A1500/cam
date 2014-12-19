<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<html>
<head>
<title>房管部门查询列表</title>
<next:ScriptManager />
<script>
			var organCode='<%=ExtBspInfo.getUserInfo(request).getAreaCode()%>';
			var organId='<%=ExtBspInfo.getUserInfo(request).getOrganId()%>';
</script>
<script type="text/javascript" src="externalcomm.js"></script>
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
	<!--经济核对_房管填报信息的dataset-->
	<model:dataset id="externalHouseDataset"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyHouseQueryCmd"
		global="true" pageSize="10" method="queryExtHouse">
		
	</model:dataset>
	<!-- 住房类型 -->
	 <model:dataset id="houseTypeDS" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_HOUSE_QUALITY'></model:param>
		</model:params>
	</model:dataset>
	<!-- 房屋状况 -->
	 <model:dataset id="buildingTypeDS" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_HOUSE_STATUS'></model:param>
		</model:params>
	</model:dataset>
	<!-- 房屋用途 -->
	<model:dataset id="houseUserageDataset" cmd="com.inspur.cams.comm.dicm.cmd.DicDetailsQueryCmd" method="queryForDic" >
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dicType" value="ESUREY_HOUSE_USEAGE"></model:param>
		</model:params>
	</model:dataset>
	<!-- 交易性质 -->
	<model:dataset id="businessTypeDataset" cmd="com.inspur.cams.comm.dicm.cmd.DicDetailsQueryCmd" method="queryForDic" >
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dicType" value="ESUREY_BUSINESS_TYPE"></model:param>
		</model:params>
	</model:dataset>		
	<!-- 属地 -->
	<model:dataset id="domicileDataset" autoLoad="false"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CITY'></model:param>
			<model:param name="value" value='ID'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>

<!--业务查询-->
<next:Panel name="form" width="100%" border="0"
	bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true"
	title="->  您的位置 : 房管填报信息列表">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox"><legend
			class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton"
			src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
			onclick="collapse(this)" /> </legend>
		<div>
		<form style="width: 100%; height: 100%;" class="L5form">
		<table border="1" width="100%">
			<tr>
				<td class="FieldLabel">户主姓名:</td>
				<td class="FieldInput"><input type="text" id="name" style="width:170px"
					class="TextEditor" /></td>
				<td class="FieldLabel">户主身份证号:</td>
				<td class="FieldInput"><input type="text" id="idCard" style="width:160px"
					field="身份证号" class="TextEditor" /></td>
				<td class="FieldButton">
				<button onclick="query()">查 询</button>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel">核对时间:</td>
				<td class="FieldInput">
					<input type="text" id="startTime" style="width:80px"
					name="startTime" readonly="readonly" format="Y-m-d"
					onclick="LoushangDate(this)">---<input type="text" id="endTime"
					name="endTime" readonly="readonly" format="Y-m-d" style="width:80px"
					onclick="LoushangDate(this)">
				</td>
				<td class="FieldLabel">行政区划:</td>
				<td class="FieldInput">
					<select id="familyAddressh"  style="width:160px">
						<option dataset="domicileDataset"></option>
					</select>
				</td>
				<td class="FieldButton">
				<button onclick="reset()">重 置</button>
				</td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>

<!--经济核对_房管填报信息的列表-->
<next:GridPanel id="editGridPanel" name="editGridPanel" width="100%"
	stripeRows="true" height="100%" dataset="externalHouseDataset" 
	notSelectFirstRow="true" title="房管填报信息的列表">
	<next:TopBar>
	<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="导出Excel" iconCls="add" handler="forExcel" ></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30" />
		
		<next:Column id="name" header="人员姓名" field="NAME" width="80">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="idCard" header="人员身份证件号码" field="ID_CARD" width="150">
			<next:TextField allowBlank="false" />
		</next:Column>
		
		<next:Column id="yearMoth" header="房产证号" field="HOUSE_CARD_NO" width="100">
			<next:TextField />
		</next:Column>
		
		<next:Column id="houseUseageName" header="房屋用途" field="HOUSE_USEAGE_NAME" width="80">
			<next:TextField allowBlank="false" />
		</next:Column>
		
		<next:Column id="houseOwer" header="产权人姓名" field="HOUSE_OWER" width="80">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="owerIdCard" header="产权人身份证号" field="OWER_ID_CARD" width="170">
			<next:TextField allowBlank="false" />
		</next:Column>
		
		<next:Column id="regValue" header="交易价值（元）" field="REG_VALUE" align="right" width="100">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="regDate" header="登记或交易时间" field="REG_DATE" width="100">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="businessTypeName" header="交易性质"  field="BUSINESS_TYPE_NAME" width="80">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="location" header="房屋坐落" field="LOCATION" width="80">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="houseArea" header="建筑面积（平方米）" field="HOUSE_AREA" width="150">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="familyAddressName" header="所在地区" field="FAMILY_ADDRESS_NAME"  width="100">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="checkTime" header="核对日期" field="CHECK_TIME" width="100">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="checkPeople" header="核对人" field="CHECK_PEOPLE" width="100">
			<next:TextField allowBlank="false" />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="externalHouseDataset" />
	</next:BottomBar>
</next:GridPanel>

</body>
</html>
