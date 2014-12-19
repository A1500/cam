<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
	<head>
		<title>问题处理信息管理</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="prsProblemDealHistory.js"></script>
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
    <model:dataset id="problemDealDS" cmd="com.inspur.cams.prs.prsproblemdeal.cmd.PrsProblemDealQueryCmd" method="queryBySql">
    	<model:record fromBean="com.inspur.cams.prs.prsproblemdeal.dao.PrsProblemDeal">
      	<model:field name="problemId" mapping="PROBLEM_ID" type="string" rule="require"/>
      	<model:field name="problemTitle" mapping="PROBLEM_TITLE" type="string" rule="require"/>
      	<model:field name="problemCompany" mapping="PROBLEM_COMPANY" type="string" rule="require"/>
      	<model:field name="personNumber" mapping="PERSON_NUMBER" type="string" rule="require"/>
      	<model:field name="organ" mapping="ORGAN" type="string" />
      	<model:field name="supervision" mapping="SUPERVISION" type="string" rule="require"/>
      	<model:field name="problemFrom" mapping="PROBLEM_FROM" type="string" rule="require"/>
      	<model:field name="problemDate" mapping="PROBLEM_DATE" type="string" rule="require"/>
      	<model:field name="dealFlag" mapping="DEAL_FLAG" type="string" />
      	<model:field name="curActivity" mapping="CUR_ACTIVITY" type="string" />
      </model:record>
	</model:dataset>
	<model:dataset id="problemFromDS" enumName="PROBLEM_FROM" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="supervisionDS" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="dealFlagDS" enumName="DEAL_FLAG" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="curActivityDS" enumName="PRS.CUR_ACTIVITY" autoLoad="true" global="true"></model:dataset>
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
								<td class="FieldLabel"><label>反应问题时间:</label></td>
								<td class="FieldInput"><input type="text"  id="qDateBegin" format="Y-m-d" onclick="LoushangDate(this);" readonly="readonly"/>-----<input type="text" id="qDateEnd" format="Y-m-d" onclick="LoushangDate(this);" readonly="readonly"/></td>		
											
							</tr>
							<tr>
							    <td class="FieldLabel"><label>来源方式:</label></td>
								<td class="FieldInput"><select id="qFrom" ><option  dataset="problemFromDS" ></option></select></td>
								
								<td class="FieldLabel"><label>是否督办件:</label></td>
								<td class="FieldInput"><select  id="qSupervision" ><option dataset="supervisionDS" ></option></select>&nbsp;&nbsp;&nbsp;<button onclick="query();">查 询</button>&nbsp;&nbsp;&nbsp;<button type="reset">重 置</button></td>
							</tr>
						</table>
				</form>
			</div>	
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="prsProblem_Grid" name="prsProblem_Grid" clickToSelectedForChkSM="true"  dataset="problemDealDS" title="问题处理信息管理" stripeRows="true" autoScroll="true" collapsible="true"  width="100%" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="查看明细" iconCls="detail" handler="detail_problem"></next:ToolBarItem>
		<next:ToolBarItem text="删除" iconCls="remove" handler="delete_problem"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
	     <next:RowNumberColumn width="20"/>
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="PROBLEM_ID" header="问题ID" field="problemId" hidden="true" width="20%">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="PROBLEM_TITLE" header="问题标题" field="problemTitle" width="10%">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="PROBLEM_COMPANY" header="反应人单位" field="problemCompany" width="10%">
			<next:TextField />
		</next:Column>
		<next:Column id="PERSON_NUMBER" header="反应人数" field="personNumber" width="8%">
			<next:TextField />
		</next:Column>
		<next:Column id="SUPERVISION" header="是否督办件" field="supervision" dataset="supervisionDS" width="10%">
			<next:TextField />
		</next:Column>
		<next:Column id="PROBLEM_FROM" header="来源方式" field="problemFrom" dataset="problemFromDS" width="11%" >
			<next:TextField />
		</next:Column>
		<next:Column id="PROBLEM_DATE" header="反应问题日期" field="problemDate" width="13%" >
			<next:TextField />
		</next:Column>
		<next:Column id="DEAL_FLAG" header="处理结果" field="dealFlag" dataset="dealFlagDS" width="11%" >
			<next:TextField />
		</next:Column>
		<next:Column id="CUR_ACTIVITY" header="当前环节" field="curActivity" dataset="curActivityDS"  width="10%" >
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
			<next:PagingToolBar dataset="problemDealDS"  />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>