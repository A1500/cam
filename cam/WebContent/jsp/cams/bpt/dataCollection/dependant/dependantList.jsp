<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%
	response.setHeader("Expires", "Sat, 6 May 1995 12:00:00 GMT");  
	response.setHeader("Cache-Control", "no-store,no-cache,must-revalidate");  
	response.addHeader("Cache-Control", "post-check=0, pre-check=0");  
	response.setHeader("Pragma", "no-cache");  
%>
<script type="text/javascript">
   var struId = '<%=BspUtil.getStruId()%>';
   var organCode = '<%=BspUtil.getOrganCode()%>';
</script>
<html>
	<head>
		<title>三属人员信息</title>
		<next:ScriptManager/>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
		<script type="text/javascript" src="dependantList.js"></script>
		<script type="text/javascript" src="../../comm/bptComm.js"></script>
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

	<!-- 遗属信息 -->
	<model:dataset id="DependantDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptPeopleDependantQueryCommand" method="queryDepePeo" pageSize="20" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptPeopleDependant">
			<model:field name="insanityFlag" type="string" />
			<model:field name="oldLonelyFlag" type="string" />
			<model:field name="orphanFlag" type="string" />
			<model:field name="workAbilityCode" type="string" />
			<model:field name="workAbilityDescribe" type="string" />
			<model:field name="viabilityCode" type="string" />
			<model:field name="supportPattern" type="string" />
			<model:field name="jobStatusDescribe" type="string" />
			<model:field name="bank" type="string"/>
			<model:field name="accountName" type="string"/>
			<model:field name="accountCode" type="string"/>
		</model:record>
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
	<!-- 优抚对象状态 -->
	<model:dataset id="ObjectStateDataset" enumName="OBJECT.STATE" autoLoad="true" global="true"></model:dataset>
	<!-- 三属类别 -->
	<model:dataset id="DependantTypeDataset" enumName="DEPENDANT.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 户籍类别 -->
	<model:dataset id="DomicileDataset" enumName="DOMICILE.TYPE" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel  name="form" width="100%" border="0" autoScroll="true" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox">
	    <legend class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse(this)" /></legend>
				<div>
					<form style="width: 98%; height: 100%;" class="L5form">
						<table  border="1" width="100%" >
						<tr >
								<td class="FieldLabel" nowrap="nowrap">属地行政区划：</td>
								<td class="FieldInput"><input type="text"  id="domicileName" class="TextEditor" title="属地行政区划" onclick="query_selectDomicile()" />
													   <input type="hidden"  id="domicileCode" class="TextEditor" title="属地行政区划"  /></td>	
								
								<td class="FieldLabel">姓名：</td>
								<td class="FieldInput"><input type="text"  id="name" class="TextEditor" title="姓名"  /></td>	
								
								<td class="FieldLabel" nowrap="nowrap">身份证件号码：</td>
								<td class="FieldInput"><input type="text"  id="idCard" class="TextEditor" title="身份证件号码"  /></td>
								<td class="FieldLabel" nowrap="nowrap">户籍类别：</td>
								<td class="FieldInput">
									<select id="domicileType" title="户籍类别"> 
											<option dataset="DomicileDataset" ></option>
									</select>
								</td>	
								
						</tr>
							
						<tr>		
								
						
								<td class="FieldLabel" nowrap="nowrap">优抚对象状态：</td>
								<td class="FieldInput">
									<select id="disabilityStateCode" title="优抚对象状态"> 
											<option dataset="ObjectStateDataset"></option>
									</select>
								</td>
								
								<td class="FieldLabel" nowrap="nowrap">优抚对象类别：</td>
								<td class="FieldInput">
									<select id="dependantTypeCode" title="优抚对象类别"> 
											<option dataset="DependantTypeDataset"></option>
									</select>
								</td>
								<td class="FieldLabel" nowrap="nowrap">备注：</td>
								<td class="FieldInput"><input type="text"  id="note" class="TextEditor" title="备注"/></td>
								
								<td colspan="2" align="center"><button id="queryButton" onclick="query()">查 询</button>
								&nbsp;<button onclick="reset()">重 置</button></td>
						</tr>		

						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="dependantGrid" width="100%" autoScroll="true" stripeRows="true" height="98%" dataset="DependantDataset" title="三属人员信息" notSelectFirstRow="true">
				<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
					<next:ToolBarItem text="增加" iconCls="add" handler="insert" />
					<next:ToolBarItem text="修改" iconCls="edit" handler="update"/>
					<next:ToolBarItem text="查看" iconCls="detail" handler="detail"/>
					<%-- <next:ToolBarItem text="Excel导入" iconCls="detail" handler="ett"/> --%>
				</next:TopBar>
			
				<next:Columns>
				    <next:RowNumberColumn header="序号" width="45"/>
				    <next:RadioBoxColumn></next:RadioBoxColumn>
				    		
					<next:Column id="domicileCode" header="属地行政区划" field="DICNAME" width="220" >
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
			
					<next:Column id="nation" header="民族" field="NATION" width="60" dataset="NationDataset" >
						<next:TextField allowBlank="false" />
					</next:Column>
					
					<next:Column id="domicileType" header="户籍类别" field="DOMICILE_TYPE" width="60" dataset="DomicileDataset">
						<next:TextField allowBlank="false" />
					</next:Column>
					
					<next:Column id="disabilityStateCode" header="优抚对象状态" field="DEPENDANT_STATE_CODE" width="90" dataset="ObjectStateDataset">
						<next:TextField allowBlank="false" />
					</next:Column>
					
					<next:Column id="dependantTypeCode" header="优抚对象类别" field="DEPENDANT_TYPE_CODE" width="110" dataset="DependantTypeDataset">
						<next:TextField allowBlank="false" />
					</next:Column>
					
					<next:Column id="lezswName" header="烈士姓名" field="LEZSW_NAME" width="90">
						<next:TextField  />
					</next:Column>
					
					<next:Column id="lezswApproveDate" header="烈士批准时间" field="LEZSW_APPROVE_DATE" width="90">
						<next:TextField  />
					</next:Column>
					
					<next:Column id="telMobile" header="手机" field="TEL_MOBILE" width="90">
						<next:TextField  />
					</next:Column>
					
					<next:Column id="NOTE" header="备注" field="NOTE" width="90">
						<next:TextField  />
					</next:Column>
				</next:Columns>
				
				<next:BottomBar>
					<next:PagingToolBar dataset="DependantDataset"/>
				</next:BottomBar>
				
			</next:GridPanel>
</body>
</html>
