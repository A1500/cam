package com.inspur.cams.bpt.util;

public class BptField {
	public static String[][] basepeople={{"ID_CARD","身份证件号码","","B1"},
		{"NAME","姓名","","B2"},
		{"BIRTHDAY","出生日期","","B3"},
		{"NATION","民族","","B4"},
		{"SEX","性别","COMM.SEX","B5"},
		{"RELATIONSHIP_TYPE","户主关系代码","RELATIONSHIP.TYPE","B6"},
		{"DOMICILE_TYPE","户籍类别代码","DOMICILE.TYPE","B7"},
		{"DOMICILE_CODE","属地行政区划","","B8"},
		{"DOMICILE_ADDRESS","属地居住地址(户口簿)","","B9"},
		{"APANAGE_CODE","住址行政区划","","B10"},
		{"ADDRESS","住址","","B11"},
		{"SAFEGUARD_TYPE","医疗保障方式的代码","COMM.MEDICAL_STATUS","B12"},
		{"MEDICAL_CODE","医疗保险号","","B13"},
		{"PENSION_CODE","养老保障方式","COMM.PENSION_CODE","B14"},
		{"TEL_MOBILE","联系方式_手机","","B15"},
		{"TEL_OTHER","联系方式_其他","","B16"},
		{"POST_CODE","邮政编码","","B17"},
		{"HEALTH_CODE","健康状况代码","HEALTH.TYPE","B18"},
		{"EDU_CODE","文化程度代码","EDUCATION.TYPE","B19"},
		{"MARRIAGE_CODE","婚姻状况代码","MARRIAGE.STATE","B20"},
		{"POLITICAL_CODE","政治面貌代码","POLITICAL.LANDSCAPE","B21"},
		{"EMPLOYMENT_CODE","就业状况代码","EMPLOYMENT.CODE","B22"},
		{"INCOME_YEAR","年收入","","B23"},
		{"WORK_UNIT_NAME","工作单位_名称","","B24"},
		{"WORK_UNIT_CHARACTER","工作单位_性质","","B25"},
		{"WORK_UNIT_TEL","工作单位_电话","","B26"},
		{"WORK_UNIT_ADD","工作单位_地址","","B27"},
		{"APPROVE_DATE","批准日期","","B28"},
		{"OBJECT_STATE","优抚对象状态","OBJECT.STATE","B29"},
		{"OBJECT_TYPE","优抚对象类别","OBJECT.TYPE.PART","B30"},
		{"BPT_NO","优抚证书编号","","B31"},
		{"DOMICILE_NAME","属地行政区划地址","","B32"},
		
		//为双重身份导出准备起
		{"DEMOBILIZEDILL_FLAG","带病人员","OBJECT.STATE","B39"},
		{"TEST_FLAG","参试人员","OBJECT.STATE","B40"},
		{"DISABILITY_FLAG","伤残人员","OBJECT.STATE","B33"},
		{"DEPENDANT_FLAG","三属人员","OBJECT.STATE","B34"},
		{"DEMOBILIZED_FLAG","在乡人员","OBJECT.STATE","B35"},
		{"WAR_FLAG","参战人员","OBJECT.STATE","B36"},
		{"RETIRED_FLAG","60周岁退役士兵","OBJECT.STATE","B37"},
		{"MARTYR_OFFSPRING_FLAG","老烈子女","OBJECT.STATE","B38"},
		//为双重身份导出准备止
		{"CONSCRIPTC_DATE","入伍（参加工作）时间","","T1"},
		{"DECRUITMENT_DATE","退伍（离退休）时间","","T2"},
		{"ASDP_NO","退伍证号","","T3"},
		{"FORCES_NO","原部队（名称）番号","","T4"},
		{"POSITION","职务（级别）","","T5"},
		{"TESTED_TYPE","参试类别","TESTED.TYPE","T6"},
		{"IS_HEALTH_FLAG","是否参加职业健康检查","COMM.YESORNO","T7"},
		{"HEALTH_STATE_CODE","健康状况","HEALTH.TYPE","T8"},
		{"THIS_EXAMINATIONDATE","本次查体时间","","T9"},
		{"THE_EXAMINATIONDATE","上次查体时间","","T10"},
		{"LIFE_STATE_CODE","生活状况","LIFE.LIFE_STATE_CODE","T11"},
		{"DISABILITY_LEVEL_CODE","残疾等级","LEVEL.CODE","T12"},
		{"DISABILITY_NUM","先天性残疾子女数","","T13"},
		{"IDENTITY_BASIS","身份认定依据","","T14"},
		{"CONSCRIPTC_DATE","入伍（参加工作）时间","","W1"},
		{"DECRUITMENT_DATE","退伍（离退休）时间","","W2"},
		{"RETIRED_DATE","离退休时间","","W3"},
		{"ASDP_NO","退伍证号","","W4"},
		{"FORCES_NO","原部队（名称）番号","","W5"},
		{"POSITION","职务（级别）","","W6"},
		{"WAR_TYPE_CODE","参战类别","WARTYPE.CODE","W7"},
		{"HEALTH_STATE_CODE","健康状况","HEALTH.TYPE","W8"},
		{"LIFE_STATE_CODE","生活状况","LIFE.LIFE_STATE_CODE","W9"},
		{"STUDENT_FLAG","是否正在上学","COMM.YESORNO","D1"},
		{"HOLDER_FLAG","是否残疾","COMM.YESORNO","D2"},
		{"HOLDER_FLAG","是否持证人","COMM.YESORNO","D3"},
		{"LEZSW_CERTIFICATE_ID","烈士证书字号","","D4"},
		{"LEZSW_NAME","烈士姓名","","D5"},
		{"LEZSW_SEX","烈士性别","COMM.SEX","D6"},
		{"LEZSW_BIRTHDAY","出生日期","","D7"},
		{"CONSCRIPT_DATE","烈士入伍时间","","D8"},
		{"WORK_UNIT","烈士所在单位","","D9"},
		{"POSITION","烈士职务","","D10"},
		{"DEATH_DATE","烈士牺牲病故时间","","D11"},
		{"DEATH_ADDRESS","烈士牺牲病故地点","","D12"},
		{"LEZSW_APPROVE_DATE","烈士批准时间","","D13"},
		{"RELATIONSHIP","烈属与烈士关系","RELATION.TYPE","D14"},
		{"CONSCRIPT_DATE","入伍时间","","Dis1"},
		{"DISABILITY_WAR_CODE","伤残时期","WAR.CODE","Dis2"},
		{"IS_KOREA_WAR","是否抗美援朝","COMM.YESORNO","Dis3"},
		{"DISABILITY_GENUS_CODE","伤残属别","GENUS.CODE","Dis4"},
		{"DISABILITY_DATE","致残时间","","Dis5"},
		{"VETERANS_DATE","退伍时间","","Dis6"},
		{"RETIRED_DATE","离退休时间","","Dis7"},
		{"UINIT_OF_DISABILITY","致残时所在单位","","Dis8"},
		{"DISABILITY_ADD","致残地点","","Dis9"},
		{"DISABILITY_BODY","致残部位","","Dis10"},
		{"DISABILITY_REASON","致残原因","","Dis11"},
		{"DISABILITY_LEVEL_CODE","伤残等级","LEVEL.CODE","Dis12"},
		{"DISABILITY_CASE_CODE","伤残性质","CASE.CODE","Dis13"},
		{"CONSCRIPT_DATE","入伍时间","","demo1"},
		{"DECRUITMENT_DATE","复员时间","","demo2"},
		{"FORCES_NO","原部队番号","","demo3"},
		{"POSITION","职务","","demo4"},
		{"BELONGDATE","属于时期","DEMOBILIZED.BELONGDATE","demo5"},
		{"IS_KOREANWAR","是否抗美援朝","COMM.YESORNO","demo6"},
		{"ASDP_NO","复员证号","","demo7"},
		{"CONSCRIPT_DATE","入伍时间","","deill1"},
		{"DECRUITMENT_DATE","退伍时间","","deill2"},
		{"FORCES_NO","原部队番号","","deill3"},
		{"ASDP_NO","退伍证号","","deill4"},
		{"POSITION","职务","","deill5"},
		{"IS_WAR","是否参战","COMM.YESORNO","deill6"},
		{"IS_INNUCLEAR","是否涉核","COMM.YESORNO","deill7"},
		{"PHYSICLAL_STATUS","身体状况","PHYSICLAL.STATUS","deill8"},
		{"FAMILY_ECONOMICS","家庭经济状况","FAMILY.ECONOMICS","deill9"},
		{"ILLESS_INFO","患病信息","","deill10"},
		{"CONSCRIPT_DATE","入伍时间","","s1"},
		{"DECRUITMENT_DATE","退役时间","","s2"},
		{"FORCES_NAME","服役部队名称(番号)","","s3"},
		{"FORCES_NO","服役部队代号","","s4"},
		{"SOLDIER_START_DATE","服义务兵开始时间","","s5"},
		{"SOLDIER_END_DATE","服义务兵结束时间","","s6"},
		{"SOLDIER_YEARS","所服义务兵役折算年限","","s7"},
		{"FAMILY_NUM","家庭人口","","s8"},
		{"YOUNG_NUM","18岁(含)以下","","s9"},
		{"OLD_NUM","60岁(含)以上","","s10"},
		{"IS_GUARANT","是否享受低保待遇","COMM.YESORNO","s11"},
		{"IDENTITY_BASIS","身份认定依据","IDENTITY.CODE","s13"},
		{"STATUS_TYPE","身份类别","STATUS.TYPE","m1"},
		{"LEZSW_NAME","牺牲者姓名","","m2"},
		{"SACRIFICE_DATE","牺牲时间","","m3"},
		{"LEZSW_APPROVE_DATE","批准烈士（平反）时间","","m4"},
		{"RELATIONSHIP","与牺牲者关系","RELATION.SHIP","m5"},
		{"HOLDER_FLAG","是否持证人","COMM.YESORNO","m6"},
		{"LIFE_STATE_CODE","生活状况","LIFE.LIFE_STATE_CODE","m7"},
		{"GUARANT_FLAG","是否享受低保待遇","COMM.YESORNO","m8"},
		{"FIVE_GUARANT_FLAG","是否享受五保待遇","COMM.YESORNO","m9"},
		{"ENJOYED_TREAT_FLAG","是否享受过抚恤金","COMM.YESORNO","m10"},
		{"INSANITY_FLAG","是否精神病标志","COMM.YESORNO","p1"},
		{"OLD_LONELY_FLAG","孤老标志","COMM.YESORNO","p2"},
		{"ORPHAN_FLAG","孤儿标志","COMM.YESORNO","p3"},
		{"WORK_ABILITY_CODE","劳动能力代码","WORK.ABILITY.CODE","p4"},
		{"VIABILITY_CODE","优抚生活能力代码","VIABILITY.CODE","p5"},
		{"SUPPORT_PATTERN","优抚供养方式","SUPPORT.PATTERN","p6"},
		{"BANK","开户银行","BANK.CODE","p7"},
		{"ACCOUNT_NAME","开户名称","","p8"},
		{"ACCOUNT_CODE","银行账号","","p9"}
		
		
	};	

}
