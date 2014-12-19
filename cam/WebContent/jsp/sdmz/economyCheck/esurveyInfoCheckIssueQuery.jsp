<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
		<title>申报家庭经济核对分发</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="esurveyInfoCheckIssueQuery.js"></script>
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
		</script>
	</head>
<body>
<model:datasets>
</model:datasets>

<next:Panel  name="form" width="100%"  border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox"><legend
					class="GroupBoxTitle">查询条件 <img
					class="GroupBoxExpandButton"
					src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
					onclick="collapse(this)" /> </legend>
				<div>
					<form style="width: 98%; height: 100%;" class="L5form">
						<table  border="1" width="100%" >
							<tr >
								<td class="FieldLabel">户主姓名:</td>
								<td class="FieldInput">
									<input type="text"  id="hzxm" class="TextEditor" title="户主姓名"   />
								</td>	
								<td class="FieldLabel">身份证号:</td>
								<td class="FieldInput">
									<input type="text"  id="sfzh" class="TextEditor" title="身份证号"   />
								</td>
							</tr><tr>	
								<td class="FieldLabel">审核状态:</td>
								<td class="FieldInput">
									<select id="shzt" field="shzt" title="审核状态" >
										<option dataset="shztDs"></option>
									</select>
								</td>		
								<td class="FieldLabel">救助类型:</td>
								<td class="FieldInput">
									<select id="jzlx" field="jzlx" title="救助类型" >
										<option dataset="jzlxDs"></option>
									</select>
								</td>
							</tr><tr>
								<td class="FieldLabel" colspan="8">
									 &nbsp;&nbsp;<button onclick="query()">查 询</button>  &nbsp;&nbsp;
									<button type="reset">重 置</button>
								</td>	
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="sbjtxxGridPanel" name="sbjtxxGridPanel" width="100%" height="400" notSelectFirstRow="true" 
	stripeRows="true" dataset="declareFamilyInfoDataset" title="->  您的位置 : 申报家庭经济核对分发">	
	
	<next:TopBar>
		<next:ToolBarItem text="申报家庭基本信息列表:"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="detail" text="详细" handler="details"/>
		<next:ToolBarItem iconCls="search" text="核对分发" handler="checkIssue"/>
		<next:ToolBarItem symbol=""></next:ToolBarItem>
		<next:ToolBarItem symbol="-"></next:ToolBarItem>
		<next:ToolBarItem symbol=""></next:ToolBarItem>
	</next:TopBar>
	
	<next:Columns>
	    <next:RowNumberColumn width="20"/>
		<next:CheckBoxColumn></next:CheckBoxColumn>
		
		<next:Column id="hzxm" header="户主姓名"  field="hzxm"  >
			<next:TextField  />
		</next:Column>
		<next:Column id="sfzh" header="身份证号"  field="sfzh"  >
			<next:TextField  />
		</next:Column>
		<next:Column id="jtrksl" header="家庭人口数量"  field="jtrksl"  >
			<next:TextField  />
		</next:Column>
		<next:Column id="jtxz" header="家庭性质"  field="jtxz"  >
			<next:TextField  />
		</next:Column>
		<next:Column id="jzlx" header="救助类型"  field="jzlx"  >
			<next:TextField  />
		</next:Column>
		<next:Column id="hjxzqh" header="户籍行政区划"  field="hjxzqh"  >
			<next:TextField  />
		</next:Column>
	</next:Columns>
	
	<next:BottomBar>
		<next:PagingToolBar dataset="declareFamilyInfoDataset"></next:PagingToolBar>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
