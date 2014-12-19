
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>

<html>
	<head>
		<title>60周岁以上农村籍退役士兵信息</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="bptcountretiredsoldier.js"></script>
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
	<model:dataset id="ds" cmd="com.inspur.cams.bpt.manage.cmd.BptCountRetiredSoldierQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptCountRetiredSoldier"></model:record>
	</model:dataset>
</model:datasets>

<next:Panel  name="form" width="100%" border="0" autoHeight="true" >
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
						<td class="FieldLabel">退役证件号:</td>
						<td class="FieldInput"><input type="text"  id="retiredNo" class="TextEditor" title="退役证件号"  /></td>			
						<td class="FieldLabel">入伍时间:</td>
						<td class="FieldInput"><input type="text"  id="conscriptDate" class="TextEditor" title="入伍时间"  /></td>			
						<td class="FieldLabel">退役时间:</td>
						<td class="FieldInput"><input type="text"  id="decruitmentDate" class="TextEditor" title="退役时间"  /></td>			
						<td class="FieldLabel">服义务兵向起止时间:</td>
						<td class="FieldInput"><input type="text"  id="soldierStartEndDate" class="TextEditor" title="服义务兵向起止时间"  /></td>			
						<td class="FieldLabel">所服义务兵役折算年限:</td>
						<td class="FieldInput"><input type="text"  id="soldierYears" class="TextEditor" title="所服义务兵役折算年限"  /></td>			
						<td class="FieldLabel">服役部队名称(番号):</td>
						<td class="FieldInput"><input type="text"  id="forcesName" class="TextEditor" title="服役部队名称(番号)"  /></td>			
						<td class="FieldLabel">服役部队代号:</td>
						<td class="FieldInput"><input type="text"  id="forcesNo" class="TextEditor" title="服役部队代号"  /></td>			
						<td class="FieldLabel">生活状况:</td>
						<td class="FieldInput"><input type="text"  id="lifeState" class="TextEditor" title="生活状况"  /></td>			
						<td class="FieldLabel">家庭人口:</td>
						<td class="FieldInput"><input type="text"  id="familyNum" class="TextEditor" title="家庭人口"  /></td>			
						<td class="FieldLabel">18岁(含)以下:</td>
						<td class="FieldInput"><input type="text"  id="youngNum" class="TextEditor" title="18岁(含)以下"  /></td>			
						<td class="FieldLabel">60岁(含)以上:</td>
						<td class="FieldInput"><input type="text"  id="oldNum" class="TextEditor" title="60岁(含)以上"  /></td>			
						<td class="FieldLabel">是否属于孤老:</td>
						<td class="FieldInput"><input type="text"  id="isOrphanflag" class="TextEditor" title="是否属于孤老"  /></td>			
						<td class="FieldLabel">劳动能力:</td>
						<td class="FieldInput"><input type="text"  id="laborAbility" class="TextEditor" title="劳动能力"  /></td>			
						<td class="FieldLabel">是否具有其他优抚对象身份:</td>
						<td class="FieldInput"><input type="text"  id="isOtherBptobject" class="TextEditor" title="是否具有其他优抚对象身份"  /></td>			
						<td class="FieldLabel">优抚对象类别:</td>
						<td class="FieldInput"><input type="text"  id="objectType" class="TextEditor" title="优抚对象类别"  /></td>			
						<td class="FieldLabel">是否享受低保待遇:</td>
						<td class="FieldInput"><input type="text"  id="isGuarant" class="TextEditor" title="是否享受低保待遇"  /></td>			
						<td class="FieldLabel">是否享受五保待遇:</td>
						<td class="FieldInput"><input type="text"  id="isFiveGuarant" class="TextEditor" title="是否享受五保待遇"  /></td>			
						<td class="FieldLabel">身份认定依据:</td>
						<td class="FieldInput"><input type="text"  id="identityBasis" class="TextEditor" title="身份认定依据"  /></td>	
						<td class="FieldLabel"><button onclick="query()">查 询</button> </td>
					</tr>								
				</table>
				</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>	

<next:EditGridPanel id="editGridPanel" name="bptcountretiredsoldierGrid" width="100%" stripeRows="true" height="400" dataset="ds" title="BPT_COUNT_RETIRED_SOLDIER">
	<next:TopBar>
			<next:ToolBarItem symbol="->" ></next:ToolBarItem>
	        <next:ToolBarItem symbol="-" ></next:ToolBarItem>
			<next:ToolBarItem  iconCls="add" text="增加" handler="insert"  />
			<next:ToolBarItem  iconCls="remove" text="删除" handler="del"  />
			<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
			<next:ToolBarItem iconCls="undo"  text="取消" handler="reset"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
	     
		<next:Column id="peopleId" header="人员ID" field="peopleId" width="95" >			
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="retiredNo" header="退役证件号" field="retiredNo" width="95" >			
			<next:TextField  />
		</next:Column>
	
		<next:Column id="conscriptDate" header="入伍时间" field="conscriptDate" width="95" >			
			<next:TextField  />
		</next:Column>
	
		<next:Column id="decruitmentDate" header="退役时间" field="decruitmentDate" width="95" >			
			<next:TextField  />
		</next:Column>
	
		<next:Column id="soldierStartEndDate" header="服义务兵向起止时间" field="soldierStartEndDate" width="95" >			
			<next:TextField  />
		</next:Column>
	
		<next:Column id="soldierYears" header="所服义务兵役折算年限" field="soldierYears" width="95" >			
			<next:NumberField  />
		</next:Column>
	
		<next:Column id="forcesName" header="服役部队名称(番号)" field="forcesName" width="95" >			
			<next:TextField  />
		</next:Column>
	
		<next:Column id="forcesNo" header="服役部队代号" field="forcesNo" width="95" >			
			<next:TextField  />
		</next:Column>
	
		<next:Column id="lifeState" header="生活状况" field="lifeState" width="95" >			
			<next:TextField  />
		</next:Column>
	
		<next:Column id="familyNum" header="家庭人口" field="familyNum" width="95" >			
			<next:NumberField  />
		</next:Column>
	
		<next:Column id="youngNum" header="18岁(含)以下" field="youngNum" width="95" >			
			<next:NumberField  />
		</next:Column>
	
		<next:Column id="oldNum" header="60岁(含)以上" field="oldNum" width="95" >			
			<next:NumberField  />
		</next:Column>
	
		<next:Column id="isOrphanflag" header="是否属于孤老" field="isOrphanflag" width="95" >			
			<next:TextField  />
		</next:Column>
	
		<next:Column id="laborAbility" header="劳动能力" field="laborAbility" width="95" >			
			<next:TextField  />
		</next:Column>
	
		<next:Column id="isOtherBptobject" header="是否具有其他优抚对象身份" field="isOtherBptobject" width="95" >			
			<next:TextField  />
		</next:Column>
	
		<next:Column id="objectType" header="优抚对象类别" field="objectType" width="95" >			
			<next:TextField  />
		</next:Column>
	
		<next:Column id="isGuarant" header="是否享受低保待遇" field="isGuarant" width="95" >			
			<next:TextField  />
		</next:Column>
	
		<next:Column id="isFiveGuarant" header="是否享受五保待遇" field="isFiveGuarant" width="95" >			
			<next:TextField  />
		</next:Column>
	
		<next:Column id="identityBasis" header="身份认定依据" field="identityBasis" width="95" >			
			<next:TextField  />
		</next:Column>
	
		<next:Column id="regId" header="录入人" field="regId" width="95" >			
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="regTime" header="录入时间" field="regTime" width="95" >			
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="modId" header="修改人" field="modId" width="95" >			
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="modTime" header="修改时间" field="modTime" width="95" >			
			<next:TextField allowBlank="false" />
		</next:Column>
			
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>
