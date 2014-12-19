<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<%@ page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<html>
	<head>
		<title>年检填报列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="somchecktask_list.js"></script>
		<script language="javascript">
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
			<model:param name="SORG_TYPE" value='J'></model:param>
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
	<!-- 党建年检 -->
	<model:dataset id="partyCheckDataSet" cmd="com.inspur.cams.sorg.partycheck.cmd.SomPartyCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.partycheck.data.SomPartyCheck"></model:record>
	</model:dataset>
	<model:dataset id="somCheckStatus" enumName="SOM.CHECK_STATUS" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="checkResultSelect" enumName="SOM.CHECK_RESULT" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel  width="100%" height="100%" >
<next:GridPanel id="editGridPanel" name="somchecktaskGrid" width="100%" stripeRows="true" height="240" dataset="taskDs" title="填写年检信息" notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="填写年检信息" iconCls="add" handler="insert" />
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
	    <next:Column id="taskId" header="任务编号" field="taskId" width="250" hidden="true">
			<next:TextField  />
		</next:Column>
		
		<next:Column id="sorgType" header="社会类型" field="sorgType" width="130" >
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

<next:GridPanel id="editGridPanel2" name="somcheckGrid" width="100%" stripeRows="true" height="100%" dataset="checkDs" title="填写过的年检信息" notSelectFirstRow="true">
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
	     
		<next:Column id="taskCode" header="task_code" field="taskCode" width="90" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="cnName" header="基金会名称" field="cnName" width="250" >
			<next:TextField  />
		</next:Column>
		
		<next:Column id="sorgCode" header="登记证号" field="sorgCode" width="60" >
			<next:TextField  />
		</next:Column>		
	
		<next:Column id="checkYear" header="年检年份" field="checkYear" width="150" >
			<next:TextField  />
		</next:Column>
		<next:Column id="checkResult" header="年检结果" field="checkResult" width="150" >
			<next:ComboBox dataset="checkResultSelect"/>
		</next:Column>
		<next:Column id="commitTime" header="提交时间" field="commitTime" width="150" >
			<next:TextField  />
		</next:Column>
		
		<next:Column id="status"  header="年检状态" field="status" width="10%" dataset="somCheckStatus"
			 renderer="changeColor" hidden="true" >
		</next:Column>
		
		<next:Column header="年检状态" field="status1" width="10%"  renderer="changeStatus1" align="center">
		</next:Column>
		
		<next:Column header="校对结果" field="status2" width="10%" renderer="changeStatus2" align="center">
		</next:Column>
		
		<next:Column id="correctNotReason" header="原因" field="" editable="false" renderer="clickShowHref" width="20%" align="center">
			<next:TextField  />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="checkDs"/>
	</next:BottomBar>
</next:GridPanel>
</next:Panel>
<next:Window id="correctNotPassReasonWin" closeAction="hide" width="500" height="170" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="closeCorrectNotPassReasonWin"></next:ToolBarItem>
		<next:ToolBarItem xtype="tbseparator"/>
	</next:TopBar>
	<next:Html>
		<table width="100%" >
			<tr>
				<td class="FieldLabel" style="width:20%">校对不通过原因</td>
				<td class="FieldInput" style="width:80%"><textarea id="correctNotReason" rows="8" style="width:100%" readonly="readonly"></textarea></td>
			</tr>
		</table>
   </next:Html>
</next:Window>
<next:Window id="winPrint" closeAction="hide" title="打印年检报告" width="200"  autoScroll="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="add" handler="confirmPrint"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="closePrint"></next:ToolBarItem>		
	</next:TopBar>
	<next:Html>
		<table width="100%">
			<tr>
				<td align="center"><select id="printPart">
					<option value="1">上半部分</option>
					<option value="2">下半部分</option>
				</select></td>
			</tr>
		</table>
	</next:Html>
</next:Window>
</body>
</html>
