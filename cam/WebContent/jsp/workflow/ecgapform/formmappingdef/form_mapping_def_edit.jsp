<%@ page language="java" contentType="text/html;charset=utf-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
		<title>流程表单映射设置</title>
		<next:ScriptManager></next:ScriptManager>
		<script language="javascript"  type="text/javascript" >
		//标识数组，记录已经含有的表单映射项，增加新的表单映射项的时候会据此判断，如果已经含有那么不允许增加
		var mappingItems=[];
		//获取应用根路径
		function getUrlContext()
		{
			var url=document.URL.split("?")[0];
			var url=url.replace("http://","");
			var temp=url.split("/");
			return "http://"+temp[0]+"/"+temp[1]+"/";
		}
		//获取id为参数id的元素的值
		function $(id)
		{
			return document.getElementById(id).value;
		}

		//判断val是否是合法的数据值
		function valueIsValid(val)
		{
			if(val!=undefined&&val!="undefined"&&val!=null&&val!=""&&val!="null")
			{
				return true;
			}
			return false;
		}

		var mappingId='<%=request.getParameter("mappingId")%>';

		//初始化函数
		function init()
		{
			//如果mappingID是合法呢数据值，那么是更新
			//首先根据mappingID获取到相应的表单映射
			//将获取到的表单映射信息赋值到相应的页面域中（表单ID，表单名称，关联表单ID，关联表单名称），并在表单映射的Dataset中增加该记录
			//根据映射加载相应的映射项，如果映射项存在，那么将映射项放到映射项的dataset中
			if(valueIsValid(mappingId))
			{
				var command=new L5.Command("org.loushang.workflow.ecgapform.formmappingdef.cmd.FormMappingCmd"); 
				command.setParameter("mappingId",mappingId);
				command.execute("get");
				if(!command.error)
				{
					var result=command.getReturn("formMapping");
					if(valueIsValid(result))
					{
						var formMappingDataset=L5.DatasetMgr.lookup("formMappingDataset");
						formMappingDataset.removeAll();
						formMappingDataset.newRecord({mappingId:result.mappingId,mappingName:result.mappingName,formId:result.formId,formCaption:result.formCaption,associatedFormId:result.associatedFormId,associatedFormCaption:result.associatedFormCaption});											
						document.getElementById("mappingName").value=result.mappingName;
						document.getElementById("formCaption").value=result.formCaption;
						document.getElementById("formId").value=result.formId;
						document.getElementById("associatedFormCaption").value=result.associatedFormCaption;
						document.getElementById("associatedFormId").value=result.associatedFormId;
						getSourceTableFields();
						getAssociatedTableFields();
						command.setParameter("mappingId",mappingId);
						command.execute("queryFormMappingItems");
						if(!command.error)
						{
							var items=command.getReturn("formMappingItems");
							if(valueIsValid(items))
							{
								var mappingItemDataset=L5.DatasetMgr.lookup("formMappingItemDataset");
								mappingItemDataset.removeAll();
								for(var i=0;i<items.size();i++)
								{
									var item=items.get(i);
									mappingItemDataset.newRecord({mappingItemId:item.mappingItemId,mappingId:item.mappingId,fieldId:item.fieldId,fieldTitle:item.fieldTitle,mappingRule:item.mappingRule});										
									mappingItems[item.fieldId+item.mappingRule]=item;
								}
							}
						}
						else
						{
							L5.Msg.alert("提示","加载映射项失败！");
						}
					}
				}
				else
				{
					L5.Msg.alert("错误",command.error);
				}	
			}
		}

		//选择表单后触发的函数
		function selectForm(type)
		{
			//选择表单
			var dialogurl=getUrlContext()+"jsp/workflow/ecgapform/formmappingdef/process_form_selector.jsp";
			var ret=showModalDialog(dialogurl,window,"dialogWidth:800px;dialogHeight:600px;dialogLeft:150;dialogTop:50;help:no;status:no;scroll:yes;resizable:yes");
			if(ret!=null)
			{
				//如果选中了表单那么如果是选源表单，判断源表单和映射表单是否是同一表单，是提示错误；不是则加载表单的域并增加到相应的下拉框
				//如果选中的表单是映射表单，那么判断它和源表单是否是同意表单，如果是提示错误；如果不是则加载表单域并增加到相应的下拉框
				if(type=="source_form")
				{
					if(ret[0]==$("associatedFormId"))
					{
						L5.Msg.alert("提示","不能建立同一表单的映射关系！");
						return false;
					}
					document.getElementById("formCaption").value=ret[1];
					document.getElementById("formId").value=ret[0];
					getSourceTableFields();
				}
				else
				{
					if($("formId")==ret[0])
					{
						L5.Msg.alert("提示","不能建立同一表单的映射关系！");
						return false;
					}
					document.getElementById("associatedFormCaption").value=ret[1];
					document.getElementById("associatedFormId").value=ret[0];
					getAssociatedTableFields();
				}
				//如果源表单和映射表单的值是符合条件的，那么根据源表单和映射表单获取相应的表单映射
				//如果映射存在，那么根据映射加载映射项：如果映射项存在，将映射项加到映射项DataSet中并展示；
				//如果映射不存在，根据选中的表单信息增加一条新的记录到映射的Dataset中
				if(valueIsValid($("formId"))&&valueIsValid($("associatedFormId")))
				{
					var mappingItemDataset=L5.DatasetMgr.lookup("formMappingItemDataset");
					mappingItemDataset.removeAll();
					var command=new L5.Command("org.loushang.workflow.ecgapform.formmappingdef.cmd.FormMappingCmd"); 
					command.setParameter("formId",$("formId"));
					command.setParameter("associatedFormId",$("associatedFormId"));
					command.execute("queryFormMappingByFormIdAndAssociatedFormId");	
					if(!command.error)
					{
						var result=command.getReturn("formMapping");
						if(valueIsValid(result))
						{
							var formMappingDataset=L5.DatasetMgr.lookup("formMappingDataset");
							formMappingDataset.removeAll();
							formMappingDataset.newRecord({mappingId:result.mappingId,mappingName:result.mappingName,formId:result.formId,formCaption:result.formCaption,associatedFormId:result.associatedFormId,associatedFormCaption:result.associatedFormCaption});											
							command.setParameter("mappingId",result.mappingId);
							command.execute("queryFormMappingItems");
							if(!command.error)
							{
								var items=command.getReturn("formMappingItems");
								if(valueIsValid(items))
								{
									for(var i=0;i<items.size();i++)
									{
										var item=items.get(i);
										mappingItemDataset.newRecord({mappingItemId:item.mappingItemId,mappingId:item.mappingId,fieldId:item.fieldId,fieldTitle:item.fieldTitle,mappingRule:item.mappingRule});										
										mappingItems[item.fieldId+item.mappingRule]=item;
									}
								}
							}
							else
							{
								L5.Msg.alert("提示","加载映射项失败！");
							}
						}
						else
						{
							var formMappingDataset=L5.DatasetMgr.lookup("formMappingDataset");
							formMappingDataset.removeAll();
							formMappingDataset.newRecord({mappingId:"",mappingName:$("mappingName"),formId:$("formId"),formCaption:$("formCaption"),associatedFormId:$("associatedFormId"),associatedFormCaption:$("associatedFormCaption")});	
						}
					}
					else
					{
						L5.Msg.alert("错误",command.error);
					}
				}
			}
		}

		//得到源表单的域列表，并添加到相应的dataset中
		function getSourceTableFields()
		{
			var formId=$("formId");
			var command=new L5.Command("org.loushang.workflow.ecgapform.formdef.cmd.FormDefCmd"); 
			command.setParameter("formId",formId);
			command.execute("getFormFields");	
			if (!command.error) {
				var result=command.getReturn("fieldList");
				addOptionToList("source_form_select",result);
			}else{
				L5.Msg.alert("错误",command.error);
			}
		}

		//得到映射表单的域列表，并添加到相应的dataset中
		function getAssociatedTableFields()
		{
			var associatedFormId=$("associatedFormId");
			var command=new L5.Command("org.loushang.workflow.ecgapform.formdef.cmd.FormDefCmd"); 
			command.setParameter("formId",associatedFormId);
			command.execute("getFormFields");	
			if (!command.error) {
				var result=command.getReturn("fieldList");
				addOptionToList("associate_form_select",result);
			}else{
				L5.Msg.alert("错误",command.error);
			}
		}

		//添加域到select控件中
		function addOptionToList(id,ls)
		{
			var ele=document.getElementById(id);
			var length=ele.options.length;
			for(var j=length-1;j>=0;j--)
			{
				ele.options.remove(j);
			}
			if(ls==undefined||ls=="undefined"||ls==null)
				return;
			for(var i=0;i<ls.size();i++)
			{
				var field=ls.get(i);
				var opt=new Option(field.fieldTitle,field.field);
				ele.options.add(opt);
			}
		}
		//增加映射项的处理函数
		//获取选中的域信息，并构造新的表单映射项，将新映射项增加到dataset中
		function addMappingItem()
		{
			if(valueIsValid($("formId"))&&valueIsValid($("associatedFormId")))
			{
				var mappingItemDataset=L5.DatasetMgr.lookup("formMappingItemDataset");
				var associatedSelect=document.getElementById("associate_form_select");
				if(associatedSelect.selectedIndex==-1)
				{
					L5.Msg.alert("提示","请选择数据源域！");
					return;
				}
				var mappingRule=associatedSelect.options[associatedSelect.selectedIndex].value;
				var sourceSelect=document.getElementById("source_form_select");
				if(sourceSelect.selectedIndex==-1)
				{
					L5.Msg.alert("提示","请选择数据目标域！");
					return;
				}
				var fieldId=sourceSelect.options[sourceSelect.selectedIndex].value;
				var fieldTitle=sourceSelect.options[sourceSelect.selectedIndex].text;
				if(valueIsValid(mappingItems[fieldId+mappingRule]))
				{
					L5.Msg.alert("提示","该字段已经映射，如果需要重新映射请先删除之前的映射！");
					return;
				}
				else
				{
					mappingItemDataset.newRecord({mappingItemId:"",mappingId:"",fieldId:fieldId,fieldTitle:fieldTitle,mappingRule:mappingRule});
					mappingItems[fieldId+mappingRule]=fieldId;
				}
			}
			else
			{
				L5.Msg.alert("提示","映射关系不完整，请填写完整后再保存！");
			}
		}

		//删除映射项的处理函数
		function deleteMappingItem()
		{
			var userGrid=L5.getCmp('userGridPanel');
			var selected = userGrid.getSelectionModel().getSelections();
			if(selected.length<1){
				L5.Msg.alert("提示","请选择要删除的记录");
				return false;
			}
			var mappingItemDataSet = L5.DatasetMgr.lookup("formMappingItemDataset");
			L5.MessageBox.confirm('确定', '确定要删除选中的记录吗？',function(state){
				if(state=="yes"){
					var itemIds=[];
					for(var i=0;i<selected.length;i++){
						itemIds[i]=selected[i].get("mappingItemId");
					}
					var command=new L5.Command("org.loushang.workflow.ecgapform.formmappingdef.cmd.FormMappingCmd"); 
					command.setParameter("itemIds", itemIds);
					command.execute("deleteMappingItems");
					if (!command.error) {
						for(var i=0;i<selected.length;i++){
							mappingItemDataSet.remove(selected[i]);		    	
						}
						L5.Msg.alert("提示","删除成功");
					}else{
						L5.Msg.alert("错误",command.error);
					}
				}else{
					return false;
				}
			});
		}

		//保存映射项的处理函数
		//表单映射和映射项同时进行保存
		function saveMappingItem()
		{
			var formMapping=getFormMapping();			
			var formMappingItems=getFormMappingItems();
			if(!formMapping || !formMappingItems){
				L5.Msg.alert("提示","没有需要保存的数据");
				return;
			}
			var command=new L5.Command("org.loushang.workflow.ecgapform.formmappingdef.cmd.FormMappingCmd"); 
			command.setParameter("formMapping",formMapping);
			command.setParameter("formMappingItems",formMappingItems);
			command.execute("insert");	
			if (!command.error) {
				L5.Msg.alert("提示","保存成功");
				var url='jsp/workflow/ecgapform/formmappingdef/form_mapping_def.jsp';
			    var text = '流程映射管理';
			    L5.forward(url,text);
			}else{
				L5.Msg.alert("错误",command.error);
			}
		}
		//获取当前映射记录
		function getFormMapping()
		{
			var formMappingDataset=L5.DatasetMgr.lookup("formMappingDataset");
			var ls=formMappingDataset.getAllRecords();
			if(ls.length<1){				
				return null;
			}
			return ls[0].toBean("org.loushang.workflow.ecgapform.formmappingdef.data.FormMapping");
		}

		//获取映射项
		function getFormMappingItems()
		{
			var mappingItemDataset=L5.DatasetMgr.lookup("formMappingItemDataset");
			var ls=mappingItemDataset.getAllRecords();
			if(ls.length<1){
				return null;
			}
			var items=[];
			for(var i=0;i<ls.length;i++)
			{
				items[i]=ls[i].toBean("org.loushang.workflow.ecgapform.formmappingdef.data.FormMappingItem");
			}
			return items;
		}

		function backToQuery()
		{
			var url='jsp/workflow/ecgapform/formmappingdef/form_mapping_def.jsp';
		    var text = '流程映射管理';
		    L5.forward(url,text);
		}

		function updateRecord()
		{
			var formMappingDataset=L5.DatasetMgr.lookup("formMappingDataset");
			var ls=formMappingDataset.getAllRecords();
			if($('mappingName')!=ls[0].get("mappingName"));
			{
				ls[0].set("mappingName",$('mappingName'));
			}
		}
		</script>
	</head>
<body>
<div style="display:none">
	<model:datasets>
		<model:dataset id="formMappingItemDataset" pageSize="10" cmd="org.loushang.workflow.ecgapform.formmappingdef.cmd.FormMappingQueryCmd" method="queryFormMappingItemsByMappingId" >
			<model:record>
				<model:field name="mappingItemId"  type="string" />
				<model:field name="mappingId"  type="string" />
				<model:field name="fieldId" type="string" />
				<model:field name="fieldTitle" type="string" />
				<model:field name="mappingRule" type="string" />
			</model:record>
		    <model:params>
			<model:param name="mapping_Id" value='<%=request.getParameter("mappingId")%>'></model:param>
			</model:params>
		</model:dataset>
		<model:dataset id="formMappingDataset" pageSize="1" cmd="org.loushang.workflow.ecgapform.formmappingdef.cmd.FormMappingCmd">
			<model:record>
				<model:field name="mappingId"  type="string" />
				<model:field name="mappingName" type="string" />
				<model:field name="formId" type="string" />
				<model:field name="formName" type="string" />
				<model:field name="associatedFormId" type="string" />
				<model:field name="associatedFormName" type="string" />
			</model:record>
		</model:dataset>
	</model:datasets>
</div>
<next:ViewPort>
	<next:BorderLayout>
		<next:Center floatable="true" cmargins="0 0 0 0" margins="0 0 0 0" >
			<next:Panel>
			<next:Panel width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;">
				<next:Html>			
				<fieldset style="overflow: visible;" class="GroupBox">
					<div class="GroupBoxDiv" style="width: 100%;height: 100%;">	
						<form onsubmit="return false;"  class="L5form">				
							<table  border="1" width="100%">
								<tr>
									<td class="FieldLabel">数据源表单名称：</td>
									<td class="FieldInput">
										<input id="associatedFormCaption"  class="TextEditor" title="数据源表单名称" style="width:200" />
										<input type="hidden"  id="associatedFormId" class="TextEditor" title="数据源表单ID" />
									</td>
									<td class="FieldButton"><input type="button" value="选择表单" onclick="selectForm('associated_form')" style="width:75px;" /></td>
								
									<td class="FieldLabel" style="width:200px;">目标表单名称：</td>
									<td class="FieldInput">
										<input id="formCaption" class="TextEditor" title="目标表单名称" style="width:200" />
										<input type="hidden"  id="formId" class="TextEditor" title="目标表单ID" />
									</td>
									<td class="FieldButton">
										<input type="button" value="选择表单" onclick="selectForm('source_form')" style="width:75px;" />
									</td>
								</tr>
								<tr>
									<td class="FieldLabel">数据源域描述：</td>
									<td class="FieldInput" colspan="2">
										<select id="associate_form_select" style="width:100%;height:100" size="6">
										</select>
									</td>	
									<td class="FieldLabel" style="width:200px;">目标域描述：</td>
									<td class="FieldInput" colspan="2">
										<select id="source_form_select" style="width:100%;height:100" size="6" >
										</select>
									</td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width:100">映射名称</td>
									<td class="FieldInput" colspan="4">
										<input id="mappingName" class="TextEditor" style="width:70%" title="映射名称" onblur="updateRecord()"/>
										<font color="red">注意：如果未输入，系统自动生成！</font>
									</td>	
									<td class="FieldButton"><button onclick="addMappingItem()" style="width:75px;" >增 加</button></td>								
								</tr>
							</table>
						</form>		
					</div>
				</fieldset>
				</next:Html>
			</next:Panel>			
			<next:GridPanel id="userGridPanel" name="userGridPanel" width="100%" height="100%" dataset="formMappingItemDataset"     title="表单映射项列表" notSelectFirstRow="true">
				<next:Columns>
	   				<next:RowNumberColumn width="30"/>
	    			<next:CheckBoxColumn></next:CheckBoxColumn>
					<next:Column id="id" header="内码" field="mappingItemId" width="50" hidden="true" >
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column id="id" header="内码" field="mappingId" width="50" hidden="true" >
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="目标域ID" field="fieldId" width="200" >
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="目标域描述" field="fieldTitle" width="250" >
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="映射规则" field="mappingRule" width="300">
					<next:TextField allowBlank="false"/>
					</next:Column>
				</next:Columns>
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem iconCls="save"  text="保存" handler="saveMappingItem"/>
					<next:ToolBarItem iconCls="delete"  text="删除" handler="deleteMappingItem"/>
					<next:ToolBarItem iconCls="undo"  text="返回" handler="backToQuery"/>
				</next:TopBar>
				<next:BottomBar>
					<next:PagingToolBar dataset="formMappingItemDataset"/>
				</next:BottomBar>
			</next:GridPanel>
			</next:Panel>
		</next:Center>
	</next:BorderLayout>
</next:ViewPort>
</body>
</html>