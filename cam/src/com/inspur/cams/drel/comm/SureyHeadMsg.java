package com.inspur.cams.drel.comm;

import org.loushang.bsp.security.context.BspInfo;
import org.loushang.bsp.security.context.GetBspInfo;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.drel.esurey.domain.ISamEsureyFamilyDomain;
import com.inspur.cams.drel.esurey.domain.ISamEsureyFeedbackDomain;
import com.inspur.cams.drel.surey.comm.domain.ISamSureyWfDomain;
import com.inspur.sdmz.apply.domain.ISamApplyDomain;

public class SureyHeadMsg {
	ISamApplyDomain samapplyDomain = ScaComponentFactory.getService(ISamApplyDomain.class,"SamApplyDomain/SamApplyDomain");
	ISamSureyWfDomain samSureyWfDomain = ScaComponentFactory.getService(ISamSureyWfDomain.class,"SamSureyWfDomain/SamSureyWfDomain");
	ISamEsureyFeedbackDomain esureyFeedBackDomain = ScaComponentFactory.getService(ISamEsureyFeedbackDomain.class, "SamEsureyFeedbackDomain/SamEsureyFeedbackDomain");
	ISamEsureyFamilyDomain esureyFamilyDomain = ScaComponentFactory.getService(ISamEsureyFamilyDomain.class, "SamEsureyFamilyDomain/SamEsureyFamilyDomain");
	//获取业务管理
	public int getApplyNum(String applyType){
		BspInfo bspInfo = GetBspInfo.getBspInfo();
		String currentOrg = bspInfo.getCorporationOrganId();
		return getApplyNum(applyType,currentOrg);
	}
	//获取内部经济核对
	public int getEsureyCheck(String checkOrgArea){
		return getEsureyCheckNum("03","0",checkOrgArea);
	}
	//获取低保低收入核对（市级）
	public int getSureyCityNum(String organArea){
		return getSureyNum("ACT_CITY_SEND,ACT_FILLING,ACT_CITY_CHECK,ACT_CITY_FILLING","TODO,DONE",organArea);
	}
	//获取低保低收入核对待办（区县级民政局）
	public int getSureyDaibanNum(String organArea){
		return getSureyNum("ACT_DISPENSE,ACT_FILLING","TODO",organArea);
	}
	//获取低保低收入核对经办（区县级民政局）
	public int getSureyJingbanNum(String organArea){
		return getSureyNum("ACT_DISPENSE,ACT_CITY_FILLING,ACT_FILLING","DONE",organArea);
	}
	//获取低保低收入核对（区县级经济核对中心）
	public int getSureyCountyNum(String organArea){
		return getSureyNum("ACT_BOROUGH_SEND,ACT_TOWN_REPORT,ACT_CHECK,ACT_DISPENSE,ACT_ISSUE","TODO,TO_OTHER,DONE",organArea);
	}
	//获取市级外部单位经济核对
	public int getCityEsureyOuter(String organIdOuter){
		return getCiryEsureyOuterNum(organIdOuter);
	}
	//获取区县经济核对中心经济核对代办任务
	public int getEsureyCenterNum(String organArea){
		return getEsureyCenterNum("02","0,1",organArea);
	}
	
	private int getApplyNum(String applyType,String currentOrg){
		ParameterSet pset = new ParameterSet();
		pset.setParameter("CURRENT_ORG", currentOrg);
		pset.setParameter("HANDLE_SIGN", "1");
		pset.setParameter("APPLY_TYPE", applyType);
		return samapplyDomain.query(pset).getCount();
	}
	private int getEsureyCheckNum(String curActivity,String curState,String checkOrgArea){
		ParameterSet pset = new ParameterSet();
		pset.setParameter("CUR_ACTIVITY@=", curActivity);
		pset.setParameter("CUR_STATE@=", curState);
		pset.setParameter("CHECK_ORG_AREA@like", checkOrgArea.substring(0,6));
		return esureyFamilyDomain.query(pset).getCount();
	}
	private int getSureyNum(String activity,String status,String organArea){
		ParameterSet pset = new ParameterSet();
		pset.setParameter("CUR_ACTIVITY@in", activity);
		pset.setParameter("CUR_STATUS@in", status);
		pset.setParameter("CUR_ACTIVITY_ORGAN_TYPE@=", "A1");
		pset.setParameter("CUR_ACTIVITY_AREA@=", organArea);
		pset.setParameter("IS_FINISH", "0");
		pset.setParameter("sort","CUR_ACTIVITY_ST");
		pset.setParameter("dir","asc");
		return samSureyWfDomain.initialQuery(pset).getCount();
	}
	
	private int getCiryEsureyOuterNum(String organIdOuter){
		ParameterSet pset = new ParameterSet();
		pset.setParameter("CHECK_ORG_ID@=", organIdOuter);
		pset.setParameter("check_Flg@=", "0");
		return esureyFeedBackDomain.query(pset).getCount();
	}
	/**
	 * 区县经济核对中心
	 * @param curActivity
	 * @param curState
	 * @param checkOrgArea
	 * @return
	 */
	private int getEsureyCenterNum(String curActivity,String curState,String checkOrgArea){
		ParameterSet pset = new ParameterSet();
		pset.setParameter("CUR_ACTIVITY@=", curActivity);
		pset.setParameter("CUR_STATE@in", curState);
		pset.setParameter("FAMILY_ADDRESS@like", checkOrgArea.substring(0,6));
		return esureyFamilyDomain.query(pset).getCount();
	}
}
