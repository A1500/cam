package com.inspur.sdmz.comm.util;

import org.loushang.bsp.security.context.GetBspInfo;
import org.loushang.bsp.share.organization.OrganFactory;
import org.loushang.bsp.share.organization.bean.OrganView;
import org.loushang.bsp.share.organization.bean.StruView;
import org.loushang.bsp.share.organization.provider.IOrganProvider;

public class BspUtil {

	private static IOrganProvider op = OrganFactory.getIOrganProvider();
	
	public static String getCorpOrganId() {
		return GetBspInfo.getBspInfo().getCorporationOrganId();
	}
	
	public static OrganView getCorpOrgan() {
		return op.getOrganByOrganId(getCorpOrganId());
	}
	
	public static String getDeptOrganId() {
		return GetBspInfo.getBspInfo().getDepartmentOrganId();
	}
	
	public static OrganView getDeptOrgan() {
		return op.getOrganByOrganId(getDeptOrganId());
	}
	
	public static String getEmpOrganId() {
		return GetBspInfo.getBspInfo().getEmployeeOrganId();
	}
	
	public static OrganView getEmpOrgan() {
		return op.getOrganByOrganId(getEmpOrganId());
	}
	public static String getStruId() {
		String organId = GetBspInfo.getBspInfo().getCorporationOrganId();
		IOrganProvider op = OrganFactory.getIOrganProvider();
		StruView[] struV = op.getListByOrganId(organId);
		String struId = ((StruView)struV[0]).getStruId();
		return struId;
	}
	public static OrganView getParentOrgan(){
		return op.getOrganByOrganId(op.getListByOrganId(GetBspInfo.getBspInfo().getCorporationOrganId())[0].getParentId());
	}
	public static OrganView[] getSameOrgan(){
		return op.getUnderLingByOrganId(op.getListByOrganId(GetBspInfo.getBspInfo().getCorporationOrganId())[0].getParentId(),"1","00");
	}
	public static OrganView[] getUnderOrgan(){
		return op.getUnderLingByOrganId(GetBspInfo.getBspInfo().getCorporationOrganId(),"2","00");
	}
}
