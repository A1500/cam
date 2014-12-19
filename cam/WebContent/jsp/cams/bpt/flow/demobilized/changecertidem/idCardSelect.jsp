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

	<!-- 在乡复员信息 -->
	<model:dataset id="BptPeopleDisabilityDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptPeopleDemobilizedQueryCommand" method="queryDemobilizedBptPeopleGetIdCard" global="true"></model:dataset>
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
	<!-- 是否抗美援朝 -->
	<model:dataset id="isKoeanwar" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 属于时期-->
	<model:dataset id="warDs" enumName="DEMOBILIZED.BELONGDATE"  autoLoad="true" global="true"></model:dataset>
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
								<td class="FieldLabel" nowrap="nowrap">是否抗美援朝：</td>
								<td class="FieldInput">
									<select id="isKoeanwar"> 
											<option dataset="isKoeanwar"></option>
									</select>
								</td>
								<td class="FieldLabel" nowrap="nowrap">所属时期：</td>
								<td class="FieldInput">

									<select id="belongDate"> 
											<option dataset="warDs"></option>
									</select> 
								</td>	
								<td class="FieldLabel" nowrap="nowrap">证书编号：</td>
								<td class="FieldInput"><input type="text"  id="demobilizedNo" class="TextEditor" title="证书编号"/></td>
								<td class="FieldInput" colspan="2">
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

<next:GridPanel id="editGridPanel" name="baseinfopeopleGrid" width="100%" stripeRows="true" height="100%" dataset="BptPeopleDisabilityDataSet" title="在乡复员人员信息" notSelectFirstRow="true">
				<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
					<next:ToolBarItem text="查看" iconCls="detail" handler="detail"/>
				</next:TopBar>
			
				<next:Columns>
				    <next:RowNumberColumn header="序号" width="45"/>
				    <next:RadioBoxColumn></next:RadioBoxColumn>
				    		
					<next:Column id="domicileCode" header="属地行政区划" field="DOMI_NAME" width="140" >
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
					
					<next:Column id="belongDate" header="所属时期" field="BELONGDATE" width="90" dataset="warDs" >
						<next:TextField allowBlank="false" />
					</next:Column>
					
					<next:Column id="demobilizedNo" header="证书编号" field="DEMOBILIZED_NO" width="90">
						<next:TextField allowBlank="false" />
					</next:Column>
					
					<next:Column id="telMobile" header="手机" field="TEL_MOBILE" width="90">
						<next:TextField  />
					</next:Column>
					
					<next:Column id="note" header="备注" field="NOTE" width="90">
						<next:TextField  />
					</next:Column>
					
				</next:Columns>
				
				<next:BottomBar>
					<next:PagingToolBar dataset="BptPeopleDisabilityDataSet"/>
				</next:BottomBar>
				
			</next:GridPanel>
</body>
</html>
