<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
	<head>
		<title>问题处理信息管理</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="prsProblemDeal.js"></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
		<script language="javascript">
		     var organId='<%=BspUtil.getCorpOrganId()%>';
		     var organArea='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
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
    <model:dataset id="problemDealDS" cmd="com.inspur.cams.prs.prsproblemdeal.cmd.PrsProblemDealQueryCmd">
      <model:record fromBean="com.inspur.cams.prs.prsproblemdeal.dao.PrsProblemDeal">
      </model:record>
	</model:dataset>
	<model:dataset id="problemDealDS2" cmd="com.inspur.cams.prs.prsproblemdeal.cmd.PrsProblemDealQueryCmd">
      <model:record fromBean="com.inspur.cams.prs.prsproblemdeal.dao.PrsProblemDeal">
      </model:record>
	</model:dataset>
	<model:dataset id="problemFromDS" enumName="PROBLEM_FROM" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="supervisionDS" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="dealFlagDS" enumName="DEAL_FLAG" autoLoad="true" global="true"></model:dataset>
</model:datasets>
  <next:Panel name="prsProblem_info" width="100%"  >
	<next:Html>
	<fieldset >
		<legend>查询条件
		<img class="GroupBoxExpandButton" src=<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%> onclick="collapse(this);"/>										
		</legend>
			<div>
				<form  class="L5form">
						<table width="100%" >
							<tr>
								<td class="FieldLabel"><label>问题标题:</label></td>
								<td class="FieldInput"><input type="text"  id="qTitle"/></td>					
								<td class="FieldLabel"><label>是否督办件:</label></td>
								<td class="FieldInput"><input type="text"  id="qSupervision"  /></td>		
								<td class="FieldButton" ><button onclick="query();">查 询</button></td>	
							</tr>
							<tr>
								<td class="FieldLabel"><label>来源方式:</label></td>
								<td class="FieldInput"><input type="text"  id="qFrom"/></td>					
								<td class="FieldLabel"><label>反应问题时间:</label></td>
								<td class="FieldInput"><input type="text"  id="qDateBegin" format="Y-m-d" onclick="LoushangDate(this);" readonly="readonly"/>--<input type="text" id="qDateEnd" format="Y-m-d" onclick="LoushangDate(this);" readonly="readonly"/></td>		
								<td class="FieldButton" ><button type="reset">重 置</button> </td>	
							</tr>
						</table>
				</form>
			</div>	
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="prsProblem_Grid" name="prsProblem_Grid"   dataset="problemDealDS" title="问题处理信息管理" stripeRows="true" autoScroll="true" collapsible="true"  width="100%" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="新增" iconCls="add"  handler="add_problem"></next:ToolBarItem>
		<next:ToolBarItem text="修改" iconCls="edit"  handler="edit_problem"></next:ToolBarItem>
		<next:ToolBarItem text="查看明细" iconCls="detail" handler="detail_problem"></next:ToolBarItem>
		<next:ToolBarItem text="删除" iconCls="remove" handler="delete_problem"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
	     <next:RowNumberColumn width="20"/>
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="gproblemId" header="问题Id" field="PROBLEM_ID" hidden="true" width="20%">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="gproblemTitle" header="问题标题" field="problemTitle" width="20%">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="gpersonNumber" header="反应人数" field="personNumber" width="20%">
			<next:TextField />
		</next:Column>
		<next:Column id="gsupervision" header="是否督办件" field="supervision" width="8%">
			<next:TextField />
		</next:Column>
		<next:Column id="gproblemFrom" header="来源方式" field="problemFrom" width="10%" >
			<next:TextField />
		</next:Column>
		<next:Column id="gproblemDate" header="反应问题时间" field="problemDate" width="10%" >
			<next:TextField />
		</next:Column>
		<next:Column id="gdealFlag" header="处理状态" field="dealFlag" dataset="dealFlagDS" width="10%" >
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
			<next:PagingToolBar dataset="problemDealDS"  />
	</next:BottomBar>
</next:GridPanel>

<next:Window id="problem_win" title="问题信息"  width="800" height="420" collapsible="true" closeAction="hide" animCollapse="true" resizable="true">
	<next:Panel id="problem_winPanel"  autoWidth="true" autoHeight="true" collapsible="true" autoScroll="true">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="select" text="确定" handler="save_problem"/>
			<next:ToolBarItem iconCls="disable" text="关闭" handler="close_win"/>
		</next:TopBar>
		<next:Html>
			<form class="L5form" dataset="problemDealDS2">
				<table width="100%">
					<tr >
						<td class="FieldLabel" >问题标题：</td>
						<td class="FieldInput" colspan="3">
							<input type="text" id="problemTitle" name="问题标题" field="problemTitle"  maxlength="50"  style="width:90%"/>
							<font color="red">*</font>
						</td>
						<td class="FieldLabel">问题编号：</td>
						<td class="FieldInput">
							<input type="text" id="problemNumbers" name="问题编号" field="problemNumbers"   style="width:90%"/>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel">反应人名称：</td>
						<td class="FieldInput" colspan="3">
							<input type="text" id="problemPerson" name="反应人名称"  field="problemPerson"  maxlength="25" style="width:90%"/>
							<font color="red">*</font>
						</td>
						<td class="FieldLabel">反应人单位:</td>
						<td class="FieldInput">
							<input type="text" id="problemCompany" name="反应人单位:"  field="problemCompany"  maxlength="25" style="width:90%"/>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel" width="15%">反应人数：</td>
						<td class="FieldInput" width="18%">
							<input type="text" id="personNumber" name="反应人数:"  field="personNumber"  maxlength="10" style="width:90%"/>
						</td>
						<td class="FieldLabel" width="15%">反应问题时间：</td>
						<td class="FieldInput" width="18%">
							<input type="text" id="problemDate" name="反应问题时间" field="problemDate" format="Y-m-d" onclick="LoushangDate(this);" readonly="readonly" style="width:90%"/>
							<font color="red">*</font>
						</td>
						<td class="FieldLabel" width="14%">来源方式:</td>
						<td class="FieldInput" width="20%">
							<select id="problemFrom" name="来源方式:" field="problemFrom"  style="width:90%"><option Dataset="problemFromDS"></option></select>
							<font color="red">*</font>
						</td>
					</tr>
					<tr>	
						<td class="FieldLabel">是否督办件：</td>
						<td class="FieldInput" colspan="5">
							<input type="text" id="supervision" name="是否督办件" field="supervision"  />
							<font color="red">*</font>
						</td>
					</tr>
					<tr>	
						<td class="FieldLabel">反应内容：</td>
						<td class="FieldInput" colspan="5">
							<textArea type="text" id="content" name="反应内容" field="content" cols="15" rows="3"  style="width:90%"></textArea>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel">诉求内容：</td>
						<td class="FieldInput" colspan="5">
							<textArea type="text" id="demands" name="诉求内容" field="demands" cols="15" rows="3" style="width:90%;"></textArea>
						</td>
					</tr>
					<tr>	
						<td class="FieldLabel">处理情况：</td>
						<td class="FieldInput" colspan="5">
							<textArea type="text" id="deal" name="处理情况" field="deal" cols="15" rows="3" style="width:90%;"></textArea>
						</td>
				   </tr>
				   <tr>	
						<td class="FieldLabel">处理时间：</td>
						<td class="FieldInput" colspan="5">
							<input type="text" id="dealTime" name="处理时间" field="dealTime"  format="Y-m-d" onclick="LoushangDate(this);" readonly="readonly"/>
						</td>
					</tr>
				</table>
			</form>
		</next:Html>
	</next:Panel>
</next:Window>
</body>
</html>