
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
	<head>
		<title>救助查询名册</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="succourRoster_list.js"></script>
		<script language="javascript">
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
			 var organCode = '<%=BspUtil.getOrganCode()%>';
		   	 var organName = '<%=BspUtil.getOrganName()%>';
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ReliefTypeDataset" enumName="DIS.ALLOCATION_PURPOSE" autoLoad="true"
		global="true"></model:dataset>
</model:datasets>

<next:Panel  name="form"  width="100%" border="0" autoHeight="true" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox"><legend
					class="GroupBoxTitle">查询条件 <img
					class="GroupBoxExpandButton"
					src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
					onclick="collapse(this)" /> </legend>
				<div>
					<form style="width: 100%; height: 100%;" class="L5form">
						<table  border="1" width="100%" >
							<tr >
								<td class="FieldLabel" style="width:100">救助类型:</td>
								<td class="FieldInput"><select type="text"  id="reliefType" class="TextEditor" title="救助类型" onchange="onTypeSelect()" style="width:200"/>
								<option dataset="ReliefTypeDataset"></option></select>
								</td>
								<td class="FieldLabel" style="width:100">批次:</td>
								<td class="FieldInput">
								<input type="hidden" id="batchId" name="batchId" value="" />
								<input type="text" id="batchName" name="batchName" title="批次"  readonly="readonly" style="width:200px" />
								<img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand"  onclick="forBatchSelect()"/>
								</td>	
								<td class="FieldLabel"  style="text-align:left;padding-left:250px;"><button onclick="query()">查 询</button> </td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>
<next:Panel  width="100%" height="100%" id="succourRosterPanel">
				<next:Html>
				  <iframe id="succourRoster" src=""
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
</next:Panel>
</body>
</html>
