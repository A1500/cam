function init() {
	grid=L5.getCmp("editGridPanel");
	grid.on("rowdblclick",callbackfn);//双击事件
	ds.setParameter("sort","SENS_LEVEL DESC,SENS_WORD ASC");
	L5.DatasetMgr.lookup("ds").load();
	L5.QuickTips.init();
}
/**
*g :L5.grid
* rowIndex :Number     行索引
*e:L5.EventObject
*/
function callbackfn(g, rowIndex ,e){	//双击事件具体内容
	updateshow();
}

function getParam(ElementId)
{
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}
/**
 * 执行查询操作
 * @return
 */
function query(){	
	
	ds.setParameter("SENS_WORD@LIKE",getParam("sensWord"));
	ds.setParameter("SENS_LEVEL@LIKE",getParam("sensLevel"));
	ds.setParameter("STAT@LIKE",getParam("querystat"));	
	ds.setParameter("sort","SENS_LEVEL DESC,SENS_WORD ASC");
	/*document.getElementById("sensWord").value='';//设置每次查询前把之前的值去掉
	document.getElementById("sensLevel").value='';
	document.getElementById("querystat").value='';*/
	ds.load();	
}
/**
 * 控制层的隐藏显示
 * @param element表单域的值
 * @param divname层的名字
 * @return
 */
function divshow(element,divname){
	//divname.style.display="none";每次判断之前先把层显示去掉。
	if(element==null || element==""){
		 divname.style.display="block";
		 return false;
	}
	return true;//返回TRUE，必须要使用
}
/**
 * 点击增加按钮时，显示增加界面，默认的敏感级别为"禁用"，"状态为使用"
 * @return
 */
function insertshow() {
	var win =L5.getCmp('addwindow');	
//	win.on("show",fo);
	win.show();
	document.getElementById("sensewordinput").value="";
	document.getElementById("levelselect").value="1";
	document.getElementById("statselect").value="1";
	worddiv1.style.display="none";//每次点击之前隐藏上次层显示
	leveldiv1.style.display="none";
	statdiv1.style.display="none";
	 
}
/*function fo(){//聚焦
	document.getElementById("sensewordinput").focus();	
	document.getElementById("sensewordinput").select();
}*/

/**
 * 当满足非空验证条件时后台执行插入操作
 * @return
 */
function insertexcute(){
	var sensewordinput = document.getElementById("sensewordinput").value;	
	var levelselect = document.getElementById("levelselect").value;	
	var statselect = document.getElementById("statselect").value;
	if(divshow(sensewordinput,worddiv1)){
		if( divshow(levelselect,leveldiv1)){
			if( divshow(statselect,statdiv1)){
				var command=new L5.Command("org.loushang.live.sensewords.cmd.SenseWordSaveCmd");
				command.setParameter("sensewordinput", sensewordinput);
				command.setParameter("levelselect", levelselect);
				command.setParameter("statselect", statselect);
				command.execute("addSenseWord");
				if (!command.error) {
					var result = command.getReturn("result");
					if("" != result) {
						L5.Msg.alert('提示',result);
						return false;
					} else {
						ds.commitChanges();
						ds.setParameter("sort","SENS_LEVEL DESC,SENS_WORD ASC");
						ds.load(true);
					}
				}else{
					L5.Msg.alert('提示',command.error);
				}
				return true;
			}else
				return false;
		}else
			return false;	
	}else
		return false;
	
}
/**
 * 用户点击保存按钮时执行的保存操作
 * @return
 */
function insert(){
	
	if(insertexcute())
	{
		var win =L5.getCmp('addwindow');
		win.hide();
	}else{
	return false;
	}
}
/**
 * 继续添加时的窗口
 * @return
 */
function insertagainshow() {
	var win =L5.getCmp('addwindow');
	win.show();
	document.getElementById("sensewordinput").value="";
	
	}
/**
 * 点击继续添加时执行操作，状态和上次输入的数据一致
 * @return
 */
function insertagain(){
	if(insertexcute())
	{
	insertagainshow();
	}else{
	return false;
	}
}
/**
 * 点击修改弹出界面
 * @return
 */
function updateshow(){
	
	var editGrid=L5.getCmp('editGridPanel');
	var selected=editGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		L5.Msg.alert('提示',"请选择一条记录修改!");
		return false;
	}else{
	var win =L5.getCmp('updatewindow');
	win.show();
	var  record=ds.getCurrent();
    var senswordup= record.get("sensWord");
    var senslevelup= record.get("sensLevel");
    var statup= record.get("stat");
    document.getElementById("stat").value = statup;
    document.getElementById("level").value = senslevelup;
    document.getElementById("senseword").value = senswordup;
   
    worddiv.style.display="none";//点击列前隐藏上次层显示
	leveldiv.style.display="none";
	statdiv.style.display="none";
	
	
	}
}
/**
 * 真正执行update操作
 * @return
 */
function updateexcute(){
	var  record=ds.getCurrent();
    var createTime= record.get("createTime");
    var refId= record.get("refId");
    var senseword = document.getElementById("senseword").value;
	var level = document.getElementById("level").value;
	var stat = document.getElementById("stat").value;
	if( divshow(senseword,worddiv)){
		if(divshow(level,leveldiv)){
		
			if(divshow(stat,statdiv)){	
				
				var command=new L5.Command("org.loushang.live.sensewords.cmd.SenseWordSaveCmd");
				command.setParameter("senseword",senseword);
				command.setParameter("level",level);
				command.setParameter("stat",stat);
				command.setParameter("createTime", createTime);
				command.setParameter("refId", refId);
				command.execute("updateSenseWord");
				if (!command.error) {
					var result = command.getReturn("result");
					if("nochange" == result) {
						ds.setParameter("sort","SENS_LEVEL DESC,SENS_WORD ASC");
						ds.load(true);
						return true;
					} else {
						ds.commitChanges();
						ds.setParameter("sort","SENS_LEVEL DESC,SENS_WORD ASC");
						ds.load(true);
						return true;
					}
				}else{
					L5.Msg.alert('提示',command.error);
				}	
				return true;
			}else
				return false;
		}else
			return false;
	}else
		return false;
}
/**
 * 点击修改执行的方法
 * @return
 */
function update(){
	if(updateexcute()){
		var win =L5.getCmp('updatewindow');
		win.hide();
	}
}
/**
 * 点击删除触发事件
 * @return
 */
function del(){
	var editGrid=L5.getCmp('editGridPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function fn(state){
	if(state=="yes"){
		var  delIds=[];
		for(var i=0;i<selected.length;i++){
			delIds[i]=selected[i].get("refId");
			
		}
		var command=new L5.Command("org.loushang.live.sensewords.cmd.SenseWordSaveCmd");
		command.setParameter("delIds", delIds);
		command.execute("deleteSenseWords");
		if (!command.error) {
			for(var i=0;i<selected.length;i++){
		    	ds.remove(selected[i]);
			}
			ds.commitChanges();
		}else{
			L5.Msg.alert('提示',command.error);
		}
	}else{
		return false;
	}
  });
}
/**
 * 点击取消时执行的操作
 */
function quxiao(windowname){
	var win =L5.getCmp(windowname);
	win.hide();
}
/**
 * 在修改窗口点击enter键时触发的事件，相当于点击保存，但是如果敏感词为空则相当于TAB键，经试验不会换到取消键
 * @return
 */
function insertEnter(){
	if(event.keyCode==13){		
		if(!insert()){
			event.keyCode=9;	
			document.getElementById("sensewordinput").focus();	
			return false;
			}else{
				
			}
	}
	
}
/**
 * 在修改窗口点击enter键时触发的事件，相当于点击修改，但是如果敏感词为空则相当于TAB键，经试验不会换到取消键
 * @return
 */
function updateEnter(){
	if(event.keyCode==13){		
		if(!update()){
			event.keyCode=9;
			document.getElementById("senseword").focus();
			return false;
			}else{
				
			}
	}
	
}
