
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<script type="text/javascript">
   var organCode='<%=BspUtil.getOrganCode()%>';
   var organType = '<%=BspUtil.getOrganType()%>';
   
</script>
<html>
	<head>
		<title>黑名单</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="bptperjury_listform.js"></script>
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
	<model:dataset id="ds" cmd="com.inspur.cams.bpt.manage.cmd.BptPerjuryQueryCommand" method="queryPerjury" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptPerjury">
			<model:field name="perjuryId" type="string" mapping="PERJURY_ID"/>
			<model:field name="domicileCode" type="string" mapping="DOMICILE_CODE"/>
			<model:field name="domicileName" type="string" mapping="DOMICILE_NAME"/>
			<model:field name="name" type="string" mapping="NAME"/>
			<model:field name="idCard" type="string" mapping="ID_CARD"/>
			<model:field name="serviceType" type="string" mapping="SERVICE_TYPE"/>
			<model:field name="addDate" type="string" mapping="ADD_DATE"/>
			<model:field name="addPerson" type="string" mapping="ADD_PERSON"/>
		</model:record>
	</model:dataset>
	<!-- 业务类型 -->
	<model:dataset id="serverTypeDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BPT_SERVICE_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset> 
</model:datasets>



<next:Panel  name="form" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
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
						<td class="FieldLabel">所属行政区划:</td>
						<td class="FieldInput">
							<input type="text"  id="domicileName" class="TextEditor" title="所属行政区划"  readonly="readonly" onclick="forHelp(this,false)"/><input type="hidden"  
							id="domicileCode" class="TextEditor"/>
						</td>			
						<td class="FieldLabel">身份证号:</td>
						<td class="FieldInput"><input type="text"  id="idCard" class="TextEditor" title="ID_CARD"  /></td>			
						<td class="FieldLabel">姓名:</td>
						<td class="FieldInput"><input type="text"  id="name" class="TextEditor" title="NAME"  /></td>	
						<td class="FieldLabel"><button onclick="query()">查询</button> </td>
					</tr>		
				</table>
				</form>
				</div>
	   </fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="bptperjuryGrid" stripeRows="true" dataset="ds" title="人员列表" height="100%" >
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
	    <next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem text="增加" iconCls="add" handler="insert" />
		<%
			String username = GetBspInfo.getBspInfo(request).getUserId();
			if("SUPERADMIN".equals(username)){
				
			
		%>
			<next:ToolBarItem text="修改" iconCls="edit" handler="update" />
			<next:ToolBarItem text="删除"  iconCls="remove" handler="del"/>
		<%
			}
		%>
		
		
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	     <next:RadioBoxColumn></next:RadioBoxColumn>
	     
		<next:Column id="perjuryId" header="PERJURY_ID" field="perjuryId" width="90"  hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="domicileCode" header="所属行政区划" field="domicileCode" width="290" hidden="true">
			<next:TextField  />
		</next:Column>
		<next:Column id="domicileName" header="所属行政区划" field="domicileName" width="290" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="idCard" header="身份证号" field="idCard" width="190" >
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="name" header="姓名" field="name" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="serviceType" header="业务类型" field="serviceType" width="290"   dataset="serverTypeDataset" >
			<next:TextField  />
		</next:Column>
	
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>

</body>
</html>
