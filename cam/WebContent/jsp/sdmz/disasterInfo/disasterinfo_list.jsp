<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.sdmz.comm.util.BspUtil"%>
<html>
	<head>
		<title>灾情信息列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="disasterinfo_list.js"></script>
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
			var organArea = "<%=BspUtil.getCorpOrgan().getOrganCode()%>";
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.sdmz.disasterInfo.cmd.DisasterInfoQueryCommand" global="true">
		<model:record fromBean="com.inspur.sdmz.disasterInfo.dao.DisasterInfo"></model:record>
	</model:dataset>
</model:datasets>

<next:Panel  name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
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
								 <td class="FieldLabel"><label>灾情发生时间：</label></td>
				                 <td class="FieldInput"><input type="text" name="disasterTime"  field="disasterTime" id="disasterTime"  style="width:100" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly"/></td>
								 <td class="FieldLabel">上报人:</td>
								 <td class="FieldInput"><input type="text"  id="regPeople" class="TextEditor" title="上报人"  /></td>	
								 <td class="FieldLabel"><label>上报时间：</label></td>
				                 <td class="FieldInput"><input type="text" name="regTime"  field="regTime" id="regTime"  style="width:100" format="Ymd" onclick="LoushangDate(this)" readonly="readonly"/></td>
								<td class="FieldLabel"><button onclick="query()">查 询</button>
								 <button onclick="reset()" style="margin-left: 15px;">重 置</button> </td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="disasterinfoGrid" width="100%" stripeRows="true" height="400" dataset="ds" title="灾情信息">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="增加" iconCls="add" handler="insert" />
		<next:ToolBarItem text="修改" iconCls="edit" handler="update"/>
		<next:ToolBarItem text="删除" iconCls="remove" handler="del"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="disasterId" header="业务编号" field="disasterId" width="90"  hidden="true"/>
		<next:Column id="disasterTitle" header="灾情标题" field="disasterTitle" width="120" />
		<next:Column id="disasterTime" header="灾情发生时间" field="disasterTime" width="90" />
		<next:Column id="disasterAdd" header="灾情发生地点" field="disasterAdd" width="90" />
		<next:Column id="regPeople" header="上报人" field="regPeople" width="90" />
		<next:Column id="regOrgan" header="上报单位" field="regOrgan" width="90" />
		<next:Column id="regTime" header="上报时间" field="regTime" width="90" />
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
