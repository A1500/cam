package com.inspur.cams.dataexchange.util;

import org.loushang.ws.AxisFault;
import org.loushang.ws.addressing.EndpointReference;
import org.loushang.ws.client.Options;
import javax.xml.namespace.QName;
import org.loushang.ws.rpc.client.RPCServiceClient;
import com.inspur.cams.drel.mbalance.data.OperationReturn;

public class MyClient {
	public static void main(String[] args) {
		try {
			RPCServiceClient serviceClient = new RPCServiceClient();
	        Options options = serviceClient.getOptions();

			// 指定调用WebService的URL
			EndpointReference targetEPR = new EndpointReference("http://10.60.0.50/sdcams/services/DataExChangeMarry.DataExChangeMarry");
			options.setTo(targetEPR);
			options.setAction("getMarryLastInfoByCert");
			
			Object[] opAddEntryArgs = new Object[] {"SJJH","1","370123198605014713",""};
			Class[] classes = new Class[] { String.class };
			// 指定要调用的queryInsurance方法及WSDL文件的命名空间

			QName opAddEntry = new QName("http://loushang.ws","getMarryLastInfoByCert");
			// 调用queryInsurance方法
			String infoXML = (String)serviceClient.invokeBlocking(opAddEntry, opAddEntryArgs,
					classes)[0];
			System.out.println("infoXML="+infoXML);
		} catch (AxisFault e) {
			e.printStackTrace();
		}
	}
}
