<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
		<title>基金会换届（成立）选举报告列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="somFundElectionList.js"></script>		
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js") %>'></script>
		 <script language="javascript">
	 	 //查询条件打开合并函数
			 function collapse(element){
				var fieldsetParent=L5.get(element).findParent("fieldset");
				if(element.expand==null||element.expand==true){	
					fieldsetParent.getElementsByTagName("div")[0].style.display="none";
					element.src = '<%=SkinUtils.getImage(request,"groupbox_expand.gif")%>';
					element.expand=false;
				}else{
					fieldsetParent.getElementsByTagName("div")[0].style.display="";
					element.src = "<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>";					
					element.expand =true;
				}
			}
		</script>
	</head>
	
<body>
<model:datasets>
    <model:dataset id="fundElectionDS" cmd="com.inspur.cams.sorg.manage.cmd.SomFundElectionQueryCmd" pageSize="10">
      <model:record fromBean="com.inspur.cams.sorg.base.data.SomMeeting"></model:record>
	</model:dataset>
	<model:dataset id="cnNameDS" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value="SOM_ORGAN" ></model:param>
			<model:param name="value" value="SORG_ID" ></model:param>
			<model:param name="text" value="CN_NAME" ></model:param>
		</model:params>
	</model:dataset>
	
	<model:dataset id="sorgTypeDS" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SORG_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="ifCurrentDS" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>

  <next:Panel name="electionPanel" width="100%"  >
	<next:Html>
	<fieldset >
		<legend>查询条件
			<img class="GroupBoxExpandButton" src=<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%> onclick="collapse(this);"/>									
		</legend>
			<div >
				<form  class="L5form">
						<table width="100%" >
							<tr>
								<td class="FieldLabel"><label>基金会名称:</label></td>
								<td class="FieldInput"><input type="text"  id="qcnName"  /></td>	
								<td class="FieldLabel"><label>会议名称:</label></td>
								<td class="FieldInput"><input type="text"  id="qmeetingName"  /></td>	
							    <td class="FieldButton" ><button  onclick="query();">查 询</button> </td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>是否最新:</label></td>
								<td class="FieldInput"><select   id="qifCurrent" ><option dataset="ifCurrentDS"></option></select></td>	
								<td class="FieldLabel"></td>
								<td class="FieldInput"></td>	
							    <td class="FieldButton" ><button type="reset">重 置</button> </td>
							</tr>
						</table>
					</form>
				</div>	
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="ElectionGrid" name="ElectionGrid" autoExpandColumn="sorgId"  dataset="fundElectionDS"  stripeRows="true"  width="100%" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="基金会换届（成立）选举报告"></next:ToolBarItem>	  
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="增加" iconCls="add" handler="newElection" ></next:ToolBarItem>
		<next:ToolBarItem text="修改" iconCls="edit" handler="editElection" ></next:ToolBarItem>
		<next:ToolBarItem text="查看明细" iconCls="detail" handler="detailElection"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
	     <next:RowNumberColumn width="20"/>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column hidden="true" header="换届会议ID" id="id" field="id"  resizable="true">
			 <next:TextField allowBlank="false"/>
		 </next:Column >
		 <next:Column  header="组织类型"  field="sorgType"  dataset="sorgTypeDS" resizable="true">
		 <next:TextField allowBlank="false"/>
		</next:Column> 			 
		<next:Column  header="基金会名称" id="sorgId" field="sorgId" dataset="cnNameDS" align="center" width="25%" >
		  <next:TextField allowBlank="false"/>
		</next:Column >   
		<next:Column header="会议名称" id="meetingName" field="meetingName" align="center" resizable="true" width="18%">
		 <next:TextField allowBlank="false"/>
		 </next:Column >
		<next:Column  header="是否最新"  field="ifCurrent" dataset="ifCurrentDS" align="center" resizable="true" width="15%">
		 <next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column  header="会议日期"  field="meetingDate" align="center" resizable="true" width="15%">
		 <next:TextField allowBlank="false"/>
		</next:Column> 			  
	</next:Columns>
	<next:BottomBar>
			<next:PagingToolBar dataset="fundElectionDS"  />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>