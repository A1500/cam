<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<% 
	String organCode = BspUtil.getOrganCode();
%>
<html>
<head>
<title>登记机关信息表列表</title>
<next:ScriptManager />
<script language="javascript">
			 var organCode = '<%=BspUtil.getOrganCode()%>';
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
		<script type="text/javascript" src="mrmregisorganinfoList.js"></script>
</head>
<body>
<model:datasets>
	<!--	婚姻登记机关信息	-->
	<model:dataset id="ds"
		cmd="com.inspur.cams.marry.base.cmd.MrmRegisOrganInfoQueryCommand"
		method="queryOrganInfoList" global="true">
		<model:record>
			<model:field name="areaCount" type="string"/>
		</model:record>	
	</model:dataset>
	
	<!--	婚姻登记机关信息excel导入	-->
	<model:dataset id="excelDs"
		cmd="com.inspur.cams.marry.base.cmd.MrmRegisOrganInfoQueryCommand"
		method="queryOrganInfoList" global="true">
		 	
	</model:dataset>
	
	<!-- 编制性质 -->
	<model:dataset id="bztypesDs" enumName="MRM.FORMATION.NATURE"
		autoLoad="true"></model:dataset>
		
	<!-- 机构状态 -->
	<model:dataset id="validDs" enumName="MRM.VALIDFLAG" autoLoad="true"></model:dataset>

</model:datasets>

<next:GridPanel id="editGridPanel" name="mrmregisorganinfoGrid"
	width="100%"   height="100%" dataset="ds"
	>
	<% 
		if("0000000000".equals(organCode.substring(2))) {
	%>
	<next:TopBar>
			<next:ToolBarItem symbol="->" ></next:ToolBarItem>
	        <next:ToolBarItem symbol="-" ></next:ToolBarItem>
	        <next:ToolBarItem  iconCls="djsb" text="等级评定申报查看" handler="djsb"  />
			<next:ToolBarItem symbol="-" ></next:ToolBarItem>
	        <next:ToolBarItem  iconCls="add" text="新增" handler="insert"  />
	        <next:ToolBarItem symbol="-" ></next:ToolBarItem>
	        <next:ToolBarItem  iconCls="view" text="停用" handler="stopUser"  />
	        <next:ToolBarItem symbol="-" ></next:ToolBarItem>
			<next:ToolBarItem  iconCls="print" text="打印" handler="print"  />
			<next:ToolBarItem symbol="-" ></next:ToolBarItem>
			<next:ToolBarItem iconCls="chart"  text="导出" handler="emport"/>
	</next:TopBar>
	<% 
		}
	%>
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="deptCode" header="名称" field="NAME"
			renderer="childRegsion" width="200" sortable="true">
			<next:TextField />
		</next:Column>

		<next:Column id="regionCode" header="代码" field="DEPT_CODE"
			renderer="detailRenderer" width="100" sortable="true">
			<next:TextField />
		</next:Column>

		<next:Column id="dept_address" header="地址" field="DEPT_ADDRESS"
			width="200" sortable="true">
			<next:TextField />
		</next:Column>

		<next:Column id="office_email" header="服务电话" field="DEPT_TEL"
			width="100" sortable="true">
			<next:TextField />
		</next:Column>

		<next:Column id="modify_id" header="负责人" field="MODIFY_ID" width="80"
			sortable="true">
			<next:TextField />
		</next:Column>

		<next:Column id="complain_tel" header="手机" field="COMPLAIN_TEL"
			width="120" sortable="true">
			<next:TextField />
		</next:Column>

		<next:Column id="office_email" header="邮件地址" field="OFFICE_EMAIL"
			width="120">
			<next:TextField />
		</next:Column>
		
		<next:Column id="types" header="性质" field="TYPES" width="80"
			dataset="bztypesDs">
			<next:TextField />
		</next:Column>
		
		<next:Column id="areaCount" header="总面积（平方米）" field="areaCount" width="120">
			<next:TextField />
		</next:Column>
		
		<next:Column id="valid_flag" header="状态" field="VALID_FLAG" width="80"
			dataset="validDs">
			<next:TextField />
		</next:Column>

	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds" />
	</next:BottomBar>
</next:GridPanel>
<input type="hidden" id="organId" name="printQuery" queryData="queryData" value=""/>
<input type="hidden" id="docpath" value=""/>
<input type="hidden" id="scaconfPath" value="MrmRegisOrganPrintDao/MrmRegisOrganPrintDao"/>
</body>
</html>
