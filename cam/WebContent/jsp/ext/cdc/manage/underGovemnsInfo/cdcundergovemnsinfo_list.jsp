
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
<html>
	<head>
		<title>下辖村情况基本信息列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="cdcundergovemnsinfo_list.js"></script>
		
		<script language="javascript">
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
	<model:dataset id="ds" cmd="com.inspur.cams.cdc.base.cmd.CdcUnderGovemnsInfoQueryCommand" method="queryUnder" pageSize="15" global="true">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcUnderGovemnsInfo"></model:record>
	</model:dataset>
</model:datasets>
<next:GridPanel id="editGridPanel" name="cdcundergovemnsinfoGrid" clickToSelectedForChkSM="true" width="100%" stripeRows="true" notSelectFirstRow="true" height="99%" dataset="ds" title="下辖村情况基本信息">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="增加" hidden="true" iconCls="add" handler="insert" />
		<next:ToolBarItem text="维护下辖村信息" iconCls="edit" handler="update"/>
		<next:ToolBarItem text="删除" hidden="true" iconCls="remove" handler="del"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
	
		<next:Column id="villageName" header="下辖村名称" field="USER_NAME" width="100" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="headCount" header="总人口数（人）" field="HEAD_COUNT" width="100" >
			<next:NumberField  />
		</next:Column>
	
		<next:Column id="householdsNum" header="总户数（户）" field="HOUSEHOLDS_NUM" width="100" >
			<next:NumberField  />
		</next:Column>
	
		<next:Column id="agriculturalArea" header="耕地面积(亩)" field="AGRICULTURAL_AREA" width="100" >
			<next:NumberField  />
		</next:Column>
	
		<next:Column id="houseArea" header="宅基地面积(亩)" field="HOUSE_AREA" width="100" >
			<next:NumberField  />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
