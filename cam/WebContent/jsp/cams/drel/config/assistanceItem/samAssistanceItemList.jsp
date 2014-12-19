<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%
    String itemType=request.getParameter("itemType"); 
	String title="";
	String winTitle="";
	String labelName="";
	if("01".equals(itemType)){
		title="分类施保类别列表";
		winTitle="分类施保类别维护";
		labelName="分类施保类别";
	}else if("02".equals(itemType)){
		title="专项补贴类别列表";
		winTitle="专项补贴类别维护";
		labelName="专项补贴类别";
	}
	
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
<title>救助项目管理</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="samAssistanceItemList.js"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request,"cams.js") %>"></script>
<script type="text/javascript">
	var itemType = '<%=itemType%>';
	var title = '<%=title%>';
	var winTitle = '<%=winTitle%>';
	var labelName = '<%=labelName%>';
	
	var areaCode = '<%=areaCode%>' ;
	var areaName = '<%=BspUtil.getOrganName()%>';
	var filterAreaCode = '<%= filterAreaCode %>';
</script>
</head>
<body>

<model:datasets>
	<model:dataset id="samAssistanceItemList" cmd="com.inspur.cams.drel.config.assistance.cmd.SamAssistanceItemQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.config.assistance.data.SamAssistanceItem"></model:record>
		<model:params>
			<model:param name="ITEM_TYPE" value="<%=itemType%>" />
		</model:params>
	</model:dataset>
	<model:dataset id="winSamAssistanceItemDataset" cmd="com.inspur.cams.drel.config.assistance.cmd.SamAssistanceItemQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.config.assistance.data.SamAssistanceItem">
			<model:field name="itemName" type="string" rule="require|length{50}" />
			<model:field name="status" type="string" rule="require" />
			<model:field name="remarks" type="string" rule="length{250}" />		
		</model:record>
	</model:dataset>
	<model:dataset id="samAssistanceItemQueryDataset" cmd="com.inspur.cams.drel.config.assistance.cmd.SamAssistanceItemQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.config.assistance.data.SamAssistanceItem"></model:record>
		<model:params>
			<model:param name="ITEM_TYPE" value="<%=itemType%>" />
		</model:params>
	</model:dataset>
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
								<td class="FieldLabel" style='width:20%'><%=labelName %></td>
								<td class="FieldInput" style='width:20%'>
								<input type="text" id="queryName"  style='width:80%'/>
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
<next:GridPanel id="assistanceItemGrid" title='<%=title %>' dataset="samAssistanceItemList" height="100%"  width="100%" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="新增" iconCls="add" handler="insert"></next:ToolBarItem>
		<next:ToolBarItem text="修改" iconCls="edit" handler="update" ></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn/>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column header="项目编码" field="itemCode" width="15%" hidden='true'><next:TextField /></next:Column>
		<next:Column header="<%=labelName %>" field="itemName" width="20%" ><next:TextField /></next:Column>
		<next:Column header="录入单位" field="areaName" align="center" width="20%" ><next:TextField /></next:Column>
		<next:Column header="使用状态" field="status" align="center" width="10%" renderer='getStatus'><next:TextField/></next:Column>
		<next:Column header="备注" field="remarks" width="30%" ><next:TextField /></next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="samAssistanceItemList" />
	</next:BottomBar>
</next:GridPanel>

<next:Window id="assistanceItemWin" title='<%=winTitle %>' closeAction="hide" width="800" modal="true">
    <next:TopBar>
        <next:ToolBarItem symbol="->"/>
        <next:ToolBarItem iconCls="save" text="保存" handler="confirmWin"/>
        <next:ToolBarItem iconCls="return" text="关闭" handler="closeWin"/>
    </next:TopBar>
    <next:Html>
        <form onsubmit="return false" dataset='winSamAssistanceItemDataset' class="L5form">
        	<input type='hidden' field='itemCode' id='itemCode'/>
            <table width='100%'>
               <tr>
                  <td class="FieldLabel" style="width:15%"><%=labelName %></td>
                  <td class="FieldInput" style="width:35%"><input name="<%=labelName %>" id='itemName' field="itemName" style="width:90%" onblur='checkItemName()'><span style="color:red">*</span></td>
                  <td class="FieldLabel" style="width:15%">使用状态</td>
				  <td class="FieldInput" style="width:35%">
					<select field="status" name="使用状态" style='width:90%'>
						<option value='1'>启用</option> 
						<option value='0'>停用</option> 
					</select><span style="color:red">*</span>
				  </td>
               </tr>
               <tr> 
                  <td class="FieldLabel" style="width:15%">备注</td>
                  <td class="FieldInput" colspan='3'>
                  	<textarea name="备注" field="remarks" style="width:96%" rows='5'></textarea>
                  </td>
               </tr>   
            </table>
        </form>
   </next:Html>   
</next:Window>
</body>
</html>