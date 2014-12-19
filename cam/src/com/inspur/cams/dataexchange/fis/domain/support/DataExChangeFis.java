package com.inspur.cams.dataexchange.fis.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.sca.ScaComponentFactory;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.extuser.data.ComExtUser;
import com.inspur.cams.comm.extuser.domain.IComExtUserDomain;
import com.inspur.cams.dataexchange.fis.domain.IDataExChangeFis;
import com.inspur.cams.dataexchange.log.DataExChangeLog;
import com.inspur.cams.dataexchange.log.IDataExChangeLogDao;
import com.inspur.cams.dataexchange.util.DataExChangeError;
import com.inspur.cams.dataexchange.util.IDataExChangeLoginHandle;
import com.inspur.cams.fis.base.domain.IFisCremationInfoSumDomain;

/**
 * 数据共享殡葬系统接口
 * 
 * @author YLL
 * @since 2013年5月22日
 */
public class DataExChangeFis implements IDataExChangeFis {
	
	private IFisCremationInfoSumDomain fisCremationInfoSumDomain = ScaComponentFactory
			.getService(IFisCremationInfoSumDomain.class,
					"fisCremationInfoSumDomain/fisCremationInfoSumDomain");
	@Reference
	private IDataExChangeLoginHandle dataExChangeLoginHandle;
	@Reference
	private IDataExChangeLogDao dataExChangeLogDao;
	
	private IComExtUserDomain comExtUserDomain = (IComExtUserDomain) ScaComponentFactory.getService(IComExtUserDomain.class, "comExtUserDomain/comExtUserDomain");
	
	/**
	 * @param userId 帐号
	 * @param passWord 密码
	 * @param IdCard  逝者证件号码
	 * @return 殡葬火化信息
	 */
	public String getFuneralInfo(String userId , String passWord ,String IdCard) {
		StringBuffer returnXML = new StringBuffer("");
		returnXML.append("<?xml version='1.0' encoding='UTF-8'?>");
		returnXML.append("<FUNERAL_RETRUNS>");
		// 首先判断用户权限
		String loginString = dataExChangeLoginHandle.login(userId, passWord);
		if(!"".equals(loginString)){//登录失败
			returnXML.append(loginString);
		}else {//登录成功
			DataSet ds = queryFuneral( IdCard );
			if( ds.getCount() > 0 ){
				//获得一条记录
				Record record =  ds.getRecord(0);
				fillInfo(returnXML,record);//写入一条
				
				//记录到日志表中
				DataExChangeLog dataLog = new DataExChangeLog();
				dataLog.setFisIdCard(IdCard);
				dataLog.setQueryResultCount("1");//查询结果数
				dataLog.setBusinessCategory("902");//业务类别
				dataLog.setQueryMode("S");//查询方式
				ComExtUser comExtUser = comExtUserDomain.getComExtUser(userId.trim());
				
				dataExChangeLogDao.insertLog(dataLog , comExtUser);
			}else{
				DataExChangeLog dataLog = new DataExChangeLog();
				dataLog.setFisIdCard(IdCard);
				dataLog.setQueryResultCount("0");//查询结果数
				dataLog.setBusinessCategory("902");//业务类别
				dataLog.setQueryMode("S");//查询方式
				ComExtUser comExtUser = comExtUserDomain.getComExtUser(userId.trim());
				dataExChangeLogDao.insertLog(dataLog , comExtUser);
				
				returnXML.append("<ERROR>"+DataExChangeError.DATA_NOT_FOUND+"</ERROR>");
			}
		}
		returnXML.append("</FUNERAL_RETRUNS>");
		
		return returnXML.toString();
	}
	/**
	 * 殡葬信息写入XML
	 * @param returnXML
	 * @param record
	 */
	private void fillInfo(StringBuffer returnXML, Record record) {
		returnXML.append("<FUNERAL_RETRUN>");
		
		returnXML.append("<NAME>"+ ((String)record.get("NAME")).trim()+"</NAME><!--姓名-->");
		returnXML.append("<SEX>"+ ((String)record.get("SEX")).trim()+"</SEX><!--性别-->");
		returnXML.append("<CARD_TYPE>"+ ((String)record.get("CARD_TYPE")).trim()+"</CARD_TYPE><!--身份证件类型-->");
		returnXML.append("<ID_CARD>"+ ((String)record.get("ID_CARD")).trim()+"</ID_CARD><!--身份证件号码-->");
		returnXML.append("<NATION>"+ ((String)record.get("FOLK")).trim()+"</NATION><!--民族-->");
		returnXML.append("<FAMILY_ADD>"+ ((String)record.get("FAMILY_ADD")).trim()+"</FAMILY_ADD><!--原家庭住址-->");
		returnXML.append("<CREMATION_TIME>"+ ((String)record.get("START_TIME")).trim()+"</CREMATION_TIME><!--火化时间-->");
		returnXML.append("<CREATE_ORGAN_NAME>"+ ((String)record.get("CREATE_ORGAN_NAME")).trim()+"</CREATE_ORGAN_NAME><!--殡仪馆名称-->");
		returnXML.append("<CREATE_ORGAN_CODE>"+ ((String)record.get("CREATE_ORGAN")).trim()+"</CREATE_ORGAN_CODE><!--殡仪馆代码-->");
		
		returnXML.append("</FUNERAL_RETRUN>");
	}
	/**
	 * 查询殡葬信息
	 * @param idCard 证件号码
	 * @return
	 */
	private DataSet queryFuneral(String idCard) {
		ParameterSet pset =new ParameterSet();
		pset.setParameter("idCard",idCard);
		pset.setParameter("ifFinish", "1");
		pset.setParameter(pset.PARAM_LIMIT, 10);
		pset.setParameter(pset.PARAM_START, 0);
		return fisCremationInfoSumDomain.queyDeadInfo(pset);
	}

}
