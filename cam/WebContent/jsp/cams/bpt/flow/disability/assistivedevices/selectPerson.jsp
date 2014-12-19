<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<script type="text/javascript">
   var struId = '<%=BspUtil.getStruId()%>';
   var organCode = '<%=BspUtil.getOrganCode()%>';
</script>
<html>
	<head>
		<title>基础信息_人员信息列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="selectPerson.js"></script>
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

	<!-- 伤残信息 -->
	<model:dataset id="BptPeopleDisabilityDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptPeopleDisabilityQueryCommand" method="queryDisabilityBptPeople" global="true">
	</model:dataset>

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
	
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	
	<!-- 优抚对象状态 -->
	<model:dataset id="ObjectStateDataset" enumName="OBJECT.STATE" autoLoad="true" global="true"></model:dataset>
	
	<!-- 户籍类别 -->
	<model:dataset id="DomicileDataset" enumName="DOMICILE.TYPE" autoLoad="true" global="true"></model:dataset>
	
	<!-- 伤残类别代码 -->
	<model:dataset id="DisabilityTypeCodeEnum" enumName="DISABILITY.TYPE.CODE" autoLoad="true" global="true"></model:dataset>
	
	<!-- 伤残性质 -->
	<model:dataset id="DisabilityCaseDataset" enumName="CASE.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残等级 -->
	<model:dataset id="DisabilityLevelDataset" enumName="LEVEL.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残属别 -->
	<model:dataset id="DisabilityGenusDataset" enumName="GENUS.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残时期 -->
	<model:dataset id="BptWarDataset" enumName="WAR.CODE" autoLoad="true" global="true"></model:dataset>
		
</model:datasets>
<next:Panel  name="form" width="100%" border="0" autoScroll="true" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
		<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem id="saveButoon" iconCls="yes" text="确定" handler="confirmValue()"></next:ToolBarItem>
				<next:ToolBarItem id="closeButoon" iconCls="no" text="关闭" handler="closew()"></next:ToolBarItem>
				<next:ToolBarItem id="closeButoon" iconCls="no" text="清除" handler="clears()"></next:ToolBarItem>
		</next:TopBar>
	
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox"><legend
					class="GroupBoxTitle">查询条件 <img
					class="GroupBoxExpandButton"
					src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
					onclick="collapse(this)" /> </legend>
				<div>
					<form style="width: 98%; height: 100%;" class="L5form">
						<table  border="1" width="100%" >
							<tr >
								<td class="FieldLabel" nowrap="nowrap">所属机构：</td>
								<td class="FieldInput"><input type="text"  id="domicileName" class="TextEditor" title="属地行政区划" onclick="forHelp()" />
													   <input type="hidden"  id="domicileCode" class="TextEditor" title="属地行政区划"  /></td>	
								
								<td class="FieldLabel">姓名：</td>
								<td class="FieldInput"><input type="text"  id="name" class="TextEditor" title="姓名"/></td>	
								
								<td class="FieldLabel" nowrap="nowrap">身份证件号码：</td>
								<td class="FieldInput"><input type="text"  id="idCard" class="TextEditor" title="身份证件号码"  /></td>
								
								<td class="FieldLabel">户籍类别：</td>
								<td class="FieldInput">
									<select id="domicileType"> 
											<option dataset="DomicileDataset" ></option>
									</select>
								</td>	
							</tr>
							
							<tr>	
								<td class="FieldLabel" nowrap="nowrap">优抚对象状态：</td>
								<td class="FieldInput">
									<select id="disabilityStateCode" disabled="disabled"> 
											<option dataset="ObjectStateDataset"></option>
									</select>
								</td>
								
								<td class="FieldLabel" nowrap="nowrap">伤残类别：</td>
								<td class="FieldInput">
									<select id="disabilityTypeCode"> 
											<option dataset="DisabilityTypeCodeEnum"></option>
									</select>
								</td>
								
								<td class="FieldLabel" nowrap="nowrap">伤残等级：</td>
								<td class="FieldInput">
									<select id="disabilityLevelCode"> 
											<option dataset="DisabilityLevelDataset"></option>
									</select>
								</td>
								
								<td class="FieldLabel" nowrap="nowrap">伤残性质：</td>
								<td class="FieldInput">
									<select id="disabilityCaseCode"> 
											<option dataset="DisabilityCaseDataset"></option>
									</select>
								</td>
							</tr>
							
							<tr>
								<td class="FieldLabel" nowrap="nowrap">伤残属别：</td>
								<td class="FieldInput">
									<select id="disabilityGenusCode"> 
											<option dataset="DisabilityGenusDataset"></option>
									</select>
								</td>
								
								<td class="FieldLabel" nowrap="nowrap">伤残时期：</td>
								<td class="FieldInput">
									<select id="disabilityWarCode"> 
											<option dataset="BptWarDataset"></option>
									</select>
								</td>	
								
								
								<td class="FieldLabel"> </td>
								<td class="FieldInput" colspan="3">
													&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
													<button onclick="query()">查 询</button>
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
													   <button onclick="reset()">重 置</button> </td>	
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="baseinfopeopleGrid" width="100%" stripeRows="true" height="100%" dataset="BptPeopleDisabilityDataSet" title="伤残人员信息" notSelectFirstRow="true">
				<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
					<next:ToolBarItem text="查看" iconCls="detail" handler="detail"/>
				</next:TopBar>
			
				<next:Columns>
				    <next:RowNumberColumn header="序号" width="45"/>
				    <next:RadioBoxColumn></next:RadioBoxColumn>
				    		
					<next:Column id="domicileCode" header="属地行政区划" field="DICNAME" width="140" >
						<next:TextField allowBlank="false" />
					</next:Column>
			
					<next:Column id="name" header="姓名" field="NAME" width="60">
						<next:TextField allowBlank="false" />
					</next:Column>
					
					<next:Column id="idCard" header="身份证件号码" field="ID_CARD" width="140">
						<next:TextField allowBlank="false" />
					</next:Column>
				
					<next:Column id="sex" header="性别" field="SEX" width="35"  dataset="SexDataset" >
						<next:TextField allowBlank="false" />
					</next:Column>
			
					<next:Column id="nation" header="民族" field="NATION" width="90" dataset="NationDataset" >
						<next:TextField allowBlank="false" />
					</next:Column>
					
					<next:Column id="domicileType" header="户籍类别" field="DOMICILE_TYPE" width="90" dataset="DomicileDataset">
						<next:TextField allowBlank="false" />
					</next:Column>
					
					<next:Column id="disabilityStateCode" header="优抚对象状态" field="DISABILITY_STATE_CODE" width="90" dataset="ObjectStateDataset">
						<next:TextField allowBlank="false" />
					</next:Column>
					
					<next:Column id="disabilityTypeCode" header="伤残类别" field="DISABILITY_TYPE_CODE" width="140" dataset="DisabilityTypeCodeEnum">
						<next:TextField allowBlank="false" />
					</next:Column>
			
					<next:Column id="disabilityLevelCode" header="伤残等级" field="DISABILITY_LEVEL_CODE" width="60" dataset="DisabilityLevelDataset">
						<next:TextField  />
					</next:Column>
			
					<next:Column id="disabilityCaseCode" header="伤残性质" field="DISABILITY_CASE_CODE" width="90" dataset="DisabilityCaseDataset">
						<next:TextField  />
					</next:Column>
				
					<next:Column id="disabilityGenusCode" header="伤残属别" field="DISABILITY_GENUS_CODE" width="60" dataset="DisabilityGenusDataset">
						<next:TextField  />
					</next:Column>
				
					<next:Column id="disabilityWarCode" header="伤残时期" field="DISABILITY_WAR_CODE" width="90" dataset="BptWarDataset">
						<next:TextField  />
					</next:Column>
					
					<next:Column id="telMobile" header="手机" field="TEL_MOBILE" width="90">
						<next:TextField  />
					</next:Column>
					
				</next:Columns>
				
				<next:BottomBar>
					<next:PagingToolBar dataset="BptPeopleDisabilityDataSet"/>
				</next:BottomBar>
				
			</next:GridPanel>
</body>
</html>
