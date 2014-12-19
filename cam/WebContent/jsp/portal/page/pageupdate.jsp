<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>修改页面定义</title>
<next:ScriptManager></next:ScriptManager>
</head>
<%
  String id = request.getParameter("id");
  String layoutType=request.getParameter("layoutType");
%>
<body>
<model:datasets>
	<model:dataset id="portalPageDataset" cmd="org.loushang.portal.page.cmd.PortalPageQueryCmd" method="queryPortalPage" autoLoad="false" pageSize="1" global="true">
		<model:record fromBean="org.loushang.portal.page.data.PortalPage">
		</model:record>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" >
  <next:Html>
	<form action="" name="form1" method="post" onsubmit="return false" class="L5Form" dataset="portalPageDataset">
	  <table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<input  type="hidden" name="id" field="id">
			<td class="FieldLabel" width="10%" nowrap="nowrap"><label>页面名称:</label></td> 
			<td class="FieldInput" colspan="3">
				<input id="name" type="text"  name="name"  field="name" title="页面名称" maxlength="50"/><font color="red">*</font>
			</td>
		</tr>
		<tr>
		  <td class="FieldLabel" width="10%" nowrap="nowrap"><label >页面描述:</label></td> 
		  <td class="FieldInput" colspan="3">
			<textarea id="description" rows="3" cols="80" name="description" field="description" onKeyDown='if (this.value.length>=50){this.value=this.value.substring(0,49);}' ></textarea>
		  </td>
		</tr>
		<tr id="columnLayout1" style="display:none">
		  <td class="FieldLabel" rowspan="3" width="10%" nowrap="nowrap"><label >页面布局:</label></td> 
		  <td rowspan="3" width="10%" nowrap="nowrap" align="center"><label>简单布局</label></td>
		  <td align="center" width="5%" nowrap="nowrap"><label>简介</label></td>
		  <td nowrap="nowrap" width="75%">
			<label>页面被分割成纵向的几列，每列包含若干微件，微件可在同一列内或不同列间移动</label>
		  </td>
		</tr>
		<tr id="columnLayout2" style="display:none">
		  <td align="center" width="5%" nowrap="nowrap"><label>页面列数</label></td>
		  <td nowrap="nowrap" width="75%">
			<input id="onecolumn" value="1" type="radio" name="columnradio" onClick="changeLayout(1)"/><label >1列</label>
			<input id="twocolumns" value="2" type="radio" name="columnradio" onClick="changeLayout(2)"/><label >2列</label>
			<input id="threecolumns" value="3" type="radio" name="columnradio" onClick="changeLayout(3)"/><label>3列</label>
			<input id="fourcolumns" value="4" type="radio" name="columnradio"  onClick="changeLayout(4)"/><label>4列</label>
		  </td>
		</tr>
		<tr id="columnLayout3" style="display:none">
          <td align="center" width="5%" nowrap="nowrap"><label >每列宽度</label></td>
		  <td nowrap="nowrap" width="75%">
			<input id="firstColWidth" type="text" title="第一列宽度" maxlength="4"></input>
			<input id="secondColWidth" type="text" title="第二列宽度" maxlength="4"></input>
			<input id="thirdColWidth" type="text" title="第三列宽度" maxlength="4"></input>
			<input id="fourthColWidth" type="text" title="第四列宽度" maxlength="4"></input>
			<font color="red" size="2">*(请输入0.00~1.00之间的数字)</font>
		  </td>
		</tr>
		<tr id="absoluteLayout" style="display:none">
		  <td class="FieldLabel" width="10%" nowrap="nowrap"><label >页面布局:</label></td> 
		  <td width="10%" nowrap="nowrap" align="center"><label >任意布局</label></td>
		  <td align="center" width="5%" nowrap="nowrap"><label>简介</label></td>
		  <td nowrap="nowrap" width="75%">
			<label>可将微件放置在页面的任意位置，可调整微件的宽度及高度</label>
		  </td>
		</tr>
      </table>
    </form>
  </next:Html>
  <next:TopBar>
	<next:ToolBarItem/>
	  <next:ToolBarItem symbol="->"></next:ToolBarItem>
	  <next:ToolBarItem iconCls="save"  text="保存" handler="doSave"/>
	  <next:ToolBarItem iconCls="undo"  text="返回" handler="forReturn"/>
  </next:TopBar>
</next:Panel>
</body>
<script type="text/javascript">
function init(){
    var id='<%=id%>';
    portalPageDataset.setParameter("id",id);
    portalPageDataset.load(true);
    var record = portalPageDataset.getCurrent();
    //页面布局类型
    var layoutType=record.get("layoutType");
    //简单页面布局
    if(layoutType=="0")
    {
      //显示简单页面布局
      var columnLayout1=L5.getDom("columnLayout1");
      var columnLayout2=L5.getDom("columnLayout2");
      var columnLayout3=L5.getDom("columnLayout3");
      columnLayout1.style.display="";
      columnLayout2.style.display="";
      columnLayout3.style.display="";
      //设置列数及宽度
      var colCount = record.get("colCount");
      var colWidth = record.get("colWidth");
      var colRadioChecked=document.getElementsByName("columnradio");
      for(var i=0;i<colRadioChecked.length;i++){
        if(colCount==colRadioChecked[i].value){
    	  L5.getDom(colRadioChecked[i].id).checked="checked";
    	  break;
    	}
      }
      var colWidthNum = colWidth.split(";");
      switch(colWidthNum.length)
  	  {
  		case 1:
  			L5.getDom("firstColWidth").value=colWidthNum[0];
  			L5.getDom("secondColWidth").style.display="none";
  			L5.getDom("thirdColWidth").style.display="none";
  			L5.getDom("fourthColWidth").style.display="none";
  			break;
  		case 2:		
	        L5.getDom("firstColWidth").value=colWidthNum[0];
	        L5.getDom("secondColWidth").value=colWidthNum[1];
  			L5.getDom("thirdColWidth").style.display="none";
  			L5.getDom("fourthColWidth").style.display="none";
  		    break;
  		case 3:
	        L5.getDom("firstColWidth").value=colWidthNum[0];
	        L5.getDom("secondColWidth").value=colWidthNum[1];
	        L5.getDom("thirdColWidth").value=colWidthNum[2];
	        L5.getDom("fourthColWidth").style.display="none";
  			break;
  		case 4:
	    	L5.getDom("firstColWidth").value=colWidthNum[0];
	        L5.getDom("secondColWidth").value=colWidthNum[1];
	        L5.getDom("thirdColWidth").value=colWidthNum[2];
	        L5.getDom("fourthColWidth").value=colWidthNum[3];
  			break;			
      }
    }
    //任意布局
    else
    {
        //显示任意布局
        var absoluteLayout=L5.getDom("absoluteLayout");
        absoluteLayout.style.display="";
    }
}

function changeLayout(column){
	var firstColWidth = L5.getDom("firstColWidth");
	var secondColWidth = L5.getDom("secondColWidth");
	var thirdColWidth = L5.getDom("thirdColWidth");
	var fourthColWidth = L5.getDom("fourthColWidth");
	switch(column)
	{
		case 4:
			firstColWidth.style.display="";
			secondColWidth.style.display="";
			thirdColWidth.style.display="";
			fourthColWidth.style.display="";
			break;	
		case 3:
			firstColWidth.style.display="";
			secondColWidth.style.display="";
			thirdColWidth.style.display="";
			fourthColWidth.style.display="none";
			fourthColWidth.value="";
			break;
		case 2:		
			firstColWidth.style.display="";
		    secondColWidth.style.display="";
		    thirdColWidth.style.display="none";
		    thirdColWidth.value="";
		    fourthColWidth.style.display="none";
		    fourthColWidth.value="";
		    break;
		case 1:
			firstColWidth.style.display="";
			secondColWidth.style.display="none";
			secondColWidth.value="";
			thirdColWidth.style.display="none";
			thirdColWidth.value="";
			fourthColWidth.style.display="none";
			fourthColWidth.value="";
			break;
	}
}

function doSave(){
	var pageName = L5.getDom("name").value;
	if(!pageName||pageName.replace(/(^\s*)|(\s*$)/g, "")=="")
	{
		L5.MessageBox.alert("消息提示","[页面名称]不能为空!");
		return;
	}
	var description = L5.getDom("description").value;
	if(description.length>50)
	{
		L5.MessageBox.alert("消息提示","[页面描述]超长!");
		return false;
	}
	var records = portalPageDataset.getCurrent();
	//页面布局类型
	var layoutType="<%=layoutType%>";
	//简单页面布局类型
	if(layoutType=="0")
	{
		var colRadioChecked=document.getElementsByName("columnradio");
		var colWidth = "";
		//从最大列数开始循环,一般都是设置4列或者3列
		for(var i=colRadioChecked.length-1;i>=0;i--){
			if(colRadioChecked[i].checked){
				var colCount = colRadioChecked[i].value;
				switch(colCount)
				{
					case "1":
						var firstColWidth = L5.getDom("firstColWidth").value;
						if(!firstColWidth){
							L5.MessageBox.alert("消息提示","请输入完整的列宽度信息");
							return;
						}
						colWidth = firstColWidth
						break;
					case "2":
						var firstColWidth = L5.getDom("firstColWidth").value;
						var secondColWidth = L5.getDom("secondColWidth").value;
						if(!firstColWidth||!secondColWidth){
							L5.MessageBox.alert("消息提示","请输入完整的列宽度信息");
							return;
						}
						if(parseFloat(firstColWidth)+parseFloat(secondColWidth)>1){
							L5.MessageBox.alert("消息提示","列宽度总和不能大于1!");
							return;
						}
						colWidth = firstColWidth+";"+secondColWidth;
						break;
					case "3":
						var firstColWidth = L5.getDom("firstColWidth").value;
						var secondColWidth = L5.getDom("secondColWidth").value;
						var thirdColWidth = L5.getDom("thirdColWidth").value;
						if(!firstColWidth||!secondColWidth||!thirdColWidth){
							L5.MessageBox.alert("消息提示","请输入完整的列宽度信息");
							return;
						}
						if(parseFloat(firstColWidth)+parseFloat(secondColWidth)+parseFloat(thirdColWidth)>1){
							L5.MessageBox.alert("消息提示","列宽度总和不能大于1!");
							return;
						}
						colWidth = firstColWidth+";"+secondColWidth+";"+thirdColWidth;
						break;
					case "4":
						var firstColWidth = L5.getDom("firstColWidth").value;
						var secondColWidth = L5.getDom("secondColWidth").value;
						var thirdColWidth = L5.getDom("thirdColWidth").value;
						var fourthColWidth = L5.getDom("fourthColWidth").value;
						if(!firstColWidth||!secondColWidth||!thirdColWidth||!fourthColWidth){
							L5.MessageBox.alert("消息提示","请输入完整的列宽度信息");
							return;
						}
						if(parseFloat(firstColWidth)+parseFloat(secondColWidth)+parseFloat(thirdColWidth)+parseFloat(fourthColWidth)>1){
							L5.MessageBox.alert("消息提示","列宽度总和不能大于1!");
							return;
						}
						colWidth = firstColWidth+";"+secondColWidth+";"+thirdColWidth+";"+fourthColWidth;
						break;						
				}
				records.set("colCount",colCount);
				records.set("colWidth",colWidth);
				break;
			}
		}
	}

	records.set("name",pageName);
	records.set("description",description);
	records.set("layoutType",layoutType);
	
	var command = new L5.Command("org.loushang.portal.page.cmd.PortalPageCmd");
	command.setParameter("records", records);
	command.execute("updatePortalPage");
	if (!command.error) {
		L5.MessageBox.alert("消息提示", "保存成功!", function(){
			var url="jsp/portal/page/pagedef.jsp";
			L5.forward(url,"页面定义");
		});
	}
	else{
		L5.MessageBox.alert("消息提示",command.error);
		}
}
function forReturn(){
	var url="jsp/portal/page/pagedef.jsp";
	L5.forward(url,"页面定义");
}
</script>
</html>