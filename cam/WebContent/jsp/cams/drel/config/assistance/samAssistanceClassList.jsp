<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="com.inspur.cams.comm.util.DateUtil"%>
<%
	String areaCode = BspUtil.getOrganCode();  
	String filterAreaCode="";
	if(areaCode.endsWith("0000000000")){
		filterAreaCode=areaCode;
	}else if (areaCode.endsWith("00000000")){
		filterAreaCode=areaCode+","+areaCode.substring(0,2)+"0000000000";
	}else if (areaCode.endsWith("000000")){
		filterAreaCode=areaCode+","+areaCode.substring(0,4)+"00000000"+","+areaCode.substring(0,2)+"0000000000";
	}
%>
<html>
<head>
<title>分类施保标准管理</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="samAssistanceClassList.js"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request,"cams.js") %>"></script>
<script type="text/javascript">
	var currentOrganCode = '<%=BspUtil.getOrganCode()%>' ;
	var nowTime= '<%=DateUtil.getDay()%>';
	var filterAreaCode = '<%= filterAreaCode %>';
</script>
</head>
<body>

<model:datasets>
	<model:dataset id="samAssistanceClassList" cmd="com.inspur.cams.drel.config.assistance.cmd.SamAssistanceClassQueryCmd" global="true" sortField="BEGIN_DATE">
		<model:record fromBean="com.inspur.cams.drel.config.assistance.data.SamAssistanceClass"></model:record>
	</model:dataset>
	<model:dataset id="winAssistanceClassDataSet" cmd="com.inspur.cams.drel.config.assistance.cmd.SamAssistanceClassQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.config.assistance.data.SamAssistanceClass">
			<model:field name="assistanceType" type="string" rule="require"/>	
			<model:field name="target" type="string" rule="require"/>					
			<model:field name="computeMode" type="string" rule="require"/>
			<model:field name="computeValue" type="string" rule="require"/>			
			<model:field name="areaCode" type="string" rule="require"/>		
			<model:field name="inUse" type="string" rule="require"/>
		</model:record>
	</model:dataset>
	<model:dataset id="samAssistanceClassQueryDataset" cmd="com.inspur.cams.drel.config.assistance.cmd.SamAssistanceClassQueryCmd" sortField="REG_TIME" sortDirection="desc">
		<model:record fromBean="com.inspur.cams.drel.config.assistance.data.SamAssistanceClass"></model:record>
	</model:dataset>
	<model:dataset id="assistanceTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_ASSITANCE_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>	
	<model:dataset id="samAssistanceItemDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" >
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SAM_ASSISTANCE_ITEM'></model:param>
			<model:param name="value" value='ITEM_CODE'></model:param>
			<model:param name="text" value='ITEM_NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="citySelect" autoLoad="false" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CITY'></model:param>
			<model:param name="value" value='ID'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>	
	<model:dataset id="targetDataSet" enumName="SAM.RELEASE.TARGET" autoLoad="true" global="true" />
</model:datasets>
<next:Panel  name="form" width="100%" border="0" autoHeight="true" >
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
								<td class="FieldLabel" style='width:20%'>救助对象类别</td>
								<td class="FieldInput" style='width:20%'>
									<select  title="专项补贴类别" id='queryassistanceType' style='width:80%'>
										<option dataset='assistanceTypeSelect'/>
									</select>
								</td>	
								<td class="FieldLabel" style='width:20%'>使用状态</td>
								<td class="FieldInput" style='width:20%'><select title="使用状态" id="queryinUse" style='width:80%'>
								<option value="">请选择……</option>
								<option value="1">启用</option>
								<option value="0">停用</option>
								</select></td>	
								<td class="FieldButton" style='width:20%' style="text-align: center;">
								<button onclick="query()">查 询</button>&nbsp;&nbsp;
								<button type="reset">重 置</button></td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>
<next:GridPanel id="assistanceClassGrid" title='分类施保标准列表' dataset="samAssistanceClassList" height="100%"  width="100%" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="新增" iconCls="add" handler="insert"></next:ToolBarItem>
		<next:ToolBarItem text="修改" iconCls="edit" handler="update" ></next:ToolBarItem>
		<next:ToolBarItem text="停用" iconCls="delete" handler="stop"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn/>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column header="内码" field="assistanceClassId" width="15%"  hidden="true"><next:TextField /></next:Column>
		<next:Column header="救助对象类别" field="assistanceType" width="10%" dataset='assistanceTypeSelect'><next:TextField /></next:Column>
		<next:Column header="分类施保类别" field="assistanceClassCode" width="15%" dataset='samAssistanceItemDataset'><next:TextField /></next:Column>
		<next:Column header="发放分类" field="target"  dataset = "targetDataSet" width="120" align='center'><next:TextField  /></next:Column>
		<next:Column header="计算方式" field="computeMode" width="15%" renderer='getComputeMode'><next:TextField/></next:Column>
		<next:Column header="计算金额或浮动比例"  field="computeValue" align="right" renderer='formateComPuteValue' width="15%"><next:TextField/></next:Column>
		<next:Column header="启用日期" field="beginDate"  align="center" width="127"><next:TextField/></next:Column>
		<next:Column header="停用日期" field="endDate"   align="center" width="127" renderer='formateEndDate'><next:TextField/></next:Column>
		<next:Column header="使用状态" field="inUse" align="center" width="10%" renderer='getInUse'><next:TextField/></next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="samAssistanceClassList" />
	</next:BottomBar>
</next:GridPanel>
<next:Window id="assistanceClassWin" title="分类施保标准维护" closeAction="hide"  width="740" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="confirmWin"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="closeWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form dataset="winAssistanceClassDataSet"  onsubmit="return false"  class="L5form">
			<input type='hidden' field='assistanceClassId'/>
			<input type='hidden' field='assistanceClassCode'/>
			<table width='100%'>
				<tr>
					<td class="FieldLabel" ><label>救助对象类别</label></td>
					<td class="FieldInput">
						<select name="救助对象类别" id="assistanceType" field="assistanceType" style="width:85%" onblur='checkAssistanceClassCode()'>
							<option dataset='assistanceTypeSelect'></option>
						</select><span style="color:red">*</span>
					</td>
                    <td class="FieldLabel" >分类施保类别</td>
                    <td class="FieldInput">
                        <select name="分类施保类别" id="assistanceClassCode" field="assistanceClassCode" style="width:85%" onblur='checkAssistanceClassCode()'>
                        	<option dataset='samAssistanceItemDataset'/> 
                        </select><span style="color:red">*</span>
                    </td>
				</tr>
				<tr>
					<td class="FieldLabel" style='width:20%'>发放分类</td>
					<td class="FieldInput" style='width:30%'>
						<select name="发放分类" field="target" title="发放分类" style='width:85%'> 
							<option dataset = "targetDataSet"></option> 
						</select><label style='color:red'>*</label>
					</td>		
				    <td class="FieldLabel" style="width:20%"><label>计算方式</label></td>
                    <td class="FieldInput" style="width:30%">
                        <select name="计算方式" id="computeMode" field="computeMode" style="width:85%" onChange="setValueUnit()" style="width:85%">   
                            <option>请选择...</option>
                            <option value='01'>增加固定金额</option>
                            <option value='02'>低保金按比例上浮</option>
                        </select><span style="color:red">*</span>
                    </td>
				</tr>
				<tr>
					<td class="FieldLabel" id="valueLabel" style="width:20%">增加金额或上浮比例</td>
					<td class="FieldInput" style="width:30%">
						<input type="text" name="计算金额或浮动比例" id="computeValue" field="computeValue" style="width:85%"/>
						<span style="color:red">*</span>
					</td>
					<td class="FieldLabel"></td>
					<td class="FieldInput"></td>
                </tr>
			</table>
		</form>
   </next:Html>
</next:Window>
</body>
</html>