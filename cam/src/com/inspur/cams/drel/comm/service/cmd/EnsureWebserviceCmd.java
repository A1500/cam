package com.inspur.cams.drel.comm.service.cmd;


import javax.xml.namespace.QName;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.ws.addressing.EndpointReference;
import org.loushang.ws.client.Options;
import org.loushang.ws.rpc.client.RPCServiceClient;

import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.drel.sam.dao.ISamApplyInfoDao;

/**
 * @Package com.inspur.cams.comm.webService.cmd;
 * @Description: TODO 数据导出cmd
 * @author Kin
 * @date 2012-3-29
 */
public class EnsureWebserviceCmd extends BaseAjaxCommand {
	ISamApplyInfoDao samApplyInfoDao = (ISamApplyInfoDao) DaoFactory.getDao("com.inspur.cams.drel.sam.dao.jdbc.SamApplyInfoDao");
	
//	private IEnsureWebserviceDomain ensureWebserviceDomain = ScaComponentFactory
//			.getService(IEnsureWebserviceDomain.class, "EnsureWebserviceDomain/EnsureWebserviceDomain");
	
	public static String TOMCAT_DRIVER = ""; 
	public static String ENSURE_WS = "http://10.72.12.56:8088/ensure/services/ensureImportService.ensureImportService?wsdl";
//	public static String ENSURE_WS = "http://192.168.1.113:9090/cam/services/FisFuneralImportService.FisFuneralImportService?wsdl";
	public static String DEFAULT_NAMESPACE = "http://loushang.ws";

	
	/**
	 * @Description: 连接服务器，获取信息
	 * @author Kin
	 */
	public void networkedConect() {
		
		// 检查网络是否通畅
		String returnInfo = ifConnect(DateUtil.getTime());
		if (returnInfo == "0") {
			setReturn("error", "F");
			setReturn("message", "未连接到服务器，请查看网络!");
			return;
		}
		if (returnInfo == "1") {
			setReturn("error", "T");
			setReturn("message", "已连接到服务器!");
			return;
		}
		setReturn("message", "已连接到服务器!");
		setReturn("error", "T");
	}



	/**
	 * @Description: 检查上报网路是否通畅
	 * @author Kin
	 */
	private String ifConnect(String clientTime) {
		
		String xml = queryExport();
		RPCServiceClient serviceClient = null;
		String returnFlag="0";
		try {
			serviceClient = new RPCServiceClient();
			Options options = serviceClient.getOptions();
			options.setAction("testConnect");
			serviceClient.setOptions(options);

			// 指定调用WebService的URL
			EndpointReference targetEPR = new EndpointReference(ENSURE_WS);
			options.setTo(targetEPR);

			// 指定ifConnect方法的参数值
			Object[] opAddEntryArgs = new Object[] { xml };

			// 指定ifConnect方法返回值的数据类型的Class对象
			Class[] classes = new Class[] { String.class };

			// 指定要调用的ifConnect方法及WSDL文件的命名空间
			QName opAddEntry = new QName(DEFAULT_NAMESPACE, "testConnect");

			// 调用ifConnect方法
			returnFlag = (String)serviceClient.invokeBlocking(opAddEntry, opAddEntryArgs, classes)[0];
			return returnFlag;
		} catch (Exception e) {
			e.printStackTrace();
			e.getStackTrace();
		} finally {
			// 释放资源
			try {
				if (serviceClient != null) {
					serviceClient.cleanup();
					serviceClient.cleanupTransport();
				}
			} catch (Exception e) {
			}
		}
		return returnFlag;
	}
	public String queryExport(){
		ParameterSet pset = getParameterSet();
		return samApplyInfoDao.exportToXml(pset);
	}
}