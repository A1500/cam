<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<%@ page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<%@ page import="com.inspur.cams.sorg.online.extuser.util.SomExtBspInfo"%>
<%@ page import="com.inspur.cams.comm.extuser.data.ComExtUser"%>
<html>
	<head>
		<title>年检填报列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="partychecktask_list.js"></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
		<script language="javascript">
		<%
			ComExtUser comExtUser = (ComExtUser)SomExtBspInfo.getUserInfo(request).getComExtUser();
			String organType = comExtUser.getOrganType();//获取外部单位的类型 ST:社团  MF:民非  JJ：基金会
			String title="";
			if("ST".equals(organType)){
				organType="S";
				title="社会团体名称";
			}else if("MF".equals(organType)){
				organType="M";
				title="民办非企业单位名称";
			}else{
				organType="J";
				title="基金会名称";
			}
		%>
			 var userId='<%=ExtBspInfo.getUserInfo(request).getUserId()%>';
			 var year = '<%=Integer.parseInt(DateUtil.getYear())-1+""%>';
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
			<model:param name="SORG_TYPE" value='<%=organType %>'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="partyCheckDataSet" cmd="com.inspur.cams.sorg.partycheck.cmd.SomPartyCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.partycheck.data.SomPartyCheck"></model:record>
	</model:dataset>
	<model:dataset id="sorgTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SORG_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="somCheckStatus" enumName="SOM.PARTY_CHECK_STATUS" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="checkResultSelect" enumName="SOM.PARTY_CHECK_RESULT" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel  width="100%" height="100%" >
<next:GridPanel id="editGridPanel" name="somchecktaskGrid" width="100%" stripeRows="true" height="240" dataset="taskDs" title="填写党建年检信息" clickToSelectedForChkSM="true" notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="填写党建年检信息" iconCls="add" handler="insert" />
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
	    <next:Column id="taskId" header="任务编号" field="taskId" width="250" hidden="true">
			<next:TextField  />
		</next:Column>
		
		<next:Column id="sorgType" header="社会组织类型" field="sorgType" width="130" >
			<next:ComboBox dataset="sorgTypeSelect"/>
		</next:Column>
	
		<next:Column id="taskName" header="名称" field="taskName" width="250" >
			<next:TextField  />
		</next:Column>
	
	
		<next:Column id="batchYear" header="年检年份" field="batchYear" width="90" >
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

<next:GridPanel id="editGridPanel2" name="somcheckGrid" width="100%" stripeRows="true" height="100%" dataset="partyCheckDataSet" title="填写过的年检信息" clickToSelectedForChkSM="true" notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="提交年检材料" iconCls="upload" handler="submit"/>
		<next:ToolBarItem text="修改" iconCls="edit" handler="updateCheck"/>
		<next:ToolBarItem text="查看" iconCls="detail" handler="detailCheck"/>
		<next:ToolBarItem text="打印年检报告" iconCls="print" handler="printCheck"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	     <next:CheckBoxColumn></next:CheckBoxColumn>
	     
		<next:Column id="ycheckId" header="ycheckId" field="ycheckId" width="90" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="sorgName" header='<%=title %>'  field="sorgName" width="250" >
			<next:TextField  />
		</next:Column>
		
		<next:Column id="sorgCode" header="登记证号" field="sorgCode" width="150" >
			<next:TextField  />
		</next:Column>		
	
		<next:Column id="yearly" header="年检年份" field="yearly" width="80" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="checkStatus" header="年检状态" field="checkStatus" width="120" dataset="somCheckStatus">
		</next:Column>
		
		<next:Column id="modTime" header="提交时间" field="modTime" width="150">
		</next:Column>
		
		<next:Column id="checkResult" header="年检结果" field="checkResult" width="80" >
			<next:ComboBox dataset="checkResultSelect"/>
		</next:Column>
		
		<next:Column id="checkTime" header="核对时间" field="checkTime" width="150">
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="partyCheckDataSet"/>
	</next:BottomBar>
</next:GridPanel>
</next:Panel>
</body>
</html>
