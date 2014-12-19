package com.inspur.cams.dataexchange.marry.domain.support;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import javax.servlet.http.HttpServletRequest;
import org.apache.axis.MessageContext;
import org.apache.axis.transport.http.HTTPConstants;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.ScaComponentFactory;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.extuser.data.ComExtUser;
import com.inspur.cams.comm.extuser.domain.IComExtUserDomain;
import com.inspur.cams.dataexchange.log.DataExChangeLog;
import com.inspur.cams.dataexchange.log.IDataExChangeLogDao;
import com.inspur.cams.dataexchange.marry.domain.IDataExChangeMarry;
import com.inspur.cams.dataexchange.util.DataExChangeError;
import com.inspur.cams.dataexchange.util.DataExChangeLoginHandle;
import com.inspur.cams.dataexchange.util.IDataExChangeLoginHandle;
import com.inspur.cams.marry.reg.data.Marryreg;
import com.inspur.cams.marry.reg.domain.IMarryregDomain;
/**
 * 数据共享婚姻系统具体实现
 * @author YLL
 * @since 2013年5月22日
 */
public class DataExChangeMarry implements IDataExChangeMarry{
	@Reference
	private IMarryregDomain marryregDomain;
	@Reference
	private IDataExChangeLoginHandle dataExChangeLoginHandle;
	
	@Reference
	private IDataExChangeLogDao dataExChangeLogDao;
	
	private IComExtUserDomain comExtUserDomain = (IComExtUserDomain) ScaComponentFactory.getService(IComExtUserDomain.class, "comExtUserDomain/comExtUserDomain");
	
	/**
	 * @param userId 帐号
	 * @param passWord 密码
	 * @param CertNumMan 男性证件号码
	 * @param CertNumWoman 女性证件号码
	 * @return 男方或女方当事人最后一条婚姻信息记录
	 */
	public String getMarryLastInfoByCert(String userId , String passWord ,String CertNumMan, String CertNumWoman) {
		StringBuffer returnXML = new StringBuffer("");
		returnXML.append("<?xml version='1.0' encoding='UTF-8'?>");
		returnXML.append("<MARRY_RETRUNS>");
		// 首先判断用户权限
		String loginString = dataExChangeLoginHandle.login(userId, passWord);
		if(!"".equals(loginString)){//登录失败
			returnXML.append(loginString);
		}else {//登录成功
			DataSet ds = queryMarry(CertNumMan , CertNumWoman);
			Marryreg marryInfo = new Marryreg();
			if( ds.getCount() > 0 ){
				//获得最新的一条记录
				marryInfo = (Marryreg)ds.getRecord(0).toBean(Marryreg.class);
				for(int i=0;i<ds.getCount();i++){
					Marryreg marry =(Marryreg)ds.getRecord(i).toBean(Marryreg.class);
					if(marryInfo.getOpDate().getTime() <  marry.getOpDate().getTime()){
						marryInfo = marry;
					}
				}
				//获得最新的一条记录结束
				if(marryInfo.getId() != null &&  !"".equals(marryInfo.getId().toString().trim()) ){
					fillInfo(returnXML,marryInfo);//写入一条
					// 记录到日志表中
					DataExChangeLog dataLog = new DataExChangeLog();
					dataLog.setCertMan(CertNumMan);
					dataLog.setCertWoman(CertNumWoman);
					dataLog.setQueryResultCount("1");//查询结果数
					dataLog.setBusinessCategory("901");//业务类别
					dataLog.setQueryMode("S");//查询方式
					ComExtUser comExtUser = comExtUserDomain.getComExtUser(userId.trim());
					
					dataExChangeLogDao.insertLog(dataLog , comExtUser);
					
				}else{//如果数据出现错误
					returnXML.append("<ERROR>"+DataExChangeError.DATA_ERROR+"</ERROR>");
				}
			}else{
				DataExChangeLog dataLog = new DataExChangeLog();
				dataLog.setCertMan(CertNumMan);
				dataLog.setCertWoman(CertNumWoman);
				dataLog.setQueryResultCount("0");//查询结果数
				dataLog.setBusinessCategory("901");//业务类别
				dataLog.setQueryMode("S");//查询方式
				ComExtUser comExtUser = comExtUserDomain.getComExtUser(userId.trim());
				dataExChangeLogDao.insertLog(dataLog , comExtUser);
				
				returnXML.append("<ERROR>"+DataExChangeError.DATA_NOT_FOUND+"</ERROR>");
			}
		}
		returnXML.append("</MARRY_RETRUNS>");
		
		return returnXML.toString();
	}
	/**
	 * @param userId 帐号
	 * @param passWord 密码
	 * @param CertNumMan 男性证件号码
	 * @param CertNumWoman 女性证件号码
	 * @return 男方或女方当事人有关婚姻信息记录
	 */
	public String getMarryAllInfoByCert(String userId , String passWord ,String CertNumMan, String CertNumWoman) {
		StringBuffer returnXML = new StringBuffer("");
		returnXML.append("<?xml version='1.0' encoding='UTF-8'?>");
		returnXML.append("<MARRY_RETRUNS>");
		
		// TODO 首先判断用户权限
		String loginString = dataExChangeLoginHandle.login(userId, passWord);
		if(!"".equals(loginString)){//登录失败
			returnXML.append(loginString);
		}else {//登录成功
			DataSet ds = queryMarry(CertNumMan , CertNumWoman);
			if( ds.getCount() > 0 ){
				for(int i=0;i<ds.getCount();i++){
					Marryreg marryInfo =(Marryreg)ds.getRecord(i).toBean(Marryreg.class);
					fillInfo(returnXML,marryInfo);//写入一条
				}
			}else{
				returnXML.append("<ERROR>"+DataExChangeError.DATA_NOT_FOUND+"</ERROR>");
			}
			// 记录到日志表中
			DataExChangeLog dataLog = new DataExChangeLog();
			dataLog.setCertMan(CertNumMan);
			dataLog.setCertWoman(CertNumWoman);
			dataLog.setQueryResultCount((ds.getCount()+"").trim());//查询结果数
			dataLog.setBusinessCategory("901");//业务类别
			dataLog.setQueryMode("S");//查询方式
			ComExtUser comExtUser = comExtUserDomain.getComExtUser(userId.trim());
			
			dataExChangeLogDao.insertLog(dataLog , comExtUser);
		}
		
		returnXML.append("</MARRY_RETRUNS>");
		
		return returnXML.toString();
	}
/**
 * ################################################   私有方法   #########################################################################
 */
	/**
	 * 查询婚姻的信息
	 * @param certNumMan 男性证件号码
	 * @param certNumWoman 女性证件号码
	 * @return DataSet
	 */
	private DataSet queryMarry(String certNumMan, String certNumWoman) {
		ParameterSet pset =new ParameterSet();
		pset.setParameter("CERT_NUM_MAN@=", certNumMan.trim());
		pset.setParameter("CERT_NUM_WOMAN@=", certNumWoman.trim());
		
		DataSet ds = marryregDomain.query(pset);
		return ds;
	}
	/**
	 * 生成一条xml的婚姻信息
	 * @param sb 字符串
	 * @param marryInfo 婚姻数据bean
	 */
	private void fillInfo(StringBuffer sb, Marryreg marryInfo) {
		sb.append("<MARRY_RETRUN>");
		sb.append("<NAME_MAN>"+ marryInfo.getNameMan().trim()+"</NAME_MAN><!—男性姓名-->");
		sb.append("<NAME_WOMAN>"+ marryInfo.getNameWoman().trim()+"</NAME_WOMAN><!—女性姓名-->");
		
		sb.append("<CERT_TYPE_MAN>"+ marryInfo.getIdTypeMan().trim()+"</CERT_TYPE_MAN ><!—男性证件类别-->");
		sb.append("<CERT_TYPE_WOMAN>"+ marryInfo.getIdTypeWoman().trim()+"</CERT_TYPE_WOMAN><!—女性证件类别-->");
		
		sb.append("<CARD_MAN>"+ marryInfo.getCertNumMan().trim()+"</CARD_MAN><!—男性证件号码-->");
		sb.append("<CARD_WOMAN>"+ marryInfo.getCertNumWoman().trim()+"</CARD_WOMAN><!—女性证件号码-->");
		
		sb.append("<FOLK_MAN>"+ marryInfo.getFolkMan().trim()+"</FOLK_MAN><!—男性民族-->");
		sb.append("<FOLK_WOMAN>"+ marryInfo.getFolkWoman().trim()+"</FOLK_WOMAN><!—女性民族-->");
		
		sb.append("<REG_DETAIL_MAN>"+ marryInfo.getRegDetailMan().trim()+"</REG_DETAIL_MAN><!—男性户籍地-->");
		sb.append("<REG_DETAIL_WOMAN>"+ marryInfo.getRegDetailWoman().trim()+"</REG_DETAIL_WOMAN><!—女性户籍地-->");
	
		DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
		sb.append("<OP_DATE>"+ format1.format(marryInfo.getOpDate()).trim()+"</OP_DATE><!—登记时间-->");
		sb.append("<OP_TYPE>"+ marryInfo.getOpType().trim()+"</OP_TYPE><!—登记类型-->");
	
		sb.append("<DEPT_CODE>"+marryInfo.getDeptCode().trim()+"</DEPT_CODE><!—登记机关编码-->");
		sb.append("<DEPT_NAME>"+marryInfo.getDeptName().trim()+"</DEPT_NAME><!—登记机关名称-->");
		
		sb.append("</MARRY_RETRUN>");
	}
	  /**
     * 获取客户端IP地址，如调用方的IP，以便检查权限。
     * 适用于axis发布的webservice
     * @return
     */
    public String getClientIpAxis() {
        MessageContext mc = null;
        HttpServletRequest request = null;
        try {
            mc = MessageContext.getCurrentContext();
            if (mc == null)
                throw new Exception("无法获取到MessageContext!");
            request = (HttpServletRequest) mc
                    .getProperty(HTTPConstants.MC_HTTP_SERVLETREQUEST);
            System.out.println("remote  ip:  " + request.getRemoteAddr());
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
        return request.getRemoteAddr();
    }
}
