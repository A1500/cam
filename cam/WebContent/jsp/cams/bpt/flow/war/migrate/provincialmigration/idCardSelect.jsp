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
		<script type="text/javascript" src="idCardSelect.js"></script>
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
	<!-- 参战信息 -->
	<model:dataset id="ProvinceMigratDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptProvinceMigrateQueryCommand" method="queryWarDetail" global="true">
	</model:dataset>
    <!-- 民族 -->
	<model:dataset id="NationDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset> 
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	<!-- 参战类别 -->
	<model:dataset id="warTypeCodeDataset" enumName="WARTYPE.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 生活状况 -->
	<model:dataset id="lifeState" enumName="LIFE.LIFE_STATE_CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 健康状况 -->
	<model:dataset id="healthState" enumName="HEALTH.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 户籍类别 -->
	<model:dataset id="DomicileDataset" enumName="DOMICILE.TYPE" autoLoad="true" global="true"></model:dataset>
	
		
</model:datasets>
<next:Panel  name="form" width="100%" border="0" autoScroll="true" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
		<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem id="saveButoon" iconCls="yes" text="确定" handler="confirmValue()"></next:ToolBarItem>
				<next:ToolBarItem id="closeButoon" iconCls="no" text="关闭" handler="closew()"></next:ToolBarItem>
				<next:ToolBarItem id="closeButoon" iconCls="no" text="清除" handler="clears()"></next:ToolBarItem>
		</next:TopBar>
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox"><legend class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request, "groupbox_collapse.gif")%>" onclick="collapse(this)" /></legend>
				<div>
					<form style="width: 98%; height: 100%;" class="L5form">
						<table  border="1" width="100%" >
							<tr >
								<td class="FieldLabel" nowrap="nowrap">所属机构：</td>
								<td class="FieldInput"><input type="text"  id="domicileName" class="TextEditor" title="属地行政区划" onclick="forHelp()" />
													   <input type="hidden"  id="domicileCode" class="TextEditor" title="属地行政区划"  /></td>	
								
								<td class="FieldLabel">姓名：</td>
								<td class="FieldInput"><input type="text"  id="name" class="TextEditor" title="姓名"  /></td>	
								
								<td class="FieldLabel" nowrap="nowrap">身份证件号码：</td>
								<td class="FieldInput"><input type="text"  id="idCard" class="TextEditor" title="身份证件号码"  /></td>
							</tr>
							<tr>	
								<td class="FieldLabel">户籍类别：</td>
								<td class="FieldInput">
									<select id="domicileType"> 
											<option dataset="DomicileDataset" ></option>
									</select>
								</td>	
								
								<td class="FieldLabel" nowrap="nowrap">参战类别：</td>
								<td class="FieldInput">
									<select id="warTypeCode"> 
											<option dataset="warTypeCodeDataset" ></option>
									</select>
								</td>
								<td class="FieldLabel" nowrap="nowrap">原部队代号：</td>
								<td class="FieldInput">
									<input type="text"  id="forcesNo" class="TextEditor" />
								</td>
							</tr>
							<tr>
								<td class="FieldLabel" nowrap="nowrap">职务级别：</td>
								<td class="FieldInput">
									<input type="text"  id="position" class="TextEditor" />
								</td>
									
								<td class="FieldLabel" nowrap="nowrap">退伍证号：</td>
								<td class="FieldInput">
									<input type="text"  id="asdpNo" class="TextEditor" />
								</td>
								<td class="FieldButton" colspan="2"> 
									<button onclick="query()">查 询</button> 
									&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
									<button onclick="reset()">重 置</button>
								</td>
								
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="baseinfopeopleGrid" width="100%" stripeRows="true" height="100%" dataset="ProvinceMigratDataSet" title="参战人员信息" notSelectFirstRow="true">
				<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
					<next:ToolBarItem text="查看" iconCls="detail" handler="detail"/>
				</next:TopBar>
			
				<next:Columns>
				    <next:RowNumberColumn width="45"/>
				    <next:RadioBoxColumn></next:RadioBoxColumn>
				    		
					<next:Column id="qdomicileCode" header="属地行政区划" field="DOMI_NAME" width="140" >
						<next:TextField allowBlank="false" />
					</next:Column>
			
					<next:Column id="qname" header="姓名" field="NAME" width="60">
						<next:TextField allowBlank="false" />
					</next:Column>
					
					<next:Column id="qidCard" header="身份证件号码" field="ID_CARD" width="140">
						<next:TextField allowBlank="false" />
					</next:Column>
				
					<next:Column id="qsex" header="性别" field="SEX" width="35"  dataset="SexDataset" >
						<next:TextField allowBlank="false" />
					</next:Column>
			
					<next:Column id="qnation" header="民族" field="NATION" width="90" dataset="NationDataset" >
						<next:TextField allowBlank="false" />
					</next:Column>
					
					<next:Column id="qdomicileType" header="户籍类别" field="DOMICILE_TYPE" width="90" dataset="DomicileDataset">
						<next:TextField allowBlank="false" />
					</next:Column>
					
					<next:Column id="qforcesNo" header="原部队代号" field="FORCES_NO" width="90" >
						<next:TextField allowBlank="false" />
					</next:Column>
					
					<next:Column id="qposition" header="职务" field="POSITION" width="90" >
						<next:TextField allowBlank="false" />
					</next:Column>
					
					<next:Column id="qwarTypeCode" header="参战类别" field="WAR_TYPE_CODE" width="90" dataset="warTypeCodeDataset">
						<next:TextField allowBlank="false" />
					</next:Column>
					
					<next:Column id="qenjoyMon" header="享受待遇" field="ENJOY_MON" width="90" >
						<next:TextField allowBlank="false" />
					</next:Column>
					
					<next:Column id="qlifeStateCode" header="生活状况代码" field="LIFE_STATE_CODE" width="90" dataset="lifeState">
						<next:TextField allowBlank="false" />
					</next:Column>
					
					<next:Column id="qhealthStateCode" header="健康状况代码" field="HEALTH_STATE_CODE" width="90" dataset="healthState">
						<next:TextField allowBlank="false" />
					</next:Column>
					
					<next:Column id="qconscriptcDate" header="入伍（参加工作）时间" field="CONSCRIPTC_DATE" width="90" >
						<next:TextField allowBlank="false" />
					</next:Column>
					
					<next:Column id="qdecuitmentDate" header="退伍（离退休）时间" field="DECRUITMENT_DATE" width="90" >
						<next:TextField allowBlank="false" />
					</next:Column>
					
					<next:Column id="qasdpNo" header="退伍证号" field="ASDP_NO" width="90" >
						<next:TextField allowBlank="false" />
					</next:Column>
					
					<next:Column id="qnote" header="备注" field="NOTE" width="90" >
						<next:TextField allowBlank="false" />
					</next:Column>
				</next:Columns>
				
				<next:BottomBar>
					<next:PagingToolBar dataset="ProvinceMigratDataSet"/>
				</next:BottomBar>
				
			</next:GridPanel>
</body>
</html>
