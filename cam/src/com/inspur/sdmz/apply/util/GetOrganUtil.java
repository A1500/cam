package com.inspur.sdmz.apply.util;

import org.loushang.bsp.security.context.GetBspInfo;
import org.loushang.bsp.share.organization.OrganFactory;
import org.loushang.bsp.share.organization.bean.OrganView;
import org.loushang.bsp.share.organization.provider.IOrganProvider;
import org.loushang.next.data.DataSet;

import com.inspur.sdmz.apply.data.SamApply;


public class GetOrganUtil {

	private static IOrganProvider op = OrganFactory.getIOrganProvider();
	//得到上级单位并返回dataSet
	public static DataSet getParentOrgan(OrganView org) {
		String strOrgName=org.getOrganName();
		String strOrgId=org.getOrganId();
		DataSet ds = new DataSet();
		SamApply samapply=new SamApply();
		
		samapply.setValue(strOrgId);
		samapply.setText(strOrgName);
		ds.addRecord(samapply);
		return ds;
	}
	//得到平级单位并返回dataSet
	public static DataSet getSameOrgan(OrganView[] orgView){
		DataSet ds=new DataSet();
		for(int i=0;i<orgView.length;i++){
			SamApply samapply=new SamApply();
			
			String strOrgName=orgView[i].getOrganName();
			
			String strOrgId=orgView[i].getOrganId();
		
			//判断如果是自己，则不将自己放入DataSet
			if(!(strOrgId.equals(GetBspInfo.getBspInfo().getCorporationOrganId()))){
				samapply.setValue(strOrgId);
				samapply.setText(strOrgName);
				ds.addRecord(samapply);
			}else{
			}
		}
		return ds;
	}
	//得到下级单位并返回dataSet
	public static DataSet getUnderOrgan(OrganView[] orgView){
		DataSet ds=new DataSet();
		for(int i=0;i<orgView.length;i++){
			SamApply samapply=new SamApply();
			String strOrgName=orgView[i].getOrganName();
			String strOrgId=orgView[i].getOrganId();
			samapply.setValue(strOrgId);
			samapply.setText(strOrgName);
			ds.addRecord(samapply);
		}
		return ds;
	}
}
