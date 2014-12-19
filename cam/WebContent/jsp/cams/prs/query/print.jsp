<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>转业士官列表</title>
<next:ScriptManager />
<script>
	var struId = '<%=BspUtil.getStruId()%>';
	var orgCode  ='<%=BspUtil.getOrganCode()%>';
	var organName= decodeURIComponent('<%=request.getParameter("organName")%>');
	
</script>
<script type="text/javascript" src="print.js"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "ISPrint.js") %>"></script>
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
	<!-- 转业士官基本信息 -->
	<model:dataset id="retiredSoldierDataset"
		cmd="com.inspur.cams.prs.prsretiredsoldiers.cmd.PrsRetiredSoldiersQueryCommand"
		method="querySoldierss">
		<model:record >
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
			<model:field name="PRENSON" type="string" />
			<model:field name="SLOCATION" type="string" />
			<model:field name="SERVEDARMY" type="string" />
			<model:field name="a" type="string" />
				<model:field name="b" type="string" />
					<model:field name="c" type="string" />
						<model:field name="d" type="string" />
							<model:field name="e" type="string" />
								<model:field name="f" type="string" />
									<model:field name="g" type="string" />
		</model:record>
	</model:dataset>
	<model:dataset id="printDataset"
		cmd="com.inspur.cams.prs.prsretiredsoldiers.cmd.PrsRetiredSoldiersQueryCommand"
		method="querySoldierss">
		<model:record >
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
			<model:field name="PRENSON" type="string" />
			<model:field name="SLOCATION" type="string" />
			<model:field name="SERVEDARMY" type="string" />
			<model:field name="a" type="string" />
				<model:field name="b" type="string" />
					<model:field name="c" type="string" />
						<model:field name="d" type="string" />
							<model:field name="e" type="string" />
								<model:field name="f" type="string" />
									<model:field name="g" type="string" />
		</model:record>
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
	<!-- 安置理由 -->
	<model:dataset id="ReasonDataset" enumName="PLACEMENREASON.CODE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 档案来源 -->
	<model:dataset id="FileResourcesDataset" enumName="FILESRESOURCE.CODE"
		autoLoad="true" global="true"></model:dataset>
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
				<td class="FieldLabel" nowrap="nowrap" >转业年度：</td>
				<td class="FieldInput" ><input type="text" id="cYear" style="text-align: right;"
					class="TextEditor" title="转业年度" /></td>
				<td class="FieldLabel" nowrap="nowrap">军区大单位：</td>
				<td class="FieldInput"><select id="servedMilitaryRegion" name="军区大单位">
					<option dataset="MilitaryRegionCodeDataset"></option></select>
				</td>
				
			</tr>
			<tr>
				<td class="FieldLabel" nowrap="nowrap">安置地：</td>
				<td class="FieldInput"><input type="text" id="domicileName"
					field="domicileName" onclick="forHelp()" readonly="readonly" />
					<input type="hidden" id="domicileCode" field="wherePlacemen" name="安置地" />
				</td>
				<td class="FieldInput" colspan="2" align="center">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<button onclick="query()">查 询</button>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
	width="99%" stripeRows="true" height="99%" style="padding: 5px;"
	dataset="retiredSoldierDataset" autoExpandColumn="address"
	notSelectFirstRow="true" title="转业士官信息">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="转业士官审档花名册打印" iconCls="print" id="print"
			handler="print" />
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn  header="序号" />
		<next:CheckBoxColumn></next:CheckBoxColumn>

		<next:Column id="name" header="姓名" field="NAME" >
			<next:TextField />
		</next:Column>

		<next:Column id="servedmilitaryregion" header="部队单位"
			field="SERVEDARMY"    >
			<next:TextField />
		</next:Column>

		<next:Column id="enlistTime" header="入伍时间" field="ENTIME"
			>
			<next:TextField />
		</next:Column>

		<next:Column id="enlistPlace" header="入伍地" field="ENPLACE"
			>
			<next:TextField />
		</next:Column>

		<next:Column id="whereplacement" header="安置地"
			field="domicileName" >
			<next:TextField />
		</next:Column>

		<next:Column id="tel" header="配偶户口所在地" field="SLOCATION" >
			<next:TextField />
		</next:Column>
		<next:Column id="address" header="安置理由" field="PRENSON" dataset="ReasonDataset" >
			<next:TextField />
		</next:Column>
		<next:Column id="address" header="结婚时间" field="a" >
			<next:TextField />
		</next:Column>
		<next:Column id="address" header="迁户时间" field="b" >
			<next:TextField />
		</next:Column>
		<next:Column id="address" header="三等功" field="c" >
			<next:TextField />
		</next:Column>
		<next:Column id="address" header="二等功" field="d" >
			<next:TextField />
		</next:Column>
		<next:Column id="address" header="伤残等级" field="e" >
			<next:TextField />
		</next:Column>
		<next:Column id="flag" header="退档" field="f" >
			<next:TextField />
		</next:Column>
		<next:Column id="address" header="审档情况" field="g" >
			<next:TextField />
		</next:Column>
		
		
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="retiredSoldierDataset" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
