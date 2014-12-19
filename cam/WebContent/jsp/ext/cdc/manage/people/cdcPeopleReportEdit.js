function init(){
	var peopleReportDataSet=L5.DatasetMgr.lookup("peopleReportDataSet");
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	if(method=="insert"){
		document.getElementById("backInsert").style.display = "block";
		peopleReportDataSet.newRecord({"organCode":organCode,"organName":organName,"parentCode":parentCode,"communityNum":"1","reportType":"C","organType":"1"});
		reportWorkDataSet.setParameter("organCode", organCode);
		reportWorkDataSet.load();
	}else{
		$("reportDate").disabled=true;
		peopleReportDataSet.setParameter("RECORD_ID@=",recordId);
		peopleReportDataSet.load();
		reportWorkDataSet.load();
	}
	var committeeDataSet=L5.DatasetMgr.lookup("committeeDataSet");
	committeeDataSet.on("load",function(){
		getCommitteeNum();
	});
	var workerDataSet=L5.DatasetMgr.lookup("workerDataSet");
	workerDataSet.on("load",function(){
		getWorkerNum();
	});
	var seasonDataSet = L5.DatasetMgr.lookup("seasonDataSet");
	seasonDataSet.on("load",function(){
		L5.getCmp("detailWin").setVisible(true);
		var season = document.getElementById("season");
		season.length = 0;
		season.add(new Option("请选择...",""))
		if (seasonDataSet.getCount()>0){
			seasonDataSet.each(function(record,index){
				season.add(new Option(record.get("SEASON"),record.get("SEASON")));
			});
		}
	});
}
function returnBack(){
	/*
	L5.MessageBox.confirm("提示", "是否保存数据？",function(sta){
		if(sta=="yes"){
			save();
		}else{
			var url="jsp/ext/cdc/manage/people/cdcPeopleReportList.jsp";
			L5.forward(url,'',null);
		}
	});
	*/
	var url="jsp/ext/cdc/manage/people/cdcPeopleReportList.jsp";
	L5.forward(url,'',null);
}
function gRender(val){
	if(val!=""){
		return val+" 个";
	}
}
function pRender(val){
	if(val!=""){
		return val+" 人";
	}
}
function aRender(val){
	if(val!=""){
		return val+" ㎡";
	}
}
function forInsert(){
	if(method=="update"){
		L5.MessageBox.confirm("提示", "重新提取数据会是原始数据丢失，确定重新提取？",function(sta){
			if(sta=="yes"){
				var seasonDataSet = L5.DatasetMgr.lookup("seasonDataSet");
				seasonDataSet.setParameter("organCode", organCode);
				seasonDataSet.load();
			}else{
				return false;
			}
		});
		
	}else{
		var seasonDataSet = L5.DatasetMgr.lookup("seasonDataSet");
		seasonDataSet.setParameter("organCode", organCode);
		seasonDataSet.load();
	}
}
function confirm(){
	L5.getCmp("detailWin").setVisible(false);
	var season = document.getElementById("season").value;
	var committeeDataSet=L5.DatasetMgr.lookup("committeeDataSet");
	committeeDataSet.setParameter("IF_COMMITTEE@=",1);
	committeeDataSet.setParameter("SEASON@=",season);
	committeeDataSet.setParameter("ORGAN_CODE@=",organCode);
	committeeDataSet.load();
	var workerDataSet=L5.DatasetMgr.lookup("workerDataSet");
	workerDataSet.setParameter("IF_COMMUNITY_WORKER@=",1);
	//workerDataSet.setParameter("COMMUNITY_WORKER_TYPE@=",1);
	workerDataSet.setParameter("ORGAN_CODE@=",organCode);
	workerDataSet.load();
}

 function getCommitteeNum(){
	var peopleReportDataSet=L5.DatasetMgr.lookup("peopleReportDataSet");
	var peopleReportRecord=peopleReportDataSet.getCurrent();
	var committeeDataSet=L5.DatasetMgr.lookup("committeeDataSet");
	var mbPeopleNum=0;//成员总人数
	var mbFemaleNum=0;//成员女性人数
	var mbThirtyNum=0;//成员30岁以下人数
	var mbFourtyNum=0;//成员31岁~40岁人数
	var mbFiftyNum=0;//成员41岁~50岁人数
	var mbSixtyNum=0;//成员50岁以上人数
	var mbFolkNum=0;//成员少数民族人数
	var mbCrossNum=0;//成员交叉任职人数
	var mbPartyNum=0;//成员党员人数
	var mbLeagueNum=0;//成员共青团员人数
	var mbOtherNum=0;//成员政治面貌其他人数
	var mbJuniorNum=0;//成员初中及以下人数
	var mbSeniorNum=0;//成员高中及中专人数
	var mbSpecialtyNum=0;//成员大学专科人数
	var mbCollegeNum=0;//成员大学本科人数
	var mbGraduateNum=0;//成员研究生及以上人数
	var mbAgedInNum=0;//成员参加养老保险人数
	var mbMedicalInNum=0;//成员医疗保险人数
	var mbUnemployInNum=0;//成员失业保险人数
	var mbInjuryInNum=0;//成员工伤保险人数
	var mbBirthInNum=0;//成员生育保险人数
	var mbHousingReNum=0;//成员公积金人数
	var mbSubsidyAvgMon=0;//成员人均约补贴收入
	committeeDataSet.each(function(record,index){
			mbPeopleNum++;
			if(record.get('sex')=='2'){//女性人数
				mbFemaleNum++;
			}
			if(record.get('birthday') != null && record.get('birthday') != ''){
				if(ages(record.get('birthday')) <= 30){//30岁以下人数
					mbThirtyNum++;
				}else if(ages(record.get('birthday')) <= 40){//40岁以下人数
					mbFourtyNum++;
				}else if(ages(record.get('birthday')) <= 50){//50岁以下人数
					mbFiftyNum++;
				}else if(ages(record.get('birthday')) > 50){//50岁以上人数
					mbSixtyNum++;
				}
			}
			if(record.get('nation')!='01' && record.get('nation')!= ''){//少数民族人数
				mbFolkNum++;
			}
			if(record.get('ifCross')=='1'){//交叉任职人数
				mbCrossNum++;
			}
			if(record.get('politicalCode')=='1'){//党员人数
				mbPartyNum++;
			}else if(record.get('politicalCode')=='2'){//共青团员人数
				mbLeagueNum++;
			}else if(record.get('politicalCode')=='3'){//政治面貌其他人数
				mbOtherNum++;
			}
			if(record.get('eduCode')=='1'){//初中及以下
				mbJuniorNum++;
			}else if(record.get('eduCode')=='2'){//高中及中专
				mbSeniorNum++;
			}else if(record.get('eduCode')=='3'){//大学专科
				mbSpecialtyNum++;
			}else if(record.get('eduCode')=='4'){//大学本科
				mbCollegeNum++;
			}else if(record.get('eduCode')=='5'){//研究生及以上
				mbGraduateNum++;
			}
			if(record.get('ifAgedInsurance')=='1'){//参加养老保险人数
				mbAgedInNum++;
			}
			if(record.get('ifMedicalInsurance')=='1'){//医疗保险人数
				mbMedicalInNum++;
			}
			if(record.get('ifUnemployInsurance')=='1'){//失业保险人数
				mbUnemployInNum++;
			}
			if(record.get('ifInjuryInsurance')=='1'){//工伤保险人数
				mbInjuryInNum++;
			}
			if(record.get('ifBirthInsurance')=='1'){//生育保险人数
				mbBirthInNum++;
			}
			if(record.get('ifHousingReserve')=='1'){//公积金人数
				mbHousingReNum++;
			}
			if(record.get('subsidyMon')!=''){//人均约补贴收入
				var num = mbSubsidyAvgMon*(mbPeopleNum-1);
				mbSubsidyAvgMon = num+record.get('subsidyMon');
				if(mbSubsidyAvgMon != '' && mbSubsidyAvgMon != 0){
					mbSubsidyAvgMon = mbSubsidyAvgMon/mbPeopleNum;
				}
			}
	});
	
	peopleReportRecord.set("mbPeopleNum",mbPeopleNum);
	peopleReportRecord.set("mbFemaleNum",mbFemaleNum);
	peopleReportRecord.set("mbThirtyNum",mbThirtyNum);
	peopleReportRecord.set("mbFourtyNum",mbFourtyNum);
	peopleReportRecord.set("mbFiftyNum",mbFiftyNum);
	peopleReportRecord.set("mbSixtyNum",mbSixtyNum);
	peopleReportRecord.set("mbFolkNum",mbFolkNum);
	peopleReportRecord.set("mbPartyNum",mbPartyNum);
	peopleReportRecord.set("mbLeagueNum",mbLeagueNum);
	peopleReportRecord.set("mbOtherNum",mbOtherNum);
	peopleReportRecord.set("mbJuniorNum",mbJuniorNum);
	peopleReportRecord.set("mbSeniorNum",mbSeniorNum);
	peopleReportRecord.set("mbSpecialtyNum",mbSpecialtyNum);
	peopleReportRecord.set("mbCollegeNum",mbCollegeNum);
	peopleReportRecord.set("mbGraduateNum",mbGraduateNum);
	peopleReportRecord.set("mbCrossNum",mbCrossNum);
	peopleReportRecord.set("mbAgedInNum",mbAgedInNum);
	peopleReportRecord.set("mbMedicalInNum",mbMedicalInNum);
	peopleReportRecord.set("mbUnemployInNum",mbUnemployInNum);
	peopleReportRecord.set("mbInjuryInNum",mbInjuryInNum);
	peopleReportRecord.set("mbBirthInNum",mbBirthInNum);
	peopleReportRecord.set("mbHousingReNum",mbHousingReNum);
	peopleReportRecord.set("mbSubsidyAvgMon",mbSubsidyAvgMon);
}
function getWorkerNum(){
	var peopleReportDataSet=L5.DatasetMgr.lookup("peopleReportDataSet");
	var peopleReportRecord=peopleReportDataSet.getCurrent();
	var workerDataSet=L5.DatasetMgr.lookup("workerDataSet");
	var wkPeopleNum=0;//社区总人数
	var wkFemaleNum=0;//社区女性人数
	var wkThirtyNum=0;//社区30岁以下人数
	var wkFourtyNum=0;//社区40岁以下人数
	var wkFiftyNum=0;//社区50岁以下人数
	var wkSixtyNum=0;//社区50岁以上人数
	var wkFolkNum=0;//社区少数民族人数
	var wkPartyNum=0;//社区党员人数
	var wkLeagueNum=0;//社区共青团员人数
	var wkOtherNum=0;//社区政治面貌其他人数
	var wkJuniorNum=0;//社区初中及以下人数
	var wkSeniorNum=0;//社区高中及中专人数
	var wkSpecialtyNum=0;//社区大学专科人数
	var wkCollegeNum=0;//社区大学本科人数
	var wkGraduateNum=0;//社区研究生及以上人数
	var wkOfficialNum=0;//社区公务员人数
	var wkEnterpriseNum=0;//社区事业编人数
	var wkRequiredNum=0;//社区招聘人员数
	var wkCorporationNum=0;//社区企业职工人数
	var wkResideNum=0;//社区社区居民人数
	var wkProOtherNum=0;//社区身份其他人数
	var wkAgedInNum=0;//社区参加养老保险人数
	var wkMedicalInNum=0;//社区医疗保险人数
	var wkUnemployInNum=0;//失业
	var wkInjuryInNum=0;//工伤
	var wkBirthInNum=0;//生育
	var wkHousingReNum=0;//公积金
	var wkWorkerNum=0;//社区社工师人数
	var wkSubsidyAvgMon=0;//社区人均约补贴收入
	workerDataSet.each(function(record,index){
		wkPeopleNum++;
		if(record.get('sex')=='2'){//女性人数
			wkFemaleNum++;
		}
		if(record.get('birthday') != null && record.get('birthday') != ''){
			if(ages(record.get('birthday')) < 30){//30岁以下人数
				wkThirtyNum++;
			}else if(ages(record.get('birthday')) <= 40){//40岁以下人数
				wkFourtyNum++;
			}else if(ages(record.get('birthday')) <= 50){//50岁以下人数
				wkFiftyNum++;
			}else if(ages(record.get('birthday')) > 50){//50岁以上人数
				wkSixtyNum++;
			}
		}
		if(record.get('nation')!='01'){//少数民族人数
			wkFolkNum++;
		}
		if(record.get('politicalCode')=='1'){//党员人数
			wkPartyNum++;
		}else if(record.get('politicalCode')=='2'){//共青团员人数
			wkLeagueNum++;
		}else if(record.get('politicalCode')=='3'){//政治面貌其他人数
			wkOtherNum++;
		}
		if(record.get('eduCode')=='1'){//初中及以下
			wkJuniorNum++;
		}else if(record.get('eduCode')=='2'){//高中及中专
			wkSeniorNum++;
		}else if(record.get('eduCode')=='3'){//大学专科
			wkSpecialtyNum++;
		}else if(record.get('eduCode')=='4'){//大学本科
			wkCollegeNum++;
		}else if(record.get('eduCode')=='5'){//研究生及以上
			wkGraduateNum++;
		}
		if(record.get('identity')=='1'){//公务员人数
			wkOfficialNum++;
		}else if(record.get('identity')=='2'){//事业编人数
			wkEnterpriseNum++;
		}else if(record.get('identity')=='3'){//招聘人员数
			wkRequiredNum++;
		}else if(record.get('identity')=='4'){//企业职工人数
			wkCorporationNum++;
		}else if(record.get('identity')=='5'){//社区居民人数
			wkResideNum++;
		}else if(record.get('identity')=='6'){//身份其他人数
			wkProOtherNum++;
		}
		if(record.get('ifAgedInsurance')=='1'){//参加养老保险人数
			wkAgedInNum++;
		}
		if(record.get('ifMedicalInsurance')=='1'){//医疗保险人数
			wkMedicalInNum++;
		}
		if(record.get('ifUnemployInsurance')=='1'){//失业保险人数
			wkUnemployInNum++;
		}
		if(record.get('ifInjuryInsurance')=='1'){//工伤保险人数
			wkInjuryInNum++;
		}
		if(record.get('ifBirthInsurance')=='1'){//生育保险人数
			wkBirthInNum++;
		}
		if(record.get('ifHousingReserve')=='1'){//公积金人数
			wkHousingReNum++;
		}
		if(record.get('ifOtherInsurance')=='1'){//其他保险人数
			wkOtherInNum++;
		}
		wkWorkerNum++;
		if(record.get('subsidyMon')!=''){//人均约补贴收入
			var num = wkSubsidyAvgMon*(wkPeopleNum-1);
			wkSubsidyAvgMon = num+record.get('subsidyMon');
			if(wkSubsidyAvgMon != '' && wkSubsidyAvgMon != 0){
				wkSubsidyAvgMon = wkSubsidyAvgMon/wkPeopleNum;
			}
		}
	});
	
	peopleReportRecord.set("wkPeopleNum",wkPeopleNum);
	peopleReportRecord.set("wkFemaleNum",wkFemaleNum);
	peopleReportRecord.set("wkThirtyNum",wkThirtyNum);
	peopleReportRecord.set("wkFourtyNum",wkFourtyNum);
	peopleReportRecord.set("wkFiftyNum",wkFiftyNum);
	peopleReportRecord.set("wkSixtyNum",wkSixtyNum);
	peopleReportRecord.set("wkFolkNum",wkFolkNum);
	peopleReportRecord.set("wkPartyNum",wkPartyNum);
	peopleReportRecord.set("wkLeagueNum",wkLeagueNum);
	peopleReportRecord.set("wkOtherNum",wkOtherNum);
	peopleReportRecord.set("wkJuniorNum",wkJuniorNum);
	peopleReportRecord.set("wkSeniorNum",wkSeniorNum);
	peopleReportRecord.set("wkSpecialtyNum",wkSpecialtyNum);
	peopleReportRecord.set("wkCollegeNum",wkCollegeNum);
	peopleReportRecord.set("wkGraduateNum",wkGraduateNum);
	peopleReportRecord.set("wkOfficialNum",wkOfficialNum);
	peopleReportRecord.set("wkEnterpriseNum",wkEnterpriseNum);
	peopleReportRecord.set("wkRequiredNum",wkRequiredNum);
	peopleReportRecord.set("wkCorporationNum",wkCorporationNum);
	peopleReportRecord.set("wkResideNum",wkResideNum);
	peopleReportRecord.set("wkProOtherNum",wkProOtherNum);
	peopleReportRecord.set("wkAgedInNum",wkAgedInNum);
	peopleReportRecord.set("wkMedicalInNum",wkMedicalInNum);
	peopleReportRecord.set("wkUnemployInNum",wkUnemployInNum);
	peopleReportRecord.set("wkInjuryInNum",wkInjuryInNum);
	peopleReportRecord.set("wkBirthInNum",wkBirthInNum);
	peopleReportRecord.set("wkHousingReNum",wkHousingReNum);
	peopleReportRecord.set("wkWorkerNum",wkWorkerNum);
	peopleReportRecord.set("wkSubsidyAvgMon",wkSubsidyAvgMon);
}
function ages(strBirthday)   
  {   
  	var returnAge;
 // 	var strBirthday = '';
    var strBirthdayArr=strBirthday.split("-");
    var birthYear = strBirthdayArr[0];
    var birthMonth = strBirthdayArr[1];
    var birthDay = strBirthdayArr[2];
    
    d = new Date();
    var nowYear = d.getYear();
    var nowMonth = d.getMonth() + 1;
    var nowDay = d.getDate();
    
    if(nowYear == birthYear)
    {
        returnAge = 0;//同年 则为0岁
    }
    else
    {
        var ageDiff = nowYear - birthYear ; //年之差
        if(ageDiff > 0)
        {
            if(nowMonth == birthMonth)
            {
                var dayDiff = nowDay - birthDay;//日之差
                if(dayDiff < 0)
                {
                    returnAge = ageDiff - 1;
                }
                else
                {
                    returnAge = ageDiff ;
                }
            }
            else
            {
                var monthDiff = nowMonth - birthMonth;//月之差
                if(monthDiff < 0)
                {
                    returnAge = ageDiff - 1;
                }
                else
                {
                    returnAge = ageDiff ;
                }
            }
        }
        else
        {
            returnAge = -1;//返回-1 表示出生日期输入错误 晚于今天
        }
    }
    
    return returnAge;//返回周岁年龄
  }
function save(){
	var peopleReportDataSet=L5.DatasetMgr.lookup("peopleReportDataSet");
	var isValidate = true;
	var record=peopleReportDataSet.getCurrent();
	if(record.get("reportDate")==""){
		L5.Msg.alert("提示","填报日期不能为空！");
		return;
	}
	isValidate = peopleReportDataSet.isValidate(true);
	if (isValidate !=true) {
		L5.Msg.alert("提示", "校验未通过,不能保存!" + isValidate);
		return false;
	}
	var command=new L5.Command("com.inspur.cams.cdc.base.cmd.CdcPeopleReportCmd");
	command.setParameter("record",record);
	if(method=="insert"){
		command.execute("insert");
	}else if(method=="update"){
		command.execute("update");
	}
	if (!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			var url="jsp/ext/cdc/manage/people/cdcPeopleReportList.jsp";
			L5.forward(url,'',null);
		});
	}else{
		L5.Msg.alert("提示","保存出错！");
	}
}