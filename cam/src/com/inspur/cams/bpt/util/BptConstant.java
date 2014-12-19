package com.inspur.cams.bpt.util;

/**
 * 定义优抚常量
 */
public class BptConstant{
	
	//提交标志
	public static final String UN_COMMIT_FLAG = "0";
	public static final String COMMIT_FLAG = "1";
	
	//伤残业务类型
	public static final String BPT_DISABILITY_ASSESS = "11";
	public static final String BPT_DISABILITY_ASSESS_NA = "伤残人员评残";
	
	public static final String BPT_DISABILITY_ADJUST = "12";
	public static final String BPT_DISABILITY_ADJUST_NA = "伤残人员调残";
	
	public static final String BPT_DISABILITY_EXCHANGECERTIFICATE = "13";
	public static final String BPT_DISABILITY_EXCHANGECERTIFICATE_NA = "伤残人员换证补证及证件变更";
	
	public static final String BPT_DISABILITY_VETERANSSHIFT  = "14";
	public static final String BPT_DISABILITY_VETERANSSHIFT_NA = "退役军人伤残抚恤关系迁入";
	
	public static final String BPT_DISABILITY_INGOINGPROVINCE = "15";
	public static final String BPT_DISABILITY_INGOINGPROVINCE_NA = "外省伤残人员抚恤关系迁入";
	
	public static final String BPT_DISABILITY_PROVINCEMIGRATION = "16";
	public static final String BPT_DISABILITY_PROVINCEMIGRATION_NA = "伤残人员省内迁移	";
	
	public static final String BPT_DISABILITY_ASSISTIVEDEVICES = "17";
	public static final String BPT_DISABILITY_ASSISTIVEDEVICES_NA = "伤残人员配置伤残辅助器械";
	public static final String ASSISTIVEDEVICES_PROCDEFUNIQUEID = "8a898bd734120bed01341226efec0008";
	
	public static final String BPT_DISABILITY_CHANGECERTIFICATE = "18";
	public static final String BPT_DISABILITY_CHANGECERTIFICATE_NA = "伤残人员证件变更";
	
	public static final String BPT_DISABILITY_EMIGRATION= "19";
	public static final String BPT_DISABILITY_EMIGRATION_NA = "伤残人员抚恤关系跨省迁出";
	
	//三属业务类型
	public static final String BPT_DEPENDANT_PENSION = "21";
	public static final String BPT_DEPENDANT_PENSION_NA = "三属定期抚恤申请审批";
	
	public static final String BPT_DEPENDANT_INGOINGPROVINCE = "22";
	public static final String BPT_DEPENDANT_INGOINGPROVINCE_NA = "三属抚恤定补关系跨省迁入";
	
	public static final String BPT_DEPENDANT_PROVINCEMIGRATION = "23";
	public static final String BPT_DEPENDANT_PROVINCEMIGRATION_NA = "三属抚恤定补关系省内迁移";
	
	public static final String BPT_DEPENDANT_EXCHANGECERTIFICATE = "24";
	public static final String BPT_DEPENDANT_EXCHANGECERTIFICATE_NA = "三属定期抚恤关系换证补证";
	
	public static final String BPT_DEPENDANT_EMIGRATION = "25";
	public static final String BPT_DEPENDANT_EMIGRATION_NA = "三属抚恤定补关系跨省迁出";
	
	//在乡复员军人业务类型
	public static final String BPT_DEMOBILIZED_IDENTIFIED = "41";
	public static final String BPT_DEMOBILIZED_IDENTIFIED_NA = "在乡复员军人身份认定及定期定量生活补助审批";
	
	public static final String BPT_DEMOBILIZED_INGOINGPROVINCE = "42";
	public static final String BPT_DEMOBILIZED_INGOINGPROVINCE_NA = "在乡复员军人定补关系跨省迁入";
	
	public static final String BPT_DEMOBILIZED_PROVINCEMIGRATION = "43";
	public static final String BPT_DEMOBILIZED_PROVINCEMIGRATION_NA = "在乡复员军人定补关系省内迁移";
	
	public static final String BPT_DEMOBILIZED_EXCHANGECERTIFICATE = "44";
	public static final String BPT_DEMOBILIZED_EXCHANGECERTIFICATE_NA = "在乡复员军人换证补证";
	
	public static final String BPT_DEMOBILIZED_EMIGRATION = "4A";
	public static final String BPT_DEMOBILIZED_EMIGRATION_NA = "在乡复员军人定补关系跨省迁出";
	
	//带病回乡退伍军人业务类型
	public static final String BPT_DEMOBILIZEDILLNESS_IDENTIFIED = "45";
	public static final String BPT_DEMOBILIZEDILLNESS_IDENTIFIED_NA = "带病回乡退伍军人身份认定及生活补助审批";
	
	public static final String BPT_DEMOBILIZEDILLNESS_INGOINGPROVINCE = "46";
	public static final String BPT_DEMOBILIZEDILLNESS_INGOINGPROVINCE_NA = "带病回乡退伍军人定补关系跨省迁入";
	
	public static final String BPT_DEMOBILIZEDILLNESS_PROVINCEMIGRATION = "47";
	public static final String BPT_DEMOBILIZEDILLNESS_PROVINCEMIGRATION_NA = "带病回乡退伍军人定补关系省内迁移";
	
	public static final String BPT_DEMOBILIZEDILLNESS_EXCHANGECERTIFICATE = "48";
	public static final String BPT_DEMOBILIZEDILLNESS_EXCHANGECERTIFICATE_NA = "带病回乡退伍军人换证补证";
	
	public static final String BPT_DEMOBILIZEDILLNESS_EMIGRATION = "4B";
	public static final String BPT_DEMOBILIZEDILLNESS_EMIGRATION_NA = "带病回乡退伍军人定补关系跨省迁出";
	
	//参战人员业务类型
	public static final String BPT_WAR_IDENTIFIED = "51";
	public static final String BPT_WAR_IDENTIFIED_NA = "参战人员身份认定及生活补助申请审批";
	
	public static final String BPT_WAR_INGOINGPROVINCE = "52";
	public static final String BPT_WAR_INGOINGPROVINCE_NA = "参战人员定补关系跨省迁入";
	
	public static final String BPT_WAR_PROVINCEMIGRATION = "53";
	public static final String BPT_WAR_PROVINCEMIGRATION_NA = "参战人员定补关系省内迁移";
	
	public static final String BPT_WAR_EXCHANGECERTIFICATE = "54";
	public static final String BPT_WAR_EXCHANGECERTIFICATE_NA = "参战人员换证补证";
	
	public static final String BPT_WAR_EMIGRATION = "55";
	public static final String BPT_WAR_EMIGRATION_NA = "参战人员定补关系跨省迁出";
	
	//参试人人员业务员类型
	public static final String BPT_TESTED_IDENTIFIED = "61";
	public static final String BPT_TESTED_IDENTIFIED_NA = "参试人人员身份认定及生活补助申请审批";
	
	public static final String BPT_TESTED_INGOINGPROVINCE = "62";
	public static final String BPT_TESTED_INGOINGPROVINCE_NA = "参试人员定补关系跨省迁入";
	
	public static final String BPT_TESTED_PROVINCEMIGRATION = "63";
	public static final String BPT_TESTED_PROVINCEMIGRATION_NA = "参试人员定补关系省内迁移";
	
	public static final String BPT_TESTED_EXCHANGECERTIFICATE = "64";
	public static final String BPT_TESTED_EXCHANGECERTIFICATE_NA = "参试人员换证补证";
	
	public static final String BPT_TESTED_EMIGRATION = "65";
	public static final String BPT_TESTED_EMIGRATION_NA = "参试人员定补关系跨省迁出";
	
	}
