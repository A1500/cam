
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
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
		<title>专项补贴标准管理</title>
		<next:ScriptManager/>
		<script>
			var organCode = '<%=BspUtil.getOrganCode()%>';
			var organName = '<%=BspUtil.getOrganName()%>';
			var username = '<%=GetBspInfo.getBspInfo(request).getUserName()%>';
			var filterAreaCode = '<%= filterAreaCode %>';
		</script>
		<script type="text/javascript" src="samspecialassistanceitem_list.js"></script>
		<script type="text/javascript" src="<%=SkinUtils.getJS(request,"cams.js") %>"></script>
        <script type="text/javascript" src="<%=SkinUtils.getJS(request, "camsCheck.js") %>" ></script>
		</script>
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
	<model:dataset id="ds" cmd="com.inspur.cams.drel.sam.cmd.SamSpecialAssistanceItemQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamSpecialAssistanceItem"></model:record>
		<model:params>
		    <model:param name="AREA_CODE" value="<%=BspUtil.getOrganCode()%>" />
		</model:params>
	</model:dataset>
	<model:dataset id="winDs" cmd="com.inspur.cams.drel.sam.cmd.SamSpecialAssistanceItemQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamSpecialAssistanceItem">
			<model:field name="itemCode" type="string" rule="require|length{50}" />
			<model:field name="target" type="string" rule="require" />
			<model:field name="frequency" type="string" rule="require" />
			<model:field name="assistanceMoney" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<model:dataset id="samAssistanceItemDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" >
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SAM_ASSISTANCE_ITEM'></model:param>
			<model:param name="value" value='ITEM_CODE'></model:param>
			<model:param name="text" value='ITEM_NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="queryDs" cmd="com.inspur.cams.drel.sam.cmd.SamSpecialAssistanceItemQueryCmd" sortField="REG_TIME" sortDirection="desc">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamSpecialAssistanceItem"></model:record>
		<model:params>
		    <model:param name="AREA_CODE" value="<%=BspUtil.getOrganCode()%>" />
		</model:params>
	</model:dataset>
	<model:dataset id="frequencyDataSet" enumName="SAM.SPEC.GRANT.FREQUENCY.TYPE" autoLoad="true" global="true" />
	<model:dataset id="targetToDataSet" enumName="SAM.RELEASE.TARGET" autoLoad="true" global="true" />
	<model:dataset id="YorN" enumName="COMM.YESORNO" autoLoad="true" global="true" />
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
								<td class="FieldLabel" style='width:20%'>专项补贴类别</td>
								<td class="FieldInput" style='width:20%'>
									<select id="itemCodeQuery" class="TextEditor" title="专项补贴类别"  style='width:80%'>
										<option dataset='samAssistanceItemDataset'/>
									</select>
								</td>	
								<td class="FieldLabel" style='width:20%'>发放频率</td>
								<td class="FieldInput" style='width:20%'><select id="frequencyQuery" class="TextEditor" title="发放频率" style='width:80%'> <option dataset = "frequencyDataSet"></option> </select></td>	
								<td class="FieldButton" style='width:20%' style="text-align: center;"><button onclick="query()">查 询</button></td>
							</tr>
							<tr>
								<td class="FieldLabel">发放分类</td>
								<td class="FieldInput"><select id="targetQuery" class="TextEditor" title="发放分类" style='width:80%'> <option dataset = "targetToDataSet"></option> </select></td>	
								<td class="FieldLabel">使用状态</td>
								<td class="FieldInput">
									<select id="inUseQuery" class="TextEditor" title="使用状态" style='width:80%'>
										<option>请选择...</option> 
										<option value='1'>启用</option> 
										<option value='0'>停用</option> 
									</select> 
								</td>	
								<td class="FieldButton" style="text-align: center;"><button  onclick="reset()">重 置</button> </td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="samspecialassistanceitemGrid" width="100%" stripeRows="true" height="100%" dataset="ds" title="专项补贴标准列表">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="增加" iconCls="add" handler="insert" />
		<next:ToolBarItem text="修改" iconCls="edit" handler="update"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:RadioBoxColumn></next:RadioBoxColumn>	 
		<next:Column header="内码" field="itemId" width="15%"  hidden="true"><next:TextField /></next:Column>
		<next:Column header="专项补贴类别" field="itemCode" width="200" dataset='samAssistanceItemDataset'>
			<next:TextField  />
		</next:Column>
		
		<next:Column header="发放频率" field="frequency" dataset = "frequencyDataSet" width="120" align='center'>
			<next:TextField  />
		</next:Column>
	
		<next:Column header="发放分类" field="target"  dataset = "targetToDataSet" width="120" align='center'>
			<next:TextField  />
		</next:Column>
	
		<next:Column header="补贴金额（元）" field="assistanceMoney" align="right" width="120" renderer="formatNum">
			<next:NumberField  />
		</next:Column>
	
		<next:Column header="使用状态" field="inUse" width="120" renderer='getInUse' align='center'>
			<next:TextField  />
		</next:Column>
	
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>


<!-- 添加 -->
<next:Window id="addWin" closable="false" title="专项补贴标准维护" width="740" closeAction="hide" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="保存" iconCls="save" handler="save"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="winDs" onsubmit="return false" class="L5form">
			<input type='hidden' field='itemId'/>
		<table width="100%" >
		
	   		<tr>
				<td class="FieldLabel" style='width:20%'>专项补贴类别</td>
				<td class="FieldInput" style='width:30%'>
					<select name="专项补贴类别" id='itemCode' field="itemCode" style='width:80%' onblur='checkItemCode()'>
						<option dataset='samAssistanceItemDataset'/>
					</select><label style='color:red'>*</label>
				</td>
			
				<td class="FieldLabel" style='width:20%'>发放分类</td>
				<td class="FieldInput" style='width:30%'>
					<select name="发放分类" field="target" title="发放分类" style='width:80%'> 
						<option dataset = "targetToDataSet"></option> 
					</select><label style='color:red'>*</label>
				</td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >发放频率</td>
				<td class="FieldInput">
					<select name="发放频率" field="frequency" title="发放频率" style='width:80%'> 
						<option dataset = "frequencyDataSet"></option> 
					</select><label style='color:red'>*</label> 
				</td>
				
				<td  class="FieldLabel" >补贴金额（元）</td>
				<td class="FieldInput"><input id = "assistanceMoney" name="补贴金额（元）" field="assistanceMoney"  style='width:80%'/><label style='color:red'>*</label></td>
			
			</tr>
	   		<tr>
				<td class="FieldLabel">使用状态</td>
				<td class="FieldInput">
					<select field="inUse" name="使用状态" style='width:80%'>
						<option value='1'>启用</option> 
						<option value='0'>停用</option> 
					</select><label style='color:red'>*</label>
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
