var saveflag=true;
var jiazhuRecord=null;
function init(){
	if (method==null||method==""){
		L5.Msg.alert('提示',"未知的页面命令!");
	}
	else if(method=="INSERT"){
		buttonDisable();
		insertFamilyData();
	}else{
		updateFamilyData();//修改时加载页面
		$("familyName").disabled=true;
		$("sex").disabled=true;
		$("familyCardNo").disabled=true;
		$("nation").disabled=true;
		saveflag=false;
	}
}
function insertFamilyData(){//新增页面加载
	familyDataSet.newRecord({"familyId":familyId,"assistanceType":"D2","familyCardType":"0","assistanceTypeName":"城市低收入救助"
	,"apanageName":organName,"apanageCode":organCode,"idCardType":"0",'nation':'01','sex':'1','checkOrgName':'品牌'});//家庭信息
	lowApplyInfoDs.newRecord({"applyDate":nowDate,"townDate":nowDate,"incomeAppraiseDate":nowDate,"houseApproveDate":nowDate});//审批信息
}
function updateFamilyData(){//修改页面加载
	
	familyDataSet.setParameter("FAMILY_ID",familyId);
	familyDataSet.load();
	familyDataSet.on("load",loadpeople);
}
function loadpeople(ds){//加载成员
	ds.un("load",loadpeople);
    peopleListDataSet.setParameter("FAMILY_ID",familyId);
    peopleListDataSet.load();
    peopleListDataSet.on("load",loadsupport);
    
}
function loadsupport(ds){//加载赡养人	
	ds.un("load",loadsupport);
	
    lowSupportDataset.setParameter("FAMILY_ID",familyId);
    lowSupportDataset.load();
   	lowSupportDataset.on("load",loadconfirm);    
}
function loadconfirm(ds){//加载审批审核意见
	ds.un("load",loadconfirm);
    lowApplyInfoDs.setParameter("FAMILY_ID",familyId);
    lowApplyInfoDs.load();
    lowApplyInfoDs.on("load",loadEnd); 
  }
function loadEnd(){
	if(peopleListDataSet.getCount()>0){
			var index = peopleListDataSet.find("relationshipType","01",0);
			if(index>=0){
				
				jiazhuRecord = peopleListDataSet.getAt(index);
				var birthday = jiazhuRecord.get("birthday");
				var age= getAge(birthday);
				familyDataSet.set("age",age);

				familyDataSet.set("nation",jiazhuRecord.get("NATION"));//没有关联到数据库字段
				familyDataSet.set("sex",jiazhuRecord.get("SEX"));
								
			}
		}
	if (lowApplyInfoDs.getCount()==0){
		lowApplyInfoDs.newRecord();
};
}
//按钮禁用
function buttonDisable(){
	L5.getCmp("newSupport").setDisabled(true);
	L5.getCmp("newPeople").setDisabled(true);
	
}
//启用按钮
function buttonEnabled(){
	L5.getCmp("newPeople").setDisabled(false);
	L5.getCmp("newSupport").setDisabled(false);
}

function saveFamily(){//保存家庭信息和 审批信息
	var familyrecord = familyDataSet.getCurrent();//家庭信息
	var lowApplyRecord = lowApplyInfoDs.getCurrent();//审批信息
	var command = new L5.Command("com.inspur.cams.drel.application.cityLow.cmd.SamCityLowConfirmCmd");
	command.setParameter("record",familyrecord);
	command.setParameter("jiazhuRecord",jiazhuRecord);
		
	command.setParameter("lowApplyRecord",lowApplyRecord);
	if(!checkCardNo){return ;}	
	if(method=="INSERT"&&saveflag){
		command.execute("insert");
	}
	else if(method=="UPDATE"){
		command.execute("update");
	}
	if (!command.error) {
		if(method=="INSERT"&&saveflag){
			familyId=command.getReturn("familyId");
			//完善户主信息
			saveflag=false;
			var width = 1000;
			var height = 255;
			var url="cityLowPeopleInsert.jsp?familyId="+familyId+"&method=INSERTHUZHU";
			window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
			updateFamilyData();
			buttonEnabled();
		}
		else{
			L5.Msg.alert('提示',"保存成功");
		}
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}



function newPeople(){
//新增家庭成员
	var width = 1000;
	var height = 275;
	var url="cityLowPeopleInsert.jsp?familyId="+familyId+"&method=INSERT";
	window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
	updateFamilyData();		

}
function editPeople(){//编辑家庭成员
	var grid = L5.getCmp('peoplePanel');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		var peopleId=records[0].get('peopleId');
		
		var width = 1000;
		var height = 275;
		//编辑家庭成员信息的话只需要peopleId，但是刷新父窗口还是需要family_id
		var url="cityLowPeopleInsert.jsp?familyId="+familyId+"&peopleId="+peopleId+"&method=UPDATE";
		window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
		updateFamilyData();
	}
}
function delPeople(){
	var editGrid=L5.getCmp('peoplePanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	if(selected[0].get("RELATIONSHIP_TYPE")=='01'){			
		L5.Msg.alert('提示',"不能删除户主信息！");
		return;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var delId=selected[0].get("peopleId");
			var familyId=selected[0].get("familyId");
			var command= new L5.Command("com.inspur.cams.drel.application.cityLow.cmd.SamCityLowConfirmCmd");
			command.setParameter("delId", delId);
			command.setParameter("familyId", familyId);
			command.execute("delPeople");
			if (!command.error) {
				for(var i=0;i<selected.length;i++){
			    	peopleListDataSet.remove(selected[i]);
				}
				peopleListDataSet.commitChanges();
			}else{
				L5.Msg.alert('提示',"保存时出现错误！"+command.error);
			}
		}else{
			return false;
		}
	});
	updateFamilyData();		
}

function newSupport(){//添加赡养人员

	var width = 850;
	var height = 180;
	var url="supportInfo.jsp?familyId="+familyId+"&method=INSERT";
	window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
}
function editSupport(){
	var grid = L5.getCmp('supportPanel');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		var supportId=records[0].get('supportId');
		var familyId=records[0].get('familyId');
		var width = 850;
		var height = 180;
		var url="supportInfo.jsp?familyId="+familyId+"&supportId="+supportId+"&method=UPDATE";
		window.showModalDialog(url, window, "scroll:no;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
	}
}
function delSupport(){
	var editGrid=L5.getCmp('supportPanel');
	var selected = editGrid.getSelectionModel().getSelections();
	if(selected.length<1){
		L5.Msg.alert('提示',"请选择要删除的记录!");
		return false;
	}
	L5.MessageBox.confirm('确定', '确定要删除选中的记录吗?',function(state){
		if(state=="yes"){
			var delId=selected[0].get("supportId");
			var command= new L5.Command("com.inspur.cams.drel.application.cityLow.cmd.SamLowSupportPeopleCmd");
			command.setParameter("delId", delId);
			command.execute("lowSupportDelete");
			if (!command.error) {
				for(var i=0;i<selected.length;i++){
			    	lowSupportDataset.remove(selected[i]);
				}
				lowSupportDataset.commitChanges();
			}else{
				L5.Msg.alert('提示',"保存时出现错误！"+command.error);
			}
		}else{
			return false;
		}
	});
}



function submitApply(){
	var lowApplyRecord = lowApplyInfoDs.getCurrent();//审批信息

	var command = new L5.Command("com.inspur.cams.drel.application.cityLow.cmd.SamCityLowConfirmCmd");
	command.setParameter("lowApplyRecord",lowApplyRecord);
	command.execute("upDateConfirmInfo");
	
	if (!command.error) {
		L5.Msg.alert('提示',"保存成功");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}


}
/**
	 * 选择属地行政区划窗口
	 */
	function func_ForDomicileSelect() {
		var revalue = window.showModalDialog(
				L5.webPath + "/jsp/cams/comm/diccity/dicCity.jsp?radioMaxlevel=0&organCode="
						+ organArea + "&organName="
						+ escape(encodeURIComponent(organName)), "",
				"dialogHeight:500px;dialogWidth:450px;resizable:no;scroll:yes;");
		if (revalue != "" && revalue != undefined) {
			var list = revalue.split(";");
			//document.getElementById("apanageName").value = list[1];
			//document.getElementById("apanageCode").value = list[0];
			//document.getElementById("juzhudi").value = list[4];
			familyDataSet.set("apanageName",list[1]);
			familyDataSet.set("apanageCode",list[0]);
			familyDataSet.set("domicileName",list[1]);
			familyDataSet.set("domicileCode",list[0]);//DOMICILE_CODE
			familyDataSet.set("address",list[4]);
			
		}
	}
//计算年龄
function getAge(birthday){
	var date = new Date();
	var year = date.getFullYear();
	var birthYear = birthday.substr(0,4);
	var age = year-birthYear;
	if(age>=0){
		return age;
	}
	else{
		return 0;
	}
}
function getHuzhuAge(){
	var cardNo=document.getElementById('familyCardNo').value;
	if(cardNo==''){
		//L5.Msg.alert("提示","请输入身份证号");
		return false;
	}
	
	if(checkIdcard(cardNo)){
		var birth = cardNo.substr(6,4)+"-"+cardNo.substr(10,2)+"-"+cardNo.substr(12,2);
		var age = getAge(birth);
	
		document.getElementById('age').innerHTML=age;
	}

}

function returnBack(){
	var data = new L5.Map();
	var url='/jsp/cams/drel/application/cityLow/apply/cityLowFamilyListForInsert.jsp';
	if(from=="PEOPLE"){
		url='/jsp/cams/drel/application/cityLow/apply/cityLowFamilyListByPeople.jsp';
	}else if(from=="FAMILY"){
		url='/jsp/cams/drel/application/cityLow/apply/cityLowFamilyList.jsp';
	}
	var text = '城市低收入家庭信息';
	L5.forward(url,text,data);
}

function checkCardNo(){
	//var cardNo = document.getElementById('familyCardNo').value;
	var cardNo = _$('familyCardNo');
	if(cardNo==''){
		L5.Msg.alert("提示","请输入身份证号");
		return false;
	}
	//身份证号
	if(checkIdcard(cardNo) != true && !(cardNo.length==18 && cardNo.lastIndexOf("N")>0 )){
		L5.Msg.alert("提示","校验未通过："+"身份证号不合法");
		$('idCard_people').value='';
		return;
	}
		var command= new L5.Command("com.inspur.cams.drel.application.cityLow.cmd.SamCityLowConfirmCmd");
		command.setParameter("cardNo", cardNo);
		command.execute("checkCardId");
		
		var errorFlag=command.getReturn("errorFlag");
		var peopleId=command.getReturn("peopleId");
		var personalStatsTag=command.getReturn("personalStatsTag");//人员状态		
		familyId=command.getReturn("familyId");
		var relationshipType= command.getReturn("relationshipType");
		//alert(errorFlag+"--"+peopleId+"--"+personalStatsTag+"--"+familyId+"--"+relationshipType);
		if(errorFlag==""){
			if(personalStatsTag=='03'){//死亡
				L5.Msg.alert("提示","该人员已死亡！");
				$("familyCardNo").value='';
				return;
			}
			if(relationshipType=='01'){
				if(familyId != '' && typeof(familyId)!="undefined" && familyId!=null){
					method="UPDATE";
					updateFamilyData();
				}
			}
			else{
				L5.MessageBox.confirm('提示', '该人员所在家庭非户主'+'，是否把该人员从原来家庭中分离出来？',function(sta){
					if(sta=="yes"){
						//根据peopleID删除之前的baseinfo_people信息，重新组建新的家庭
						alert("daiwanshan");  						  		
					}else{
						$("familyCardNo").value='';
						return;
					}
				});
			}
		}
		return true;
}
function checkIdcard(num) 
{   
        num = num.toUpperCase();  
        //身份证号码为15位或者18位，15位时全为数字，18位前17位为数字，最后一位是校验位，可能为数字或字符X。   
        if (!(/(^\d{15}$)|(^\d{17}([0-9]|X)$)/.test(num)))   
        { 
            //alert('输入的身份证号长度不对，或者号码不符合规定！\n15位号码应全为数字，18位号码末位可以为数字或X。'); 
            return false; 
        } 
        //校验位按照ISO 7064:1983.MOD 11-2的规定生成，X可以认为是数字10。 
        //下面分别分析出生日期和校验位 
        var len, re; 
        len = num.length; 
        if (len == 15) 
        { 
            re = new RegExp(/^(\d{6})(\d{2})(\d{2})(\d{2})(\d{3})$/); 
            var arrSplit = num.match(re);

            //检查生日日期是否正确 
            var dtmBirth = new Date('19' + arrSplit[2] + '/' + arrSplit[3] + '/' + arrSplit[4]); 
            var bGoodDay; 
            bGoodDay = (dtmBirth.getYear() == Number(arrSplit[2])) && ((dtmBirth.getMonth() + 1) == Number(arrSplit[3])) && (dtmBirth.getDate() == Number(arrSplit[4])); 
            if (!bGoodDay) 
            { 
                //alert('输入的身份证号里出生日期不对！');   
                return false; 
            } 
            else 
            { 
                    //将15位身份证转成18位 
                    //校验位按照ISO 7064:1983.MOD 11-2的规定生成，X可以认为是数字10。 
                    var arrInt = new Array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2); 
                    var arrCh = new Array('1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2'); 
                    var nTemp = 0, i;   
                    num = num.substr(0, 6) + '19' + num.substr(6, num.length - 6); 
                    for(i = 0; i < 17; i ++) 
                    { 
                        nTemp += num.substr(i, 1) * arrInt[i]; 
                    } 
                    num += arrCh[nTemp % 11];   
                    return true;   
            }   
        } 
        if (len == 18) 
        { 
            re = new RegExp(/^(\d{6})(\d{4})(\d{2})(\d{2})(\d{3})([0-9]|X)$/); 
            var arrSplit = num.match(re);

            //检查生日日期是否正确 
            var dtmBirth = new Date(arrSplit[2] + "/" + arrSplit[3] + "/" + arrSplit[4]); 
            var bGoodDay; 
            bGoodDay = (dtmBirth.getFullYear() == Number(arrSplit[2])) && ((dtmBirth.getMonth() + 1) == Number(arrSplit[3])) && (dtmBirth.getDate() == Number(arrSplit[4])); 
            if (!bGoodDay) 
            { 
                //alert(dtmBirth.getYear()); 
                //alert(arrSplit[2]); 
                //alert('输入的身份证号里出生日期不对！'); 
                return false; 
            } 
        else 
        { 
            //检验18位身份证的校验码是否正确。 
            //校验位按照ISO 7064:1983.MOD 11-2的规定生成，X可以认为是数字10。 
            var valnum; 
            var arrInt = new Array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2); 
            var arrCh = new Array('1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2'); 
            var nTemp = 0, i; 
            for(i = 0; i < 17; i ++) 
            { 
                nTemp += num.substr(i, 1) * arrInt[i]; 
            } 
            valnum = arrCh[nTemp % 11]; 
            if (valnum != num.substr(17, 1)) 
            { 
                //alert('18位身份证的校验码不正确！应该为：' + valnum); 
                return false; 
            } 
            return true; 
        } 
     } 
 }  
