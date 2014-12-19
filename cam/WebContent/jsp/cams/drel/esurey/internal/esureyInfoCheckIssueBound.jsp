<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
		<title>选择经济核对范围</title>
		<script type="text/javascript">
			var jtids='<%=request.getParameter("id")%>';
		</script>
		<next:ScriptManager/>
		<script type="text/javascript" src="esureyInfoCheckIssueBound.js"></script>
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

<next:ViewPort>
<next:GridPanel id="sbjtxxGridPanel" name="sbjtxxGridPanel" width="100%" height="400" notSelectFirstRow="true" 
	stripeRows="true" dataset="declareFamilyInfoDataset" title="->  您的位置 : 选择经济核对范围">	
	
	<next:TopBar>
		<next:ToolBarItem text="申报家庭基本信息列表:"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="detail" text="详细"/>
		<next:ToolBarItem iconCls="undo" text="返回" handler="returnQuery"/>
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
</next:ViewPort>
</body>
</html>
