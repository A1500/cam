<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>微件属性设置</title>
<next:ScriptManager></next:ScriptManager>
</head>
<body>
<next:Panel width="100%" >
  <next:Html>
	<form action="" name="form1" method="post" onsubmit="return false" class="L5Form" >
	  <table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td class="FieldLabel" width="30%" nowrap="nowrap"><label>微件宽度:</label></td> 
			<td class="FieldInput">
				<input id="widgetWidth" type="text"  name="widgetWidth" title="微件宽度" maxlength="4"/><font color="red">*</font>
			</td>
		</tr>
		<tr>
			<td class="FieldLabel" width="30%" nowrap="nowrap"><label>微件高度:</label></td> 
			<td class="FieldInput">
				<input id="widgetHeight" type="text"  name="widgetHeight" title="微件高度" maxlength="4"/><font color="red">*</font>
			</td>
		</tr>
      </table>
    </form>
  </next:Html>
  <next:TopBar>
  <next:ToolBarItem/>
	<next:ToolBarItem symbol="<span id=widgetName></span>"></next:ToolBarItem>
    <next:ToolBarItem symbol="->"></next:ToolBarItem>
    <next:ToolBarItem iconCls="save"  text="确定" handler="forSave"/>
    <next:ToolBarItem iconCls="no" text="关闭" handler="forClose"/>
  </next:TopBar>
</next:Panel>
</body>
<script type="text/javascript">
//初始化
function init()
{
	//从父窗口传递来的参数
	var obj=window.dialogArguments;
	//微件名称
	if(obj.widgetName)
	{
	   L5.getDom("widgetName").innerHTML="<font color='red'>["+obj.widgetName+"]</font>";
	}
	//微件宽度
	if(obj.widgetWidth)
	{
		L5.getDom("widgetWidth").value=obj.widgetWidth;
	}
	//微件高度
	if(obj.widgetHeight)
	{
		L5.getDom("widgetHeight").value=obj.widgetHeight;
	}
}

//确定
function forSave()
{
	//微件宽度
	var widgetWidth=L5.getDom("widgetWidth").value;
	if(!widgetWidth||widgetWidth.replace(/(^\s*)|(\s*$)/g, "")=="")
	{
		L5.MessageBox.alert("消息提示","[微件宽度]不能为空!");
		return false;
	}
	//微件高度
	var widgetHeight=L5.getDom("widgetHeight").value;
	if(!widgetHeight||widgetHeight.replace(/(^\s*)|(\s*$)/g, "")=="")
	{
		L5.MessageBox.alert("消息提示","[微件高度]不能为空!");
		return false;
	}
	var array=[];
	var regExp = /^[0-9]*[1-9][0-9]*$/; 
    if (!regExp.test(widgetWidth)) 
    { 
		L5.MessageBox.alert("消息提示","[微件宽度]只能输入正整数!");
		return false;
    } 

    if (!regExp.test(widgetHeight)) 
    { 
		L5.MessageBox.alert("消息提示","[微件高度]只能输入正整数!");
		return false;
    } 
	array.push(parseInt(widgetWidth));
	array.push(parseInt(widgetHeight));
	
	window.returnValue=array;
	window.close();	
}

//返回
function forClose()
{
  window.close();
}
</script>
</html>