
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
	<head>
		<title>变更列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="unitChangeList.js"></script>
		<script language="javascript">
		<%
			String organCode = BspUtil.getCorpOrgan().getOrganCode();
			String organName=BspUtil.getCorpOrgan().getOrganName();
			if(organCode.endsWith("0000000000")){//省370000000000
				organCode= organCode.substring(0,2);
			} else if (organCode.endsWith("00000000")){//市370100000000
				organCode=  organCode.substring(0,4);
			} else if (organCode.endsWith("000000")){//县370104000000
				organCode=  organCode.substring(0,6);
			} else if (organCode.endsWith("000")){//乡370104003000
				organCode=  organCode.substring(0,9);
			}
		%>
		var organCode='<%=organCode%>';
		var organName='<%=organName%>';
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
	<model:dataset id="ds" cmd="com.inspur.cams.welfare.base.cmd.WealFitChangerecordQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealFitChangerecord"></model:record>
	</model:dataset>
</model:datasets>

<next:Panel  name="form" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" width="100%" autoHeight="true" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox"><legend
					class="GroupBoxTitle">查询条件 <img
					class="GroupBoxExpandButton"
					src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
					onclick="collapse(this)" /> </legend>
				<div>
					<form style="width: 95%; height: 100%;" class="L5form">
						<table  border="1" width="100%" >
							<tr >
								<td class="FieldLabel">编号:</td>
								<td class="FieldInput"><input type="text"  id="serialNumQuery" class="TextEditor" title="编号"  /></td>	
								<td class="FieldLabel">企业名称:</td>
								<td class="FieldInput"><input type="text"  id="companyNameQuery" class="TextEditor" title="企业名称"  /></td>	
								<td class="FieldLabel">联系人:</td>
								<td class="FieldInput"><input type="text"  id="linkmanQuery" class="TextEditor" title="联系人"  /></td>	
							</tr>
							<tr>	
								<td class="FieldLabel">法定代表人:</td>
								<td class="FieldInput"><input type="text"  id="legalPeopleQuery" class="TextEditor" title="法定代表人"  /></td>
								<td class="FieldLabel"></td>
								<td class="FieldInput"></td>		
								<td class="FieldLabel"></td>
								<td class="FieldInput"><button onclick="query()">查 询</button>&nbsp;&nbsp;&nbsp;
										<button type="reset">重 置</button>
								</td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="wealfitchangerecordGrid" stripeRows="true" width="100%" height="100%" dataset="ds" title="变更企业列表"  clickToSelectedForChkSM="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="增加" iconCls="add" handler="insert" />
		<next:ToolBarItem text="修改" iconCls="edit" handler="update"/>
		<next:ToolBarItem text="确认变更" iconCls="select" handler="submit"/>
		<next:ToolBarItem text="查看" iconCls="detail" handler="detail"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:RadioBoxColumn></next:RadioBoxColumn>
	     
		<next:Column id="taskCode" header="业务编码" field="taskCode" width="90" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="serialNum" header="编号" field="serialNum" width="130" >
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="companyName" header="企业名称" field="companyName" width="150" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="linkman" header="联系人" field="linkman" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="phone" header="联系电话" field="phone" width="100" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="changeReason" header="变更理由" field="changeReason" width="200" >
			<next:TextField  />
		</next:Column>
		
		<next:Column id="legalPeople" header="法定代表人" field="legalPeople" width="90" >
			<next:TextField  />
		</next:Column>
		
		<next:Column id="idCard" header="法定代表人身份证号" field="idCard" width="150" >
			<next:TextField  />
		</next:Column>
		
		<next:Column id="regDate" header="变更备案时间" field="regDate" width="150" >
			<next:TextField  />
		</next:Column>
	
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
