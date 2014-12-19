package com.inspur.cams.fis.util;

import java.util.HashMap;
import java.util.Map;

import org.loushang.bsp.id.util.MaxValueUtil;
import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;

import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.fis.base.dao.IFisCemeteryOrganDao;
import com.inspur.cams.fis.base.dao.IFisFuneralOrganDao;
import com.inspur.cams.fis.base.dao.IFisGlobalConfigDao;
import com.inspur.cams.fis.base.data.FisCemeteryOrgan;
import com.inspur.cams.fis.base.data.FisFuneralOrgan;
import com.inspur.cams.fis.base.data.FisGlobalConfig;

/**
 * @Path com.inspur.cams.fis.util.FisIdHelp  
 * @Description: TODO 生成殡葬系统中需要的各类Id
 * @author luguosui,xuexzh
 * @date 2011-11-22
 */
public class FisIdHelp {
	
	static {
		getFisDefaultOrganFlag();
		getFhOrganCode();
		getCemeOrganCode();
		getFissOrganCode();
	}
	
	private static FisFuneralOrgan fisFunOrgan;				//殡仪馆信息
	
	private static FisCemeteryOrgan fisCemeOrgan;			//公墓信息
	
	private static Map<String,String> fisFissOrgan;			//服务机构编号
	
	private static String fisDefaultOrganFlag="F";	//默认机构编号(F-殡仪馆，C-公墓，S-服务机构)
	
	/*******************************************************
	 * 						单位类型
	 *******************************************************/
	//殡仪服务单位-殡仪馆
	public final static String FIS_ORGAN_FH = "BZ";
	//殡仪服务单位-公墓
	public final static String FIS_ORGAN_CEME = "GZ";
	//殡仪服务单位-殡仪服务站
	public final static String FIS_ORGAN_FISS = "YZ";
	//默认殡仪服务单位
	public final static String FIS_ORGAN_DEFAULT = "DEF";
	/*******************************************************
	 */
	
	
	/*******************************************************
	 * 						通用ID
	 *******************************************************/
	//通用ID前缀
	public final static String FIS_SERVICE_RELATED = "S";	//（服务项目、服务包）
	public final static String FIS_CUSTOMER_RELATED = "P";	//客户
	public final static String FIS_RESOURCE_RELATED = "R";	//（人、设备设施（资源）、用品、墓碑、印字费）
	public final static String FIS_RECORD_RELATED = "L";	//（业务各种服务记录、服务使用人员/用品/资源记录、用品采购记录、资源规格记录、资源规则记录）
	public final static String FIS_CHARGE_RELATED = "C";	//（收费、减免）
	public final static String FIS_EMPLOY_RELATED = "E";	//（业务使用服务/用品情况、图片）
	/*******************************************************
	 */
	
	
	/*******************************************************
	 * 						证件标识
	 *******************************************************/
	public final static String FIS_DEAD_PREFIX = "SZ";		//逝者前缀
	
	public final static String FIS_FUNERAL_CONTRACT_PREFIX = "FZ";				//殡仪服务合同前缀
	public final static String FIS_FUNERAL_TAKEASHES_PREFIX = "LZ";				//领灰证明前缀
	public final static String FIS_FUNERAL_TAKEASHES_REISSUE_PREFIX = "BLZ";	//领灰证明（补）前缀
	public final static String FIS_FUNERAL_CREMATION_PREFIX = "HZ";				//火化证明前缀
	public final static String FIS_FUNERAL_CREMATION_REISSUE_PREFIX = "BHZ";	//火化证明（补）前缀
	
	public final static String FIS_EMPLACING_CONTRACT_PREFIX = "JZ";				//骨灰寄存协议前缀
//	public final static String FIS_EMPLACING_CERT_PUBLIC_PREFIX = "GJZ";			//(公益性骨灰寄存机构)骨灰寄存证前缀
//	public final static String FIS_EMPLACING_CERT_REISSUE_PUBLIC_PREFIX = "BGJZ";	//(公益性骨灰寄存机构)骨灰寄存证（补）前缀
	public final static String FIS_EMPLACING_CERT_GESTION_PREFIX = "JJZ";			//(经营性骨灰寄存机构)骨灰寄存证前缀
	public final static String FIS_EMPLACING_CERT_REISSUE_GESTION_PREFIX = "BJJZ";	//(经营性骨灰寄存机构)骨灰寄存证（补）前缀
	
	public final static String FIS_CEMETERY_CONTRACT_PREFIX = "GZ";					//墓穴使用协议前缀
//	public final static String FIS_CEMETERY_CERT_PUBLIC_PREFIX = "GAZ";				//公益性公墓安葬证前缀
//	public final static String FIS_CEMETERY_CERT_REISSUE_PUBLIC_PREFIX = "BGAZ";	//公益性公墓安葬证（补）前缀
	public final static String FIS_CEMETERY_CERT_GESTION_PREFIX = "JAZ";			//经营性公墓安葬证前缀
//	public final static String FIS_CEMETERY_CERT_REISSUE_GESTION_PREFIX = "BJAZ";	//经营性公墓安葬证（补）前缀
	public final static String FIS_CEMETERY_RESERVES_PREFIX = "LMZ";				//留墓单
//	public final static String FIS_CEMETERY_RESERVES_REISSUE_PREFIX = "BLMZ";		//留墓单（补）
	public final static String FIS_CEMETERY_SCHEDULED_PREFIX = "DMZ";				//定墓单
//	public final static String FIS_CEMETERY_SCHEDULED_REISSUE_PREFIX = "BDMZ";		//定墓单（补）
	
	public final static String FIS_SCHEDULED_CUSTOMER_VISIT_CLEAN_PREFIX = "DZ";	//代客祭扫服务协议书
	/*******************************************************
	 */
	
	
	/*******************************************************
	 * 						人员标识
	 *******************************************************/
	public final static String FIS_FH_PEOPLE_PREFIX = "BRZ";	//殡仪服务单位人员-殡仪馆工作人员前缀
	public final static String FIS_CEME_PEOPLE_PREFIX = "GRZ";	//殡仪服务单位人员-公墓工作人员前缀
	public final static String FIS_FISS_PEOPLE_PREFIX = "YRZ";	//殡仪服务单位人员-殡仪服务站工作人员前缀
	/*******************************************************
	 */
	

	/*******************************************************
	 * 						公有方法
	 *******************************************************/
	//获取证件主键编码
	public static String getFisCertId(String fisFlag, String organFlag) {
		if(fisFlag.equals(FIS_DEAD_PREFIX))	{
			//获取逝者编码
			return getFisCode(FIS_DEAD_PREFIX, "FIS_DEAD", organFlag);
		}else if(fisFlag.equals(FIS_FUNERAL_CONTRACT_PREFIX))	{
			//获取殡仪服务合同编码
			return getFisCode(FIS_FUNERAL_CONTRACT_PREFIX, "FIS_FUNERAL_CONTRACT", organFlag);
		}else if(fisFlag.equals(FIS_FUNERAL_TAKEASHES_PREFIX)) {
			//获取殡仪领灰证明编码
			return getFisCode(FIS_FUNERAL_TAKEASHES_PREFIX, "FIS_FUNERAL_TAKEASHES", organFlag);
		}else if(fisFlag.equals(FIS_FUNERAL_TAKEASHES_REISSUE_PREFIX)) {
			//获取殡仪领灰证明（补）编码
			return getFisCode(FIS_FUNERAL_TAKEASHES_REISSUE_PREFIX, "FIS_FUNERAL_TAKEASHES", organFlag);
		}else if(fisFlag.equals(FIS_FUNERAL_CREMATION_PREFIX)) {
			//获取殡仪火化证明编码
			return getFisCode(FIS_FUNERAL_CREMATION_PREFIX, "FIS_FUNERAL_CREMATION", organFlag);
		}else if(fisFlag.equals(FIS_FUNERAL_CREMATION_REISSUE_PREFIX)) {
			//获取殡仪火化证明（补）编码
			return getFisCode(FIS_FUNERAL_CREMATION_REISSUE_PREFIX, "FIS_FUNERAL_CREMATION", organFlag);
		}else if(fisFlag.equals(FIS_EMPLACING_CONTRACT_PREFIX)) {
			//获取骨灰寄存协议编码
			return getFisCode(FIS_EMPLACING_CONTRACT_PREFIX, "FIS_EMPLACING_CONTRACT", organFlag);
		}else if(fisFlag.equals(FIS_EMPLACING_CERT_GESTION_PREFIX)) {
			//获取(经营性骨灰寄存机构)骨灰寄存证编码
			return getFisCode(FIS_EMPLACING_CERT_GESTION_PREFIX, "FIS_EMPLACING_CERT", organFlag);
		}else if(fisFlag.equals(FIS_EMPLACING_CERT_REISSUE_GESTION_PREFIX)) {
			//获取(经营性骨灰寄存机构)骨灰寄存证编码-补
			return getFisCode(FIS_EMPLACING_CERT_REISSUE_GESTION_PREFIX, "FIS_EMPLACING_CERT", organFlag);
		}else if(fisFlag.equals(FIS_CEMETERY_CONTRACT_PREFIX)) {
			//获取墓穴使用协议编码
			return getFisCode(FIS_CEMETERY_CONTRACT_PREFIX, "FIS_CEMETERY_CONTRACT", organFlag);
		}else if(fisFlag.equals(FIS_CEMETERY_CERT_GESTION_PREFIX)) {
			//获取经营性公墓安葬证编码
			return getFisCode(FIS_CEMETERY_CERT_GESTION_PREFIX, "FIS_CEMETERY_CERT", organFlag);
		}
		
		return "主键生成错误(外层)...........................................";
	}

	//通用ID前缀
	public static String getFisCommonId(String fisFlag, String organFlag) {
		if(fisFlag.equals(FIS_SERVICE_RELATED)) {
			//获取服务编码（服务项目、服务包）
			return getFisCommonCode(FIS_SERVICE_RELATED, organFlag);
		}else if(fisFlag.equals(FIS_CUSTOMER_RELATED)) {
			//获取客户编码
			return getFisCommonCode(FIS_CUSTOMER_RELATED, organFlag);
		}else if(fisFlag.equals(FIS_RESOURCE_RELATED)) {
			//获取资源编码（人、设备设施（资源）、用品、墓碑、印字费）
			return getFisCommonCode(FIS_RESOURCE_RELATED, organFlag);
		}else if(fisFlag.equals(FIS_RECORD_RELATED)) {
			//获取记录编码（业务各种服务记录、服务使用人员/用品/资源记录、用品采购记录、资源规格记录、资源规则记录）
			return getFisCommonCode(FIS_RECORD_RELATED, organFlag);
		}else if(fisFlag.equals(FIS_CHARGE_RELATED)) {
			//获取收费编码（收费、减免）
			return getFisCommonCode(FIS_CHARGE_RELATED, organFlag);
		}else if(fisFlag.equals(FIS_EMPLOY_RELATED)) {
			//获取用品/服务使用情况编码（业务使用服务/用品情况、图片）
			return getFisCommonCode(FIS_EMPLOY_RELATED, organFlag);
		}
		
		return "通用主键生成错误(外层)...........................................";
	}
	
	//根据不同单位性质获取工作人员编码
	public static String getFisPeopleId(String organFlag) {
		if(organFlag.equals(FIS_ORGAN_FH)) 
			return getFisCode(FIS_FH_PEOPLE_PREFIX, "FIS_FUNERAL_PEOPLE", organFlag);
		else if(organFlag.equals(FIS_ORGAN_CEME)) 
			return getFisCode(FIS_CEME_PEOPLE_PREFIX, "FIS_FUNERAL_PEOPLE", organFlag);
		else if(organFlag.equals(FIS_ORGAN_FISS)) 
			return getFisCode(FIS_FISS_PEOPLE_PREFIX, "FIS_FUNERAL_PEOPLE", organFlag);
		else if(organFlag.equals(FIS_ORGAN_DEFAULT)) {
			if("F".equals(fisDefaultOrganFlag))
				return getFisCode(FIS_FH_PEOPLE_PREFIX, "FIS_FUNERAL_PEOPLE", organFlag);
			else if("C".equals(fisDefaultOrganFlag))
				return getFisCode(FIS_CEME_PEOPLE_PREFIX, "FIS_FUNERAL_PEOPLE", organFlag);
			else if("S".equals(fisDefaultOrganFlag))
				return getFisCode(FIS_FISS_PEOPLE_PREFIX, "FIS_FUNERAL_PEOPLE", organFlag);
			else
				return "人员主键生成错误(内层)...........................................";	
		}
		
		return "人员主键生成错误(外层)...........................................";
	}
	
	//获取指定类型单位编号
	public static String getFisOrganCode(String organFlag) {
		if(organFlag.equals(FIS_ORGAN_FH)) 
			return fisFunOrgan.getOrganId();
		else if(organFlag.equals(FIS_ORGAN_CEME)) 
			return fisCemeOrgan.getOrganId();
		else if(organFlag.equals(FIS_ORGAN_FISS)) 
			return fisFissOrgan.get("organId");
		else if(organFlag.equals(FIS_ORGAN_DEFAULT)) {
			if("F".equals(fisDefaultOrganFlag))
				return fisFunOrgan.getOrganId();
			else if("C".equals(fisDefaultOrganFlag))
				return fisCemeOrgan.getOrganId();
			else if("S".equals(fisDefaultOrganFlag))
				return fisFissOrgan.get("organId");
			else
				return "获取指定类型单位编号(内层)...........................................";	
		}else
			return "获取指定类型单位编号(外层)...........................................";
	}
	
	//获取指定类型单位名称
	public static String getFisOrganName(String organFlag) {
		if(organFlag.equals(FIS_ORGAN_FH)) 
			return fisFunOrgan.getName();
		else if(organFlag.equals(FIS_ORGAN_CEME)) 
			return fisCemeOrgan.getName();
		else if(organFlag.equals(FIS_ORGAN_FISS)) 
			return fisFissOrgan.get("name");
		else if(organFlag.equals(FIS_ORGAN_DEFAULT)) {
			if("F".equals(fisDefaultOrganFlag))
				return fisFunOrgan.getName();
			else if("C".equals(fisDefaultOrganFlag))
				return fisCemeOrgan.getName();
			else if("S".equals(fisDefaultOrganFlag))
				return fisFissOrgan.get("name");
			else
				return "获取指定类型单位名称(内层)...........................................";	
		}else
			return "获取指定类型单位名称(外层)...........................................";
	}
	
	
	/*******************************************************
	 * 						私有方法
	 *******************************************************/
	//指定类型单位所属行政区划
	private static String getFisShortOrganCode(String organFlag) {
		if(organFlag.equals(FIS_ORGAN_FH)) 
			return fisFunOrgan.getOrganId().substring(2, 8);
		else if(organFlag.equals(FIS_ORGAN_CEME)) 
			return fisCemeOrgan.getOrganId().substring(2, 8);
		else if(organFlag.equals(FIS_ORGAN_FISS)) 
			return fisFissOrgan.get("organId").substring(2, 8);
		else if(organFlag.equals(FIS_ORGAN_DEFAULT)) {
			if("F".equals(fisDefaultOrganFlag))
				return fisFunOrgan.getOrganId().substring(2, 8);
			else if("C".equals(fisDefaultOrganFlag))
				return fisCemeOrgan.getOrganId().substring(2, 8);
			else if("S".equals(fisDefaultOrganFlag))
				return fisFissOrgan.get("organId").substring(2, 8);
			else
				return "主键生成错误(内层)...........................................";	
		}else
			return "主键生成错误(外层)...........................................";
	}
	
	//指定类型单位本区划内序号
	private static String getFisNumOrganCode(String organFlag) {
		if(organFlag.equals(FIS_ORGAN_FH)) 
			return fisFunOrgan.getOrganId().substring(10);
		else if(organFlag.equals(FIS_ORGAN_CEME)) 
			return fisCemeOrgan.getOrganId().substring(10);
		else if(organFlag.equals(FIS_ORGAN_FISS)) 
			return fisFissOrgan.get("organId").substring(10);
		else if(organFlag.equals(FIS_ORGAN_DEFAULT)) {
			if("F".equals(fisDefaultOrganFlag))
				return fisFunOrgan.getOrganId().substring(10);
			else if("C".equals(fisDefaultOrganFlag))
				return fisCemeOrgan.getOrganId().substring(10);
			else if("S".equals(fisDefaultOrganFlag))
				return fisFissOrgan.get("organId").substring(10);
			else
				return "主键生成错误(内层)...........................................";	
		}else
			return "主键生成错误(外层)...........................................";
	}
	
	/**
	 * @Description: TODO 获取通用编号
	 */
	private static String getFisCommonCode(String fisType, String organFlag) {
		String year = DateUtil.getYear();
		String maxCode = MaxValueUtil.nextStringValue("FIS_COMM_CODE");
		return fisType + "-" +getFisShortOrganCode(organFlag) + "-" +year + "-" + getFisNumOrganCode(organFlag) + maxCode;
	}
	
	/**
	 * @Description: TODO 按规则组装编号
	 */
	private static String getFisCode(String fisType, String maxTableFlag, String organFlag) {
		String year = DateUtil.getYear();
		String maxCode = MaxValueUtil.nextStringValue(maxTableFlag);
		return fisType + "-" + getFisShortOrganCode(organFlag) + "-" + year + "-" + getFisNumOrganCode(organFlag) + maxCode;
	}
	
	/***
	 * 从数据库中获取默认单位标识，如殡仪馆、公墓、服务机构
	 */
	// 获取默认单位标识
	private static void getFisDefaultOrganFlag() {
		IFisGlobalConfigDao dao = (IFisGlobalConfigDao) DaoFactory
				.getDao("com.inspur.cams.fis.base.dao.jdbc.FisGlobalConfigDao");
		ParameterSet pset = new ParameterSet();
		DataSet ds = dao.query(pset);
		if (ds.getCount() > 0) {
			fisDefaultOrganFlag = ((FisGlobalConfig) ds.getRecord(0).toBean(FisGlobalConfig.class)).getDefaultOrganFlag();
		}
	}
	
	/***
	 * 从数据库中获取当前单位编号信息，如殡仪馆、公墓、服务机构
	 */
	// 获取殡仪馆单位编号
	private static void getFhOrganCode() {
		IFisFuneralOrganDao dao = (IFisFuneralOrganDao) DaoFactory
				.getDao("com.inspur.cams.fis.base.dao.jdbc.FisFuneralOrganDao");
		ParameterSet pset = new ParameterSet();
		DataSet ds = dao.query(pset);
		if (ds.getCount() > 0) {
			fisFunOrgan = (FisFuneralOrgan) ds.getRecord(0).toBean(FisFuneralOrgan.class);
		}else {
			fisFunOrgan = new FisFuneralOrgan();
		}
	}

	// 获取公墓单位编号
	private static void getCemeOrganCode() {
		IFisCemeteryOrganDao dao = (IFisCemeteryOrganDao) DaoFactory
				.getDao("com.inspur.cams.fis.base.dao.jdbc.FisCemeteryOrganDao");
		ParameterSet pset = new ParameterSet();
		DataSet ds = dao.query(pset);
		if (ds.getCount() > 0) {
			fisCemeOrgan = (FisCemeteryOrgan) ds.getRecord(0).toBean(FisCemeteryOrgan.class);
		}else {
			fisCemeOrgan = new FisCemeteryOrgan();
		}
	}
	
	//获取服务机构单位编号
	private static void getFissOrganCode(){
		fisFissOrgan = new HashMap();
//		fisFissOrgan.put("organId", "SS999999-99");
//		fisFissOrgan.put("name", "服务机构");
	}
}