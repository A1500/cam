<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>退役士兵列表</title>
<next:ScriptManager />
<script>
	var struId = '<%=BspUtil.getStruId()%>';
	var orgCode  ='<%=BspUtil.getOrganCode()%>';
	var organName= decodeURIComponent('<%=request.getParameter("organName")%>');
</script>
<script type="text/javascript" src="prsretiredsoldiers_list.js"></script>
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
	<!-- 退役士兵基本信息 -->
	<model:dataset id="retiredSoldierDataset"
		cmd="com.inspur.cams.prs.prsretiredsoldiers.cmd.PrsRetiredSoldiersQueryCommand"
		method="querySoldierss">
		<model:record>
			<model:field name="BIRTHDAY" type="string" />
			<model:field name="CERTIFICATENO" type="string" />
			<model:field name="WHEREPLACEMENT" type="string" />
			<model:field name="ENPLACE" type="string" />
			<model:field name="NATON" type="string" />
			<model:field name="RETIREDTIME" type="string" />
			<model:field name="SEX" type="string" />
			<model:field name="NATION" type="string" />
			<model:field name="FLAG" type="string" />
			<model:field name="NAME" type="string" />
			<model:field name="ID" type="string" />
			<model:field name="SOLDIERTYPE" type="string" />
			<model:field name="ENTIME" type="string" />
			<model:field name="TEL" type="string" />
			<model:field name="ADDRESS" type="string" />
			<model:field name="SOURCE" type="string" />
			<model:field name="domicileName" type="string" />
			<model:field name="enlistPlaceName" type="string" />
			<model:field name="REGION" type="string" />
			<model:field name="IDCARD_NO" type="string" />
			<model:field name="HUKOU_TYPE" type="string" />
			<model:field name="COUTRAL_LEVEL" type="string" />
			<model:field name="ARRIVE_TIME" type="string" />
			<model:field name="TRAINING_MAJOR" type="string" />
		</model:record>
	</model:dataset>
	
	<!-- 文化程度 -->
	<model:dataset id="EducationDataset" enumName="EDUCATION.CODE"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 户籍类别 -->
	<model:dataset id="DomicileDataset" enumName="DOMICILE.CODE"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 培训类型 -->
	<model:dataset id="TrainingType" enumName="TRAINING.TYPE"
		autoLoad="true" global="true">
	</model:dataset>
		<!-- 行政区划 -->
	<model:dataset id="OrgNameDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="false">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
		
			<model:param name="dic" value='DIC_CITY'></model:param>
			<model:param name="value" value='ID'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!--军区代码  -->
	<model:dataset id="MilitaryRegionCodeDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_MILITARY_REGION_CODE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 是否 -->
	<model:dataset id="yesON" enumName="COMM.YESORNO"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true"
		global="true"></model:dataset>
	<!-- 士兵类型 -->
	<model:dataset id="RetiredSoldierType" enumName="RETIREDSOLDIERTYPE.CODE" autoLoad="true"
		global="true"></model:dataset>
	<!-- 民族 -->
	<model:dataset id="NationDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 户籍类别 -->
	<model:dataset id="DomicileDataset" enumName="DOMICILE.CODE"
		autoLoad="true" global="true"></model:dataset>
	<!--入伍形式 -->
	<model:dataset id="EnlistTypeDataset" enumName="ENLISTTYPE.CODE"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 是否退档 -->
	<model:dataset id="ApprovalDataset" enumName="APPROVALSTATE.CODE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 档案来源 -->
	<model:dataset id="FileResourcesDataset" enumName="FILESRESOURCE.CODE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 培训专业 -->
	 <model:dataset id="trainDic"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="false">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='dic_prs_train_field'></model:param>
			<model:param name="value" value='NAME'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>


<next:Panel name="form" width="100%" border="0"
	bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox"><legend
			class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton"
			src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
			onclick="collapse(this)" /> </legend>
		<div>
		<form style="width: 98%; height: 100%;" class="L5form">
		<table border="1" width="100%">
			<tr>
				<td class="FieldLabel" nowrap="nowrap" >退役年度：</td>
				<td class="FieldInput" ><input type="text" id="cYear"
					class="TextEditor" title="退役年度" /></td>
				<td class="FieldLabel" nowrap="nowrap" >姓名：</td>
				<td class="FieldInput"><input type="text" id="name"
					class="TextEditor" title="姓名" />
				</td>
				<td class="FieldLabel" nowrap="nowrap">军区大单位：</td>
				<td class="FieldInput"><select id="servedMilitaryRegion" name="军区大单位">
					<option dataset="MilitaryRegionCodeDataset"></option></select>
				</td>
				<td class="FieldInput">
				<button onclick="query()">查 询</button>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap="nowrap">士兵类型：</td>
				<td class="FieldInput"><select id="retiredSoldierType"
								field="retiredSoldierType" name="退役士兵类型">
								<option value="" >请选择······</option>
								<option value="0" >退伍义务兵</option>
								<option value="1" >复员士官</option>
								<option value="3" >转业士官</option>
							</select></td>
				<td class="FieldLabel" nowrap="nowrap">安置地：</td>
				<td class="FieldInput"><input type="text" id="domicileName"
					field="domicileName" onclick="forHelp()" readonly="readonly" />
					<input type="hidden" id="domicileCode" name="安置地" />
				</td>
				<td class="FieldLabel">是否退档：</td>
				<td class="FieldInput" colspan="1"><select  id = "sendback" name="是否退档" >
				<option dataset="ApprovalDataset"></option></select>
				</td>
				<td class="FieldInput">
				<button onclick="reset()">重 置</button>
				</td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="prsretiredsoldiersGrid" clickToSelectedForChkSM="true"
	width="99%" stripeRows="true" height="100%" style="padding: 5px;"
	dataset="retiredSoldierDataset" autoExpandColumn="address"
	notSelectFirstRow="true" title="退役士兵信息">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="增加" iconCls="add" handler="insert" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="修改" iconCls="edit" handler="update" />
		<next:ToolBarItem symbol="-"></next:ToolBarItem>
		<next:ToolBarItem text="删除" iconCls="remove" handler="del" />
		<next:ToolBarItem symbol="-"></next:ToolBarItem>
		<next:ToolBarItem text="查看" iconCls="detail" id="detail" handler="detail" />
		<next:ToolBarItem symbol="-"></next:ToolBarItem>
		<next:ToolBarItem text="打印介绍信" iconCls="print" id="print"
			handler="print" />
		<next:ToolBarItem text="打印个人信息" iconCls="print" id="print"
			handler="printBaseInfo" />
		<next:ToolBarItem symbol="-"></next:ToolBarItem>
		<next:ToolBarItem text="导出EXCEL" iconCls="export" id="excel_click" handler="excel_click" />
		<next:ToolBarItem text="导出CSV" iconCls="export" id="excel_click" handler="exportCSV" hidden="true"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="35" header="序号" />
		<next:CheckBoxColumn></next:CheckBoxColumn>

		<next:Column id="name" header="姓名" field="NAME" width="90">
			<next:TextField />
		</next:Column>

		<next:Column id="sex" header="性别" field="SEX" width="35"
			dataset="SexDataset">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="naton" header="民族" field="NATION"
			dataset="NationDataset" width="60">
			<next:TextField />
		</next:Column>
		<next:Column id="idcardNo" header="身份证号" field="IDCARD_NO" width="150">
			<next:TextField />
		</next:Column>
		<next:Column id="certifcateNo" header="退伍证号" field="CERTIFICATENO" width="140">
			<next:TextField />
		</next:Column>
		<next:Column id="hukouType" header="户口性质" field="HUKOU_TYPE"
			dataset="DomicileDataset" width="60">
			<next:TextField />
		</next:Column>
		<next:Column id="coutralLevel" header="文化程度" field="COUTRAL_LEVEL"
			dataset="EducationDataset" width="60">
			<next:TextField />
		</next:Column>
		<next:Column id="retiredsoldiertype" header="士兵类型"
			field="SOLDIERTYPE" dataset="RetiredSoldierType" width="80">
			<next:TextField />
		</next:Column>

		<next:Column id="servedmilitaryregion" header="军区大单位"
			field="REGION"   dataset="MilitaryRegionCodeDataset" width="80">
			<next:TextField />
		</next:Column>

		<next:Column id="enlistTime" header="入伍时间" field="ENTIME"
			width="90">
			<next:TextField />
		</next:Column>

		<next:Column id="retiredTime" header="退役时间" field="RETIREDTIME"
			width="90">
			<next:TextField />
		</next:Column>

		<next:Column id="enlistPlace" header="入伍地" field="ENPLACE"
			width="90">
			<next:TextField />
		</next:Column>
		<next:Column id="arriveTime" header="报到时间" field="ARRIVE_TIME"
			width="90">
			<next:TextField />
		</next:Column>
		<next:Column id="trainingMajor" header="培训专业" field="TRAINING_MAJOR"
			 width="60">
			<next:TextField />
		</next:Column>
		
		<next:Column id="whereplacement" header="安置地"
			field="domicileName" width="100">
			<next:TextField />
		</next:Column>

		<next:Column id="flag" header="是否退档" field="FLAG"
			dataset="ApprovalDataset" width="60">
			<next:TextField />
		</next:Column>

		<next:Column id="tel" header="联系电话" field="TEL" width="100">
			<next:TextField />
		</next:Column>
		<next:Column id="address" header="家庭住址" field="ADDRESS" width="130">
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="retiredSoldierDataset" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
