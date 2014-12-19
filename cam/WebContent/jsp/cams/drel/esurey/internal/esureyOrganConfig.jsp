
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%
    String filterAreaCode="";
    String areaCode = BspUtil.getOrganCode();
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
		<title>SAM_ESUREY_ORGAN_CONFIG</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="esureyOrganConfig.js"></script>
		<script language="javascript">
		  var organId = '<%= BspUtil.getCorpOrganId() %>';
		  var filterAreaCode = '<%= filterAreaCode %>';
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyOrganConfigQueryCmd" global="true" sortField="EXT_ORGAN_TYPE">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyOrganConfig"></model:record>
	</model:dataset>
	<model:dataset id="extOrganDs" cmd="com.inspur.cams.comm.extuser.cmd.ComExtOrganQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.extuser.data.ComExtOrgan"></model:record>
	</model:dataset>	
	<model:dataset id="organType"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='COM_EXT_ORGAN_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	
</model:datasets>	

<next:EditGridPanel id="editGridPanel" name="samesureyorganconfigGrid" width="100%" stripeRows="true" height="99.9%"  dataset="ds" >
	<next:TopBar>
			<next:ToolBarItem symbol="->" ></next:ToolBarItem>
	        <next:ToolBarItem symbol="-" ></next:ToolBarItem>
			<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>	     
		<next:Column id="organId" header="ORGAN_ID" field="organId" width="95" hidden="true">			
			<next:TextField allowBlank="false" />
		</next:Column>
	    <next:Column id="extOrganType" header="单位类型" field="extOrganType" dataset="organType" align="center" width="150" editable="false">			
			<next:TextField  />
		</next:Column>
		<next:Column id="extOrganName" header="单位名称" field="extOrganName" width="250" >
		    <next:TriggerField id="extOrganNameTri" hideTrigger="false" enableKeyEvents="false" 
							onTriggerClick="onOrganSelect" readOnly="true" />	
		</next:Column>	
		<next:Column id="extOrganId" header="外部单位id" field="extOrganId" hidden="true" >			
			<next:ComboBox dataset="extOrganDs" ></next:ComboBox>
		</next:Column>			
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:EditGridPanel>

<next:GridHelpWindow id="helpWin" dataset="extOrganDs">
	<next:GridHelpColumns>
	    <next:GridHelpColumn header="单位名称" sortable="true" field="organName" />
	</next:GridHelpColumns>
	<next:TextHelpField>
	    <next:QueryHelpField header="单位名称"  field="ORGAN_NAME"></next:QueryHelpField>
	</next:TextHelpField>
</next:GridHelpWindow>
</body>
</html>
