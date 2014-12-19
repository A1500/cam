<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil;"%>
<html>
	<head>
		<title>年检填报列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="somchecktask_list.js"></script>
		<script language="javascript">
			 var empId = '<%= BspUtil.getEmpOrganId()%>';
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
	<model:dataset id="taskDs" cmd="com.inspur.cams.sorg.check.checktask.cmd.SomCheckTaskQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.checktask.data.SomCheckTask"></model:record>
		<model:params>
			<model:param name="IF_VALID" value='1'></model:param>
			<model:param name="SORG_TYPE" value='S'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="checkDs" cmd="com.inspur.cams.sorg.check.somcheck.cmd.SomCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.somcheck.data.SomCheck"></model:record>
	</model:dataset>
	<model:dataset id="sorgTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SORG_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="somCheckStatus" enumName="SOM.CHECK_STATUS" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="checkResultSelect" enumName="SOM.CHECK_RESULT" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:GridPanel id="editGridPanel" name="somchecktaskGrid" width="98%" stripeRows="true" height="200" dataset="taskDs" title="填写年检信息" notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="填写年检信息" iconCls="add" handler="insert" />
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
	     
		<next:Column id="sorgType" header="社会组织类型" field="sorgType" width="90" >
			<next:ComboBox dataset="sorgTypeSelect"/>
		</next:Column>
	
		<next:Column id="taskName" header="名称" field="taskName" width="250" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="batch" header="批次" field="batch" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="batchYear" header="批次年份" field="batchYear" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="validDate" header="有效期至" field="validDate" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="addDate" header="添加日期" field="addDate" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="addPersonn" header="添加人名称" field="addPersonn" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="addOrgan" header="添加单位名称" field="addOrgan" width="150" >
			<next:TextField  />
		</next:Column>
	
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="taskDs"/>
	</next:BottomBar>
</next:GridPanel>

<next:GridPanel id="editGridPanel2" name="somcheckGrid" width="98%" stripeRows="true" height="250" dataset="checkDs" title="填写过的年检信息" notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="提交年检材料" iconCls="submit" handler="submit"/>
		<next:ToolBarItem text="修改" iconCls="edit" handler="updateCheck"/>
		<next:ToolBarItem text="明细" iconCls="detail" handler="detailCheck"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	     <next:CheckBoxColumn></next:CheckBoxColumn>
	     
		<next:Column id="taskCode" header="task_code" field="taskCode" width="90" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="sorgCode" header="登记证号" field="sorgCode" width="150" >
			<next:TextField  />
		</next:Column>
		
		<next:Column id="cnName" header="社会组织名称" field="cnName" width="250" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="batch" header="年检批次" field="batch" width="150" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="batchYear" header="年份" field="batchYear" width="150" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="status" header="年检状态" field="status" width="150" >
			<next:ComboBox dataset="somCheckStatus"/>
		</next:Column>
		
		<next:Column id="checkResult" header="年检结果" field="checkResult" width="150" >
			<next:ComboBox dataset="checkResultSelect"/>
		</next:Column>
		
		<next:Column id="batchYear" header="提交时间" field="commitTime" width="150" >
			<next:TextField  />
		</next:Column>
	
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="checkDs"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
