<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>住房信息修改</title>
<next:ScriptManager />
		<script>
			var familyId='<%=request.getParameter("familyId")%>';
		</script>
<script type="text/javascript" src="houseUpdate.js"></script>
<script type="text/javascript" src="bptComm.js"></script>
</head>
<body>
<model:datasets>
	<!-- 家庭信息 -->
	<model:dataset id="BaseinfoFamilyDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleQueryCommand"
		method="queryFamilyInfo" global="true">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoFamily"></model:record>
	</model:dataset>
	
	<!-- 建购房补助 -->
	<model:dataset id="HouseSubsidyInfoDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptHouseSubsidyInfoQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptHouseSubsidyInfo"></model:record>
	</model:dataset>
	
	<!-- 住房状况 --> 
	<model:dataset id="HouseStatusDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_HOUSESTATUS'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
			<model:param name="includeCode" value='1,3'></model:param>
		</model:params>
	</model:dataset>
	
	 <!-- 住房性质 -->
	<model:dataset id="HouseQualityDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_HOUSEQUALITY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	
	 <!-- 房屋结构类型 --> 
	<model:dataset id="HouseStructureTypeDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_HOUSE_STRUCTURE_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	
	 <!-- 房屋结构 --> 
	<model:dataset id="HouseStructureDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_HOUSE_STRUCTURE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	
	<!-- 享受购建房补助 -->
	<model:dataset id="BuildingSubsidyDataset" enumName="BUILDINGSUBSIDY.FLAG"  autoLoad="true" global="true"></model:dataset>
	
	<!-- 房屋状况 -->
	<model:dataset id="HousingStatusEnum" enumName="HOUSING.STATUS"  autoLoad="true" global="true"></model:dataset>
	
	<!-- 享受购建房补助类型 -->
	<model:dataset id="HouseSubsidyTypeEnum" enumName="HOUSE.SUBSIDYTYPE"  autoLoad="true" global="true"></model:dataset>
</model:datasets>

			<next:Panel  width="100%" id="familyTabPanel" autoScroll="true" height="150">
				<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
					<next:ToolBarItem iconCls="save" text="保存" handler="save" />
					<next:ToolBarItem iconCls="disable" text="关闭" handler="func_Close"/>
				</next:TopBar>
				<next:Html>
					<form id="editForm" dataset="BaseinfoFamilyDataSet"
						onsubmit="return false" style="padding: 5px;" class="L5form">
					<table border="1" width="98%">
					
						<tr>
							<td class="FieldLabel" nowrap="nowrap">住房状况及性质：</td>
							<td class="FieldInput" colspan="3">
										<select name="houseStatus" field="houseStatus" onchange="selHouseStatus()">
											<option dataset="HouseStatusDataset"></option>
										</select>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<select name="houseQuality" field="houseQuality">
											<option dataset="HouseQualityDataset"></option>
										</select>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<select name="houseStatus2" field="houseStatus2"  id="houseStatus2" > 
											<option  dataset="HousingStatusEnum" ></option>
										</select>
							</td>
							
							<td class="FieldLabel">房屋结构：</td>
							<td class="FieldInput">
										<select id="houseStructureType" name="houseStructureType" field="houseStructureType" onchange="selStructureType()">
											<option dataset="HouseStructureTypeDataset"></option>
										</select>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<select id="buildingStructure" name="buildingStructure" field="buildingStructure">
											<option dataset="HouseStructureDataset"></option>
										</select></td>
						</tr>
						
						<tr>
							
							<td class="FieldLabel">房屋间数：</td>
							<td class="FieldInput"><input id="houseNumber" type="text" maxlength="3" name="houseNumber" field="houseNumber" /></td>	
							
							<td class="FieldLabel" nowrap="nowrap">住房建筑时间：</td>
							<td class="FieldInput"><input type="text" name="buildingDate"
								id = "buildingDate"  field="buildingDate" format="Y-m-d"maxlength="10"  onpropertychange="changeDateStyle(this)" style="width: 100px;" /><img id="rl"  src="../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  ></td>
										
							<td class="FieldLabel" nowrap="nowrap">家庭人口数：</td>
							<td class="FieldInput"><input id="peopleNum" type="text" name="peopleNum" maxlength="2" field="peopleNum" onblur="assignAverageArea()" title="家庭人口数"/><font style="color:red;">*</font></td>	
						</tr>
						
						<tr>
							<td class="FieldLabel">总建筑面积：</td>
							<td class="FieldInput">
									<input id="buildArea" type="text" name="buildArea" field="buildArea" maxlength="4" onblur="assignAverageArea()"/>
							</td>	
						
							<td class="FieldLabel" nowrap="nowrap">人均建筑面积：</td>
							<td class="FieldInput" nowrap="nowrap" colspan="3"><input id="buildAverageArea" type="text" name="buildAverageArea" field="buildAverageArea" readonly="readonly" title="人均建筑面积"/><font color="green">自动计算</font></td>
						
							<!--<td class="FieldLabel" nowrap="nowrap">享受租建购修补助情况：</td>
							<td class="FieldInput" colspan="5">
								<select name="buildingSubsidyFlag" field="buildingSubsidyFlag">
											<option dataset="BuildingSubsidyDataset"></option>
								</select></td>-->
						</tr>
						
					</table>
					</form>
				</next:Html>
			</next:Panel>
			
			<next:EditGridPanel id="editGridPanel" name="bpthousesubsidyinfoGrid" width="100%" stripeRows="true" height="100%" dataset="HouseSubsidyInfoDataset" title="租建购修补助信息">
	<next:TopBar>
			<next:ToolBarItem symbol="->" ></next:ToolBarItem>
	        <next:ToolBarItem symbol="-" ></next:ToolBarItem>
			<next:ToolBarItem  iconCls="add" text="增加" handler="insert"  />
			<next:ToolBarItem  iconCls="remove" text="删除" handler="del"  />
			<next:ToolBarItem iconCls="undo"  text="取消" handler="reset"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
	     
	     <next:Column id="subsidyType" header="补助类型" field="subsidyType" width="95" >			
			<next:ComboBox dataset="HouseSubsidyTypeEnum" id="subsidyTypeComboBox" />
		</next:Column>
	     
		<next:Column id="subsidyDate" header="补助日期" field="subsidyDate"  width="95" >			
			<next:DateField allowBlank="false" format="Y-m-d"/>
		</next:Column>
	
		<next:Column id="bptSubsidyMoney" header="优抚保障补助金额(元)" field="bptSubsidyMoney" width="140" align="right">			
			<next:NumberField  />
		</next:Column>
		
		<next:Column id="sociSubsidyMoney" header="社会保障补助金额(元)" field="sociSubsidyMoney" width="140" align="right">			
			<next:NumberField  />
		</next:Column>
		
		<next:Column id="mendNum" header="修房间数" field="mendNum" width="95" align="right">			
			<next:TextField  />
		</next:Column>
	
		<next:Column id="subsidyArea" header="补助面积(平方米)" field="subsidyArea" width="110" align="right" editable="setEditable">			
			<next:NumberField  />
		</next:Column>
			
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="HouseSubsidyInfoDataset"/>
	</next:BottomBar>
</next:EditGridPanel>

</body>
</html>
